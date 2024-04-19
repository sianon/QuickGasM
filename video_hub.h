//
// Created by Chian on 4/2/2024.
//

#ifndef QUICKGAS_VIDEO_HUB_H
#define QUICKGAS_VIDEO_HUB_H

#include <iostream>
#include <mutex>
#include <unordered_map>
#include <queue>
#include <QImage>
#include <string>
#include <QDebug>
#include <opencv4/opencv2/opencv.hpp>
#include <chrono>
#include <thread>
#include <string>

#include "common.h"
#include "ring_buffer.h"

//class RingBuffer;
using namespace std;

class VideoHub{
public:
    static VideoHub* moGetInstance(){
        std::lock_guard<std::mutex> lock(mutex_);

        if(!instance_){
            instance_ = new VideoHub();
        }

        return instance_;
    }

    int mvTest(VideoType ens, string file_name){
        cv::VideoCapture cap(file_name);

        if(!cap.isOpened()){
            std::cerr << "Error: Unable to open video file" << std::endl;
            return -1;
        }

        cv::Mat frame, rgbMat;
        int frame_count = 0;

        while(true){
            if(!cap.read(frame)){
                cap.set(cv::CAP_PROP_POS_FRAMES, 0);
                continue;
            }
            std::this_thread::sleep_for(std::chrono::milliseconds(40));
            if(frame.empty()){
                std::cout << "Video reached end." << std::endl;
                break;
            }

            cv::cvtColor(frame, rgbMat, cv::COLOR_BGR2RGBA);

            QImage img(rgbMat.data, rgbMat.cols, rgbMat.rows, QImage::Format_RGBA8888);
            mvPushVideo2Queue(ens, img.rgbSwapped());
        }
        cap.release();
    }

    void mvPushVideo2Queue(VideoType type, QImage image){
        QImage img = image.copy();
        bool enqueue_res = true;
//        qDebug()<<"width:"<<img.width()<<"height:"<<img.height();
        switch(type){
            case VIDEO_TYPE_THERMAL:{
                enqueue_res = thermal_video_queue_.enqueue(img);
                if(!enqueue_res)thermal_video_queue_.dequeue(img);
            }break;
            case VIDEO_TYPE_MIX:{
                enqueue_res = mix_video_queue_.enqueue(img);
                if(!enqueue_res)mix_video_queue_.dequeue(img);
            }break;
            default:{
                enqueue_res = white_video_queue_.enqueue(img);
                if(!enqueue_res)mix_video_queue_.dequeue(img);
            }break;
        }

    }

    QImage moGetVideoFromQueue(VideoType type){
        QImage res;
        switch(type){
            case VIDEO_TYPE_THERMAL:{
                thermal_video_queue_.dequeue(res);
            }break;
            case VIDEO_TYPE_MIX:{
                mix_video_queue_.dequeue(res);
            }break;
            default:{
                white_video_queue_.dequeue(res);
            }break;
        }
//        qDebug()<<"width:"<<res.width()<<"height:"<<res.height();
        return res;
    }

    VideoHub(const VideoHub&) = delete;

    VideoHub& operator=(const VideoHub&) = delete;
private:
    VideoHub(){}

    RingBuffer<QImage> white_video_queue_;
    RingBuffer<QImage> thermal_video_queue_;
    RingBuffer<QImage> mix_video_queue_;
    static VideoHub* instance_;
    static std::mutex mutex_;
};

#endif //QUICKGAS_VIDEO_HUB_H
