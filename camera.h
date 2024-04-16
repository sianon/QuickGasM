//
// Created by cao on 24-4-15.
//

#ifndef QUICK_DEMO_TDLAS_DEVICE_H
#define QUICK_DEMO_TDLAS_DEVICE_H

#include <QObject>
#include <QJsonObject>
#include "third_device.h"

bool CameraDataIn(){

}

class Camera : public QObject, public IThirdDevice{
Q_OBJECT
public:
    explicit Camera(QObject* parent = nullptr){
    }

    ~Camera(){
    }

    ThirdDeviceType meGetType(){
        return THIRD_DEVICE_TYPE_CAMERA;
    };

    bool mbSetValueByPropertyName(QString property_name){

        return true;
    };

    Q_INVOKABLE QString mvGetValueByPropertyName(QString property_name){
        if(property_name.isEmpty()) return "";
        QString res;
        if(property_name == "model_name"){
            res = QString(to_string(rand() % 100).c_str());
        }else if(property_name == "serial_number"){
            res = QString(to_string(rand() % 50).c_str());
        }
        return res;
    };
private:
    QJsonObject camera_properties;

};

#endif //QUICK_DEMO_TDLAS_DEVICE_H
