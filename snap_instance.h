#ifndef SNAP_INSTANCE_H
#define SNAP_INSTANCE_H

#include <QObject>
#include "common.h"

class SnapInstance : public QObject
{
    Q_OBJECT
public:
    SnapInstance(){};
    ~SnapInstance(){};

    // TODO 拍照设置
    Q_INVOKABLE bool mbSnap(QString val)
    {
        qDebug() << "------mbSnap:" << val;
        return true;
    };
    Q_INVOKABLE bool mbSnapSave(QString val)
    {
        qDebug() << "------mbSnapSave:" << val;
        return true;
    };
    Q_INVOKABLE bool mbSnapRecordVoice(QString val)
    {
        qDebug() << "------mbSnapRecordVoice:" << val;
        return true;
    };
    Q_INVOKABLE bool mbSnapBeidouInfo()
    {
        qDebug() << "------mbSnapBeidouInfo------";
        return true;
    };
    Q_INVOKABLE bool mbSnapQRScan()
    {
        qDebug() << "------mbSnapQRScan------";
        return true;
    };
    // TODO 录像设置
    Q_INVOKABLE bool mbRecord(QString val)
    {
        qDebug() << "------mbRecord:" << val;
        return true;
    };
    Q_INVOKABLE bool mbRecordSave(QString val)
    {
        qDebug() << "------mbRecordSave:" << val;
        return true;
    };
    Q_INVOKABLE bool mbRecordVideoVoice(QString val)
    {
        qDebug() << "------mbRecordVideoVoice:" << val;
        return true;
    };
    Q_INVOKABLE bool mbRecordBeidouInfo()
    {
        qDebug() << "------mbRecordBeidouInfo------";
        return true;
    };
    Q_INVOKABLE bool mbRecordQRScan()
    {
        qDebug() << "------mbRecordQRScan------";
        return true;
    };

    // TODO 拍照设置
    Q_INVOKABLE void mvSetManualSnapAutoSave(bool on_off)
    {
        qDebug() << "set manual snap auto save:" << on_off;
    };
    Q_INVOKABLE void mvSetSnapAutoUpload(bool on_off)
    {
        qDebug() << "set snap auto upload:" << on_off;
    };
    Q_INVOKABLE void mvSetAutoSnapPeriod(bool on_off)
    {
        qDebug() << "set auto snap period:" << on_off;
    };
    Q_INVOKABLE void mvSetAutoSnapPeriodInterval(int val)
    {
        qDebug() << "set auto snap period interval:" << val;
    };
    Q_INVOKABLE void mvSetAutoSnapPeriodNum(int val)
    {
        qDebug() << "set auto snap period num:" << val;
    };
    Q_INVOKABLE void mvSetAutoSnapFormat(QString val) {};

    // TODO 录像设置
    Q_INVOKABLE void mvSetManualRecordVideoAutoSave(bool on_off)
    {
        qDebug() << "set manual record video auto save:" << on_off;
    };
    Q_INVOKABLE void mvSetVideoRecordFormat(QString val) {};

private:
};

#endif // SNAP_INSTANCE_H
