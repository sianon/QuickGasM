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
#include "camera.h"
cv::Mat oQImage2Mat(const QImage& image){
    cv::Mat mat;
    int height, width;
    float ratio;
    switch(image.format()){
        case QImage::Format_Grayscale8:
            mat = cv::Mat(image.height(), image.width(), CV_8UC1, (void*) image.constBits(), image.bytesPerLine());
            break;
        case QImage::Format_ARGB32:
        case QImage::Format_RGB32:
        case QImage::Format_ARGB32_Premultiplied:{
            mat = cv::Mat(image.height(), image.width(), CV_8UC4, (void*) image.constBits(), image.bytesPerLine());
            std::vector<cv::Mat> channels;
            split(mat, channels);
            channels.pop_back();
            cv::merge(channels, mat);
            return mat;
        }
        case QImage::Format_RGB888:
        case QImage::Format_RGBA8888:
            mat = cv::Mat(image.height(), image.width(), CV_8UC4, (void*) image.constBits(), image.bytesPerLine());
            return mat.clone();
            break;
        case QImage::Format_RGBA64:
            mat = cv::Mat(image.height(), image.width(), CV_16UC4, (void*) image.constBits(), image.bytesPerLine());
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

    setFormat(video_frame.width(), video_frame.height(), video_frame.pixelFormat());
    if(m_surface)
        m_surface->present(video_frame);
}

void FrameProvider::mvSetRanderMode(QString mode){
    qDebug() << "set render mode:" << mode;
    if(mode.isEmpty() || mode == "white"){
        render_type_ = VIDEO_TYPE_WHITE;
    }else if(mode == "infrared"){
        render_type_ = VIDEO_TYPE_THERMAL;
    }else if(mode == "PIP"){
        render_type_ = VIDEO_PIP;
    }else if(mode == "detail_enhance"){
        render_type_ = VIDEO_ENHANCE;
    }else{
        render_type_ = VIDEO_TYPE_THERMAL;
    }

}

Q_INVOKABLE void FrameProvider::mvSwitchGasDectect(QString on_off)
{
    qDebug()<<"switch gas detect:"<<on_off;
    return Q_INVOKABLE void();
}

Q_INVOKABLE void FrameProvider::mvSwitchGasSplit(QString on_off)
{
    qDebug()<<"switch gas split:"<<on_off;
    return Q_INVOKABLE void();
}

Q_INVOKABLE void FrameProvider::mvSwitchConcentrationDistri(QString on_off)
{
    qDebug()<<"switch concentrations distri:"<<on_off;
    return Q_INVOKABLE void();
}

Q_INVOKABLE void FrameProvider::mvSwitchCloudGasEnhance(QString on_off)
{
    qDebug()<<"switch cloud gas enhance:"<<on_off;
    return Q_INVOKABLE void();
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
    QImage res_img(roi.data, roi.cols, roi.rows, QImage::Format_RGBA8888);
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
    qDebug()<<"snapshot";
    using namespace cv;
    if(render_type_ != VIDEO_TYPE_WHITE){;
        QImage res;
        cv::Mat src, im_color;
        src = current_src_mat_;

        QImage res_img(src.data, src.cols, src.rows, QImage::Format_RGBA8888);
        snap_shot_img_ = res_img.copy();

        {
            auto now = std::chrono::system_clock::now();
            std::time_t now_c = std::chrono::system_clock::to_time_t(now);

            char timeString[100];
            std::strftime(timeString, sizeof(timeString), "%Y%m%d%H%M%S", std::localtime(&now_c));
            strcat(timeString, ".jpg");

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

Q_INVOKABLE void FrameProvider::mvSwitchDisplayTDLAS(QString on_off)
{
    qDebug()<<"switch Display TDLAS:"<<on_off;
    return Q_INVOKABLE void();
}

Q_INVOKABLE bool FrameProvider::mbFactoryReset()
{
    qDebug()<<"------factory reset------";
    return Q_INVOKABLE bool();
}

Q_INVOKABLE bool FrameProvider::mbSearchUpgradeFile()
{
    qDebug()<<"------mbSearchUpgradeFile------";
    return true;
}

Q_INVOKABLE QString FrameProvider::msGetSysVersion(int index)
{
    qDebug()<<"------get sys version:------"<<index;
    //0:序列号
    //1:设备版本
    //2:主控版本
    //3:算法版本
    //4:模型版本
    //5:系统软件版本
    //6:系统版本
    return "v1.0.0";
}

Q_INVOKABLE void FrameProvider::mvSetScreenLvl(QString lvl)
{
    qDebug() << "------mvSetScreenLvl:" << lvl;
    return Q_INVOKABLE void();
}

Q_INVOKABLE bool FrameProvider::mbFormatTF()
{
    qDebug()<<"------format tf------";
    return true;
}

Q_INVOKABLE void FrameProvider::mvSetScreenLvl(int lvl)
{
    qDebug() << "------mvSetScreenLvl:" << lvl;
    return Q_INVOKABLE void();
}

Q_INVOKABLE void FrameProvider::mvSetTmpUnit(QString val)
{
    qDebug() << "------mvSetTmpUnit:" << val;
    return Q_INVOKABLE void();
}

Q_INVOKABLE void FrameProvider::mvSetDistanceUnit(QString val)
{
    qDebug() << "------mvSetDistanceUnit:" << val;
    return Q_INVOKABLE void();
}

Q_INVOKABLE void FrameProvider::mvSetEnvTemp(QString val)
{
    qDebug() << "------mvSetEnvTemp:" << val;
    return Q_INVOKABLE void();
}

Q_INVOKABLE void FrameProvider::mvSetEnvhumidity(QString val)
{
    qDebug() << "------mvSetEnvhumidity:" << val;
    return Q_INVOKABLE void();
}

Q_INVOKABLE void FrameProvider::mvSetDistance(QString val)
{
    qDebug() << "------mvSetDistance:" << val;
    return Q_INVOKABLE void();
}

Q_INVOKABLE void FrameProvider::mvSetEmissivity(QString val)
{
    qDebug() << "------mvSetEmissivity:" << val;
    return Q_INVOKABLE void();
}

void FrameProvider::mvCallBackMsg(QString cmd)
{
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

void FrameProvider::mvRefeshFileList(QString cmd){
    media_file_manage_.mvRefreshFileList("");
}

void FrameProvider::mvDeleteFile(QString path){
    qDebug() << "delete file:" << path;
    media_file_manage_.mvDeleteFile(path);
}

QStringList FrameProvider::moGetFilePaths(){
    return media_file_manage_.moGetFilePaths();
}

void FrameProvider::mvPreviewMediaByPath(QString path){
    media_file_preview_.mvPreviewMediaByPath(path);
}

void FrameProvider::mvStopPreviewMediaByPath(QString path){
    media_file_preview_.mvStop();
}

void FrameProvider::mvPlayPreviewMediaByPath(QString path){
    media_file_preview_.mvPlay();
}

QString FrameProvider::mvGetVideoThumbnailByPath(QString path){
    QMap<QString, QString> file_map = media_file_manage_.mobGetVideoThumbnailList();

    if(!file_map.contains(path)){
        return "";
    }

    return file_map.value(path);
}

QString FrameProvider::mobGetStorageInfo(){
    return QString("{ \"used\":18, \"total\":28, \"free\": 38}");
}
