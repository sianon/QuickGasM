//
// Created by cao on 24-4-15.
//

#ifndef COLOR_SETTING_H
#define COLOR_SETTING_H

#include <QObject>
// #include <QJsonValue>
#include "common.h"

class ColorSetting : public QObject{
Q_OBJECT
public:
    explicit ColorSetting(QObject* parent = nullptr)
    :current_color_type(COLOR_TYPE_NULL){
    }

    ~ColorSetting(){
    }

    ColorType meGetCurrentColorType(){
        return current_color_type;
    }

    bool mbChangeColorByName(QString color_name){
        if(color_name.isEmpty()){
            current_color_type = COLOR_TYPE_NULL;
        }else if(color_name == "color_type_iron_red"){
            current_color_type = COLOR_TYPE_IRON_RED;
        }else if(color_name == "color_type_rainbow"){
            current_color_type = COLOR_TYPE_RAINBOW;
        }else if(color_name == "color_type_black_white"){
            current_color_type = COLOR_TYPE_BLACK_WITHE;
        }else if(color_name == "color_type_red"){
            current_color_type = COLOR_TYPE_RED;
        }

        return true;
    };
private:
    ColorType current_color_type;
};

#endif //COLOR_SETTING_H
