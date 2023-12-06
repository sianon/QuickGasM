//
// Created by Chian on 12/1/2023.
//

#include "TestObject.h"
#include <QDebug>
#include <QQuickView>
#include <QMessageBox>

//#include <QUrl>

TestObject::TestObject(QObject *parent){
    view = new QQuickView(QUrl("qrc:/quick_item.qml"));
    name_ = "123456";
}

void TestObject::onTestSlot(int a, int b) {
    qDebug()<<"Hello";
    view->showNormal();
}
