//
// Created by cao on 24-4-15.
//

#ifndef MEDIA_FIELE_MANAGE_H
#define MEDIA_FIELE_MANAGE_H

#include <QObject>
#include <QVector>
#include <QDir>
#include <fstream>
extern "C" {
#include <libavformat/avformat.h>
#include <libavcodec/avcodec.h>
#include <libswscale/swscale.h>
#include <libavutil/imgutils.h>
}
#include "common.h"

class MediaFileManage : public QObject{
Q_OBJECT
public:
    explicit MediaFileManage(QObject* parent = nullptr) : media_file_list_(){
    }

    ~MediaFileManage(){
    }

    void mvDeleteFile(QString file_path){
        if(file_path.isEmpty() || !QFile::exists(file_path)){
            return;
        }

        QFile::remove(file_path);
        media_file_list_.removeOne(file_path);

        //        auto tmp = std::find(media_file_list_.begin(), media_file_list_.end(), file_path);
    }

    QStringList moGetFilePaths(){
        return media_file_list_;
    }

    QMap<QString, QString> mvGetVideoThumbnail(){
        return video_thumbnail_list_;
    }

    bool mvGenVideoThumbnail(QString mp4_path){
        if(media_file_list_.empty() || video_thumbnail_list_.contains(mp4_path))
            return false;
        qDebug()<<mp4_path;
        std::string tmp = mp4_path.toStdString();
        const char* input_file = tmp.c_str();
        QFileInfo fileInfo(input_file);
        AVFormatContext* format_ctx = nullptr;
        if(avformat_open_input(&format_ctx, input_file, nullptr, nullptr) != 0){
            std::cerr << "Could not open input file " << input_file << "\n";
            return false;
        }

        if(avformat_find_stream_info(format_ctx, nullptr) < 0){
            std::cerr << "Could not find stream information\n";
            return false;
        }

        int video_stream_index = -1;
        AVCodecParameters* codec_params = nullptr;
        for(unsigned int i = 0; i < format_ctx->nb_streams; i++){
            if(format_ctx->streams[i]->codecpar->codec_type == AVMEDIA_TYPE_VIDEO){
                video_stream_index = i;
                codec_params = format_ctx->streams[i]->codecpar;
                break;
            }
        }

        if(video_stream_index == -1){
            std::cerr << "Could not find video stream\n";
            return false;
        }

        AVCodec* codec = avcodec_find_decoder(codec_params->codec_id);
        if(!codec){
            std::cerr << "Unsupported codec\n";
            return false;
        }

        AVCodecContext* codec_ctx = avcodec_alloc_context3(codec);
        if(!codec_ctx){
            std::cerr << "Could not allocate video codec context\n";
            return false;
        }

        if(avcodec_parameters_to_context(codec_ctx, codec_params) < 0){
            std::cerr << "Could not copy codec parameters to codec context\n";
            return false;
        }

        if(avcodec_open2(codec_ctx, codec, nullptr) < 0){
            std::cerr << "Could not open codec\n";
            return false;
        }

        AVFrame* frame = av_frame_alloc();
        AVPacket* packet = av_packet_alloc();
        int response;

        while(av_read_frame(format_ctx, packet) >= 0){
            if(packet->stream_index == video_stream_index){
                response = avcodec_send_packet(codec_ctx, packet);
                if(response >= 0){
                    response = avcodec_receive_frame(codec_ctx, frame);
                    if(response >= 0){
                        SwsContext* sws_ctx = sws_getContext(frame->width, frame->height, codec_ctx->pix_fmt, frame->width,
                                                             frame->height, AV_PIX_FMT_RGB24, SWS_BILINEAR, nullptr,
                                                             nullptr, nullptr);

                        AVFrame* rgb_frame = av_frame_alloc();
                        int num_bytes = av_image_get_buffer_size(AV_PIX_FMT_RGB24, frame->width, frame->height, 1);
                        uint8_t* buffer = (uint8_t*) av_malloc(num_bytes * sizeof(uint8_t));
                        av_image_fill_arrays(rgb_frame->data, rgb_frame->linesize, buffer, AV_PIX_FMT_RGB24, frame->width,
                                             frame->height, 1);

                        sws_scale(sws_ctx, frame->data, frame->linesize, 0, frame->height, rgb_frame->data,
                                  rgb_frame->linesize);

                        QImage img(rgb_frame->data[0], frame->width, frame->height,rgb_frame->linesize[0], QImage::Format_RGB888);

                        QDir current_dir = QDir::current();

                        if(!current_dir.exists("thumbnails")){
                            current_dir.mkdir("thumbnails");
                        }

                        QString din = current_dir.absolutePath();
                        QString file_name = din + "/thumbnails/" + fileInfo.baseName() + ".jpg";
                        qDebug()<<file_name;

                        if(!QFile::exists(file_name)){
                            auto res = img.save(file_name);
                        }

                        video_thumbnail_list_.insert(mp4_path, file_name);

                        av_free(buffer);
                        av_frame_free(&rgb_frame);
                        sws_freeContext(sws_ctx);
                        break;
                    }
                }
            }
            av_packet_unref(packet);
        }

        av_frame_free(&frame);
        av_packet_free(&packet);
        avcodec_free_context(&codec_ctx);
        avformat_close_input(&format_ctx);

        //insert video_thumbnail_list_
        return true;
    }

    void mvRefreshFileList(QString path){
        QDir dir("/home/cao/");
        media_file_list_.clear();

        dir.setFilter(QDir::Files | QDir::Dirs | QDir::NoDotAndDotDot);
        dir.setNameFilters(QStringList() << "*.png" << "*.mp4");
        dir.setSorting(QDir::Name);

        QFileInfoList file_list = dir.entryInfoList();
                foreach (const QFileInfo& file, file_list){
                    if(file.suffix().toLower() == "mp4"){
                        mvGenVideoThumbnail(file.absoluteFilePath());
                    }
                media_file_list_.push_back(file.absoluteFilePath());
            }
    }

    QMap<QString, QString> mobGetVideoThumbnailList(){
        return video_thumbnail_list_;
    }

private:
    QStringList media_file_list_;
    QString root_path_;
    QMap<QString, QString> video_thumbnail_list_;
};

#endif //MEDIA_FIELE_MANAGE_H
