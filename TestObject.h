//
// Created by Chian on 12/1/2023.
//

#ifndef QUICK_DEMO_TESTOBJECT_H
#define QUICK_DEMO_TESTOBJECT_H

#include <QObject>

class TestObject : public QObject{
    Q_OBJECT
public:
    explicit TestObject(QObject *parent = nullptr);

signals:

public slots:
    void onTestSlot(int a, int b);
};


#endif //QUICK_DEMO_TESTOBJECT_H
