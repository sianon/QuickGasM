//
// Created by cao on 24-4-15.
//

#ifndef QUICK_DEMO_TDLAS_DEVICE_H
#define QUICK_DEMO_TDLAS_DEVICE_H

#include <QObject>
#include <QJsonValue>
#include "third_device.h"

class TdlasDevice : public QObject, public IThirdDevice{
Q_OBJECT
public:
    explicit TdlasDevice(QObject* parent = nullptr){
    }

    ~TdlasDevice(){
    }

    ThirdDeviceType meGetType(){
        return THIRD_DEVICE_TYPE_TDLAS;
    };

    bool mbSetValueByPropertyName(QString property_name){
        return true;
    };

    Q_INVOKABLE QString mvGetValueByPropertyName(QString property_name){
        if(property_name.isEmpty()) return "";
        QString res;
        if(property_name == "distance"){
            res = QString(to_string(rand() % 100).c_str());
        }else if(property_name == "consentration"){
            res = QString(to_string(rand() % 50).c_str());
        }
        return res;
    };
private:
//    QJsonObject dev_properties;
};

#endif //QUICK_DEMO_TDLAS_DEVICE_H
