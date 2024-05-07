//
// Created by cao on 24-4-17.
//

#ifndef QUICK_DEMO_COMMON_H
#define QUICK_DEMO_COMMON_H

#include <stdio.h>
#include <pthread.h>
#include <unistd.h>
#include <stdlib.h>
#include <opencv2/opencv.hpp>
#include <QImage>

#define CAS(a_ptr, a_oldVal, a_newVal) __sync_bool_compare_and_swap(a_ptr, a_oldVal, a_newVal)

enum VideoType{
    VIDEO_TYPE_WHITE = 0,
    VIDEO_TYPE_THERMAL,
    VIDEO_TYPE_MIX
};

enum ColorType{
    COLOR_TYPE_NULL = 0,
    COLOR_TYPE_IRON_RED,
    COLOR_TYPE_BLACK_WITHE,
    COLOR_TYPE_RAINBOW,
    COLOR_TYPE_RED
};

#endif //QUICK_DEMO_COMMON_H
