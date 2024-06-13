//
// Created by cao on 24-6-14.
//

#ifndef QUICK_DEMO_SETTINGSMANAGER_H
#define QUICK_DEMO_SETTINGSMANAGER_H

#include <QSettings>
#include <QDebug>

class SettingsManager: public QObject{
Q_OBJECT
public:
    explicit SettingsManager(QObject *parent = nullptr)
    : QObject(parent)
    , settings_(QSettings("ZhiGan", "QuickGas")){
        settings_.beginGroup("Sys");
        if(settings_.contains("showBattery")){
            auto tmp = settings_.value("key").toString().toStdString();
            qDebug()<<settings_.value("key");
        }
    }

    Q_INVOKABLE void saveSettings(const QString &key, const QString &value) {
        settings_.setValue(key, value);
    }

    Q_INVOKABLE QString loadSettings(const QString &key, const QString &defaultValue = "") {
        return settings_.value(key, defaultValue).toString();
    }
private:
    QSettings settings_;
};

#endif //QUICK_DEMO_SETTINGSMANAGER_H
