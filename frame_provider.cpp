#include "frame_provider.h"
#include <QImage>
#include <QPainter>
#include <QDateTime>
#include <QRandomGenerator>
#include <QVideoFrame>
#include <QDebug>
#include <opencv2/imgproc.hpp>
#include <chrono>
#include <ctime>
#include <QQmlComponent>
#include <QQuickWindow>
#include <QQuickItem>
#include <QQuickView>
#include <fstream>
#include "video_dlg.h"
#include "video_hub.h"
#include "common.h"

cv::Mat oQImage2Mat(const QImage& image){
    cv::Mat mat;
    int height, width;
    float ratio;
    switch(image.format()){
        case QImage::Format_Grayscale8:
            mat = cv::Mat(image.height(), image.width(), CV_8UC1, (void*) image.constBits(), image.bytesPerLine());
            break;
        case QImage::Format_ARGB32: // uint32存储0xAARRGGBB，pc一般小端存储低位在前，所以字节顺序就成了BGRA
        case QImage::Format_RGB32: // Alpha为FF
            //    case QImage::Format_ARGB32_Premultiplied:
            //        mat = cv::Mat(image.height(), image.width(), CV_8UC4, (void*)image.constBits(), image.bytesPerLine());
            //        break;
        case QImage::Format_ARGB32_Premultiplied:{
            mat = cv::Mat(image.height(), image.width(), CV_8UC4, (void*) image.constBits(), image.bytesPerLine());
            std::vector<cv::Mat> channels;
            split(mat, channels);
            channels.pop_back();
            cv::merge(channels, mat);
            return mat;
        }
        case QImage::Format_RGB888: // RR,GG,BB字节顺序存储
        case QImage::Format_RGBA8888:
            mat = cv::Mat(image.height(), image.width(), CV_8UC4, (void*) image.constBits(), image.bytesPerLine());
            return mat.clone();
            break;
        case QImage::Format_RGBA64: // uint64存储，顺序和Format_ARGB32相反，RGBA
            mat = cv::Mat(image.height(), image.width(), CV_16UC4, (void*) image.constBits(), image.bytesPerLine());
            // opencv需要转为BGRA的字节顺序
            cv::cvtColor(mat, mat, cv::COLOR_RGBA2BGRA);
            break;

        case QImage::Format_Mono:
        case QImage::Format_MonoLSB:{
            QImage rgbImage = image.convertToFormat(QImage::Format_Grayscale8);
            return cv::Mat(rgbImage.height(), rgbImage.width(), CV_8UC1, (void*) rgbImage.bits(),
                           rgbImage.bytesPerLine()).clone();
        }
        case QImage::Format_Indexed8:{
            mat = cv::Mat(image.height(), image.width(), CV_8UC1, (void*) image.constBits(), image.bytesPerLine());
            return mat.clone();
        }
        default:
            return mat;
    }
    //    int x, y;
    //    height = image.height() * ratio;
    //    width = image.width() * ratio;
    //
    //    x = (image.width() - width) / 2;
    //    y = (image.height() - height) / 2;
    //
    //    cv::Mat roi(mat, cv::Rect(x, y, width, height));
    return mat;
}

FrameProvider::FrameProvider() : render_type_(VIDEO_TYPE_WHITE), audio_buf_(0){

}

FrameProvider::~FrameProvider(){

}

QAbstractVideoSurface* FrameProvider::videoSurface() const{
    return m_surface;
}

void FrameProvider::setVideoSurface(QAbstractVideoSurface* surface){
    if(m_surface && m_surface != surface && m_surface->isActive()){
        m_surface->stop();
    }

    m_surface = surface;

    if(m_surface && m_format.isValid()){
        m_format = m_surface->nearestFormat(m_format);
        m_surface->start(m_format);
    }
}

void FrameProvider::setFormat(int width, int heigth, QVideoFrame::PixelFormat format){
    QSize size(width, heigth);
    QVideoSurfaceFormat vsformat(size, format);
    m_format = vsformat;

    if(m_surface){
        if(m_surface->isActive()){
            m_surface->stop();
        }
        m_format = m_surface->nearestFormat(m_format);
        m_surface->start(m_format);
    }
}

void FrameProvider::test(){
    int plane = 0;
    QImage image(800, 480, QImage::Format_ARGB32);
    QImage image_tmp(800, 480, QImage::Format_ARGB32);
    image.fill(QColor::fromRgb(QRandomGenerator::global()->generate()));
    QFont font;
    font.setPointSize(25);
    image = VideoHub::moGetInstance()->moGetVideoFromQueue(render_type_);

    if(image.isNull()) return;
    //    if(scale_ratio_ < 1){
    mvScaleImage(image);
    //    }
    QVideoFrame video_frame(image);

    //按照视频帧设置格式
    setFormat(video_frame.width(), video_frame.height(), video_frame.pixelFormat());
    if(m_surface)
        m_surface->present(video_frame);
}

void FrameProvider::onNewVideoContentReceived(const QVideoFrame& frame){
    int plane = 0;
    QImage image(640, 480, QImage::Format_ARGB32);
    image.fill(QColor::fromRgb(QRandomGenerator::global()->generate()));
    QFont font;
    font.setPointSize(25);

    QPainter painter(&image);
    painter.setFont(font);
    painter.drawText(image.rect(), Qt::AlignCenter, QDateTime::currentDateTime().toString());
    painter.end();

    QVideoFrame video_frame(image);
    video_frame.unmap();

    //按照视频帧设置格式
    setFormat(video_frame.width(), video_frame.height(), video_frame.pixelFormat());
    if(m_surface)
        m_surface->present(video_frame);
}

void FrameProvider::mvSetRanderMode(){
    if(render_type_ == VIDEO_TYPE_WHITE)
        render_type_ = VIDEO_TYPE_THERMAL;
    else
        render_type_ = VIDEO_TYPE_WHITE;
}

QImage FrameProvider::mvScaleImage(QImage& image){
    if(image.isNull()) return QImage();

    using namespace cv;
    int height, width;
    float ratio = scale_ratio_;
    Mat src, res, dest, rgba_roi, roi;

    src = oQImage2Mat(image);
    current_src_mat_ = src;
    roi = src;

    if(!src.data){
        printf("could not load image...\n");
        return QImage();
    }

    if(scale_ratio_ < 1){
        dest = Mat::zeros(480, 800, CV_8UC4);
        int x, y;
        height = image.height() * ratio;
        width = image.width() * ratio;
        x = (image.width() - width) / 2;
        y = (image.height() - height) / 2;

        cv::Mat tmp_roi(src, cv::Rect(x, y, width, height));

        resize(tmp_roi, dest, dest.size(), cv::INTER_LINEAR);
        roi = tmp_roi;
    }

    Mat im_color;
    if(render_type_ == VIDEO_TYPE_THERMAL && color_setting_.meGetCurrentColorType() != COLOR_TYPE_NULL){
        cv::cvtColor(roi, roi, cv::COLOR_BGRA2GRAY);
        auto color_template = COLORMAP_HOT;
        switch(color_setting_.meGetCurrentColorType()){
            case COLOR_TYPE_IRON_RED:{
                color_template = COLORMAP_INFERNO;
            }
                break;
            case COLOR_TYPE_BLACK_WITHE:{
                color_template = COLORMAP_BONE;
            }
                break;
            case COLOR_TYPE_RAINBOW:{
                color_template = COLORMAP_RAINBOW;
            }
                break;
            default:
                color_template = COLORMAP_HOT;
        }

        applyColorMap(roi, im_color, color_template);
        cv::cvtColor(im_color, im_color, cv::COLOR_RGB2RGBA);
    }else{
        cv::cvtColor(roi, im_color, cv::COLOR_RGB2RGBA);
    }

    QImage res_img(im_color.data, roi.cols, roi.rows, QImage::Format_RGBA8888);
    image = res_img.copy();

    return QImage();
}

void FrameProvider::mvSetScaleRatio(float ratio){
    scale_ratio_ = ratio;
}

void FrameProvider::mvZoomIn(){
    if(scale_ratio_ <= 0.1f)
        return;
    scale_ratio_ -= 0.1;
}

void FrameProvider::mvZoomOut(){
    if(scale_ratio_ > 1.0f)
        return;
    scale_ratio_ += 0.1;
}

bool FrameProvider::mbSnapShot(){
    using namespace cv;
    if(render_type_ != VIDEO_TYPE_WHITE){
        //        QImage image = VideoHub::moGetInstance()->moGetVideoFromQueue(VIDEO_TYPE_THERMAL);
        QImage res;
        //        if(image.isNull()){
        //            cout << "no frame" << endl;
        //            return false;
        //        }
        cv::Mat src, im_color;
        src = current_src_mat_;

        if(render_type_ == VIDEO_TYPE_THERMAL && color_setting_.meGetCurrentColorType() != COLOR_TYPE_NULL){
            cv::cvtColor(src, src, cv::COLOR_BGRA2GRAY);
            auto color_template = COLORMAP_HOT;
            switch(color_setting_.meGetCurrentColorType()){
                case COLOR_TYPE_IRON_RED:{
                    color_template = COLORMAP_INFERNO;
                }
                    break;
                case COLOR_TYPE_BLACK_WITHE:{
                    color_template = COLORMAP_BONE;
                }
                    break;
                case COLOR_TYPE_RAINBOW:{
                    color_template = COLORMAP_RAINBOW;
                }
                    break;
                default:
                    color_template = COLORMAP_HOT;
            }

            applyColorMap(src, im_color, color_template);
            cv::cvtColor(im_color, im_color, cv::COLOR_BGR2RGBA);
        }else{
            cv::cvtColor(src, im_color, cv::COLOR_RGB2RGBA);
        }

        QImage res_img(im_color.data, im_color.cols, im_color.rows, QImage::Format_RGBA8888);
        snap_shot_img_ = res_img.copy();

        {
            auto now = std::chrono::system_clock::now();
            std::time_t now_c = std::chrono::system_clock::to_time_t(now);

            char timeString[100];
            std::strftime(timeString, sizeof(timeString), "%Y%m%d%H%M%S", std::localtime(&now_c));
            strcat(timeString, ".jpg");

            //        QQmlComponent component(&engine, QUrl(QStringLiteral("qrc:/color_setting_dlg.qml")));

            //        QObject* dialogItem = qobject_cast<QObject*>(component.create());
            //
            //        dialogItem->setParent((QQuickWindow*)engine.rootObjects().first());
            //        if (dialogItem) {
            //            dialogItem->setProperty("visible", true);
            ////            dialogItem->show();
            //            QEventLoop loop;
            //            QObject::connect(dialogItem, SIGNAL(closed()), &loop, SLOT(quit()));
            //            loop.exec();
            //        } else {
            //            qWarning() << "Failed to cast dialog object to QQuickItem";
            ////            delete dialogObject;
            //        }

            QEventLoop loop;
            QObject::connect(this, &FrameProvider::mvSnapOver, &loop, &QEventLoop::quit);

            QQmlApplicationEngine& engine = QmlEngineSingleton::instance();
            QObject* rootObject = engine.rootObjects().first();
            QVariant ret_msg;
            QMetaObject::invokeMethod(rootObject, "showLsDialog", Qt::DirectConnection,
                                      Q_RETURN_ARG(QVariant, ret_msg));

            loop.exec();

            if(cmd_ == "cancel"){
                return false;
            }

            snap_shot_img_.save(timeString, "jpg", 100);

            fstream file;
            file.open(timeString, ios::app | ios::binary);

            //#ifdef _DEBUG
            fstream tmp_file;
            tmp_file.open("sample4.aac", ios::in | ios::binary);
            tmp_file.seekg(0, std::ios::end);
            std::streampos fileSize = tmp_file.tellg();
            tmp_file.seekg(0, std::ios::beg);

            audio_buf_size_ = fileSize;
            audio_buf_ = new char[fileSize];
            tmp_file.read(audio_buf_, fileSize);

            tmp_file.close();
            //#endif

            if(cmd_ == "record_voice_done"){
                //stop record audio
                file.write(audio_buf_, audio_buf_size_);
                file.close();
            }
            delete[] audio_buf_;
        }
        return false;
    }
}

QString FrameProvider::moGetDialogRes(){
    emit mvSnapOver();

    return QString();
}

void FrameProvider::mvCallBackMsg(QString cmd){
    cmd_ = cmd;
    emit mvSnapOver();
}

void FrameProvider::mvSetAudioBuf(char* src, size_t size){
    audio_buf_ = src;
    audio_buf_size_ = size;
}

void FrameProvider::mvStartRecordAudio(QString cmd){
    qDebug() << "start record";
}
