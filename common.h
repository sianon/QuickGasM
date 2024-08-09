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
#include <QQmlApplicationEngine>

#define CAS(a_ptr, a_oldVal, a_newVal) __sync_bool_compare_and_swap(a_ptr, a_oldVal, a_newVal)

enum VideoType{
    VIDEO_TYPE_WHITE = 0,
    VIDEO_TYPE_THERMAL,
    VIDEO_TYPE_MIX,
    VIDEO_PIP,
    VIDEO_ENHANCE
};

enum ColorType{
    COLOR_TYPE_NULL = 0,
    color_type_white_hot,
    color_type_black_hot,
    color_type_iron_red,
    color_type_green,
    color_type_rainbow,
    color_type_rainbow_reverse,
    color_type_red_brown,
    color_type_hot_iron,
    color_type_cold,
    color_type_fire,
};

class QmlEngineSingleton
{
public:
    static QQmlApplicationEngine& instance() {
        static QQmlApplicationEngine engine;
        return engine;
    }
};

#endif //QUICK_DEMO_COMMON_H
