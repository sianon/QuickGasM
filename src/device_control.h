#ifndef DEVICECONTROL_H
#define DEVICECONTROL_H

#include <QObject>
#include <QAbstractVideoSurface>
#include <QVideoSurfaceFormat>
#include "../common.h"

class DeviceControl : public QObject{
Q_OBJECT
public:
    DeviceControl()
    : is_recording_(false){
    }

    ~DeviceControl(){
    }

    Q_INVOKABLE int mvStartRecordVideo(){
        is_recording_ = true;
        return 0;
    }

    Q_INVOKABLE int mvStopRecordVideo(){
        is_recording_ = false;
        return 0;
    }

    inline bool mbIsRecording(){
        return is_recording_;
    }
private:
    bool is_recording_;
};

#endif // DEVICECONTROL_H
