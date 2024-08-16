#ifndef GAS_WARRING_INSTANCE_H
#define GAS_WARRING_INSTANCE_H

#include <QObject>
#include "common.h"

class GasWarringSettingInstance : public QObject
{
    Q_OBJECT
public:
    GasWarringSettingInstance(){};
    ~GasWarringSettingInstance(){};

    // TODO 气体报警
    Q_INVOKABLE void mvSetGasDetectWarrning(bool on_off)
    {
        qDebug() << "set gas detect warrning:" << on_off;
    };
    Q_INVOKABLE void mvSetGasDetectWarrningPPM(int val)
    {
        qDebug() << "set gas detect warrning ppm:" << val;
    };
    Q_INVOKABLE void mvSetGasDetectWarrningAutoSnap(bool on_off)
    {
        qDebug() << "set gas detect warrning auto snap:" << on_off;
    };
    Q_INVOKABLE void mvSetGasDetectWarrningAutoSnapInterval(int val)
    {
        qDebug() << "set gas detect warrning auto snap interval:" << val;
    };
    Q_INVOKABLE void mvSetGasDetectWarrningAutoRecord(bool on_off)
    {
        qDebug() << "set gas detect warrning auto record:" << on_off;
    };
    Q_INVOKABLE void mvSetGasDetectWarrningNotice(bool on_off)
    {
        qDebug() << "set gas detect warrning notice:" << on_off;
    };

private:
};

#endif // GAS_WARRING_INSTANCE_H
