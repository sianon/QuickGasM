#ifndef DEVICESTATUS_H
#define DEVICESTATUS_H

#include <QObject>
#include <QAbstractVideoSurface>
#include <QVideoSurfaceFormat>
#include "common.h"

class DeviceStatus : public QObject{
Q_OBJECT
public:
    DeviceStatus()
    : signal_level_(0)
    , battery_level_(0)
    , wifi_level_(0){

    }

    ~DeviceStatus(){
    }

    Q_INVOKABLE int mvGetSignalLevel(){
        signal_level_ = rand() % 100;
        return signal_level_;
    }

    Q_INVOKABLE int mvGetBatteryLevel(){
        battery_level_ = rand() % 100;
        return battery_level_;
    }

    Q_INVOKABLE int mvGetWifiLevel(){
        wifi_level_ = rand() % 100;
        return wifi_level_;
    }

    inline void mvSetSignalLevel(int level){
        signal_level_ = level;
    }

    inline void mvSetBatteryLevel(int level){
        battery_level_ = level;
    }

    inline void mvSetWifiLevel(int level){
        wifi_level_ = level;
    }

private:
    int signal_level_;
    int battery_level_;
    int wifi_level_;
};

#endif // DEVICESTATUS_H
