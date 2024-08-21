#ifndef TEMPRETURE_DETECT
#define TEMPRETURE_DETECT

#include <QObject>
#include "common.h"

class TempretureDetect : public QObject
{
    Q_OBJECT
public:
    TempretureDetect() {};
    ~TempretureDetect() {};

    // TODO 测温开关
    Q_INVOKABLE bool mbSwitch(bool val)
    {
        return true;
    };
    Q_INVOKABLE bool mbCenterPointCheck(bool val)
    {
        return true;
    };
    Q_INVOKABLE bool mbColdPointCheck(bool val)
    {
        return true;
    };
    Q_INVOKABLE bool mbHotPointCheck(bool val)
    {
        return true;
    };
    Q_INVOKABLE bool mbCustomPointCheck(bool val)
    {
        return true;
    };
    Q_INVOKABLE bool mbCustomLineCheck(bool val)
    {
        return true;
    };
    Q_INVOKABLE bool mbCustomRectCheck(bool val)
    {
        return true;
    };
private:
};

#endif // TEMPRETURE_DETECT
