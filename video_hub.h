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
#include "common.h"

class RingBuffer;

class VideoHub{
public:
    static VideoHub* moGetInstance(){
        std::lock_guard<std::mutex> lock(mutex_);

        if(!instance_){
            instance_ = new VideoHub();
        }
        return instance_;
    }

    void mvPushVideo2Queue(VideoType type, QImage image){
        QImage img = image.copy();

    }

    QImage moGetVideoFromQueue(VideoType type){

        QImage tmp;

        return tmp;
    }

    VideoHub(const VideoHub&) = delete;

    VideoHub& operator=(const VideoHub&) = delete;
private:
    VideoHub(){
    }

    //    RingBuffer<QImage> white_video_queue_;
    //    RingBuffer<QImage> thermal_video_queue_;
    //    RingBuffer<QImage> mix_video_queue_;
    static VideoHub* instance_;
    static std::mutex mutex_;
};

#endif //QUICKGAS_VIDEO_HUB_H
