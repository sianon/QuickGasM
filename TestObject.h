//
// Created by Chian on 12/1/2023.
//

#ifndef QUICK_DEMO_TESTOBJECT_H
#define QUICK_DEMO_TESTOBJECT_H

#include <QObject>
#include <QQuickView>

class TestObject : public QObject{
    Q_OBJECT
public:
    explicit TestObject(QObject *parent = nullptr);

signals:

public:
    Q_INVOKABLE void onTestSlot(int a, int b);
private:
    QQuickView* view;
};


#endif //QUICK_DEMO_TESTOBJECT_H
