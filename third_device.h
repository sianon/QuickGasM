#ifndef QUICK_GAS_COMMON_H
#define QUICK_GAS_COMMON_H
#include <string>
using namespace std;

enum ThirdDeviceType{
    THIRD_DEVICE_TYPE_TDLAS = 0,
    THIRD_DEVICE_TYPE_CAMERA,
    THIRD_DEVICE_TYPE_CAMERA_THERMAL,
    THIRD_DEVICE_TYPE_CAMERA_WHITE,
    THIRD_DEVICE_TYPE_SPEAKER,
    THIRD_DEVICE_TYPE_UNKNOWN
};

class IThirdDevice{
public:
//    IThirdDevice();
    virtual ThirdDeviceType meGetType() = 0;
    virtual bool mbSetValueByPropertyName(QString property_name) = 0;
    virtual QString mvGetValueByPropertyName(QString property_name) = 0;
};
#endif // QUICK_GAS_COMMON_H
