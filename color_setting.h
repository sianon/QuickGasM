//
// Created by cao on 24-4-15.
//

#ifndef COLOR_SETTING_H
#define COLOR_SETTING_H

#include <QObject>
// #include <QJsonValue>
#include "common.h"

//TODO 伪彩设置类
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
        }else if(color_name == "color_type_white_hot"){
            current_color_type = color_type_white_hot;
        }else if(color_name == "color_type_black_hot"){
            current_color_type = color_type_black_hot;
        }else if(color_name == "color_type_iron_red"){
            current_color_type = color_type_iron_red;
        }else if(color_name == "color_type_green"){
            current_color_type = color_type_green;
        }else if(color_name == "color_type_rainbow"){
            current_color_type = color_type_rainbow;
        }else if(color_name == "color_type_rainbow_reverse"){
            current_color_type = color_type_rainbow_reverse;
        }else if(color_name == "color_type_red_brown"){
            current_color_type = color_type_red_brown;
        }else if(color_name == "color_type_hot_iron"){
            current_color_type = color_type_hot_iron;
        }else if(color_name == "color_type_cold"){
            current_color_type = color_type_cold;
        }else if(color_name == "color_type_fire"){
            current_color_type = color_type_fire;
        }

        return true;
    };
private:
    ColorType current_color_type;
};

#endif //COLOR_SETTING_H
