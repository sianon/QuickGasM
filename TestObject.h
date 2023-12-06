//
// Created by Chian on 12/1/2023.
//

#ifndef QUICK_DEMO_TESTOBJECT_H
#define QUICK_DEMO_TESTOBJECT_H

#include <QObject>
#include <QQuickView>

class TestObject : public QObject{
    Q_OBJECT
    Q_PROPERTY(QString author READ getAuthor WRITE setAuthor NOTIFY onAuthorChanged FINAL)
public:
    explicit TestObject(QObject *parent = nullptr);
    QString getAuthor(){
        return "name_";
    }

    void setAuthor(QString& name){
        name_ = name;
    }
public:
    Q_INVOKABLE void onTestSlot(int a, int b);
signals:
    void onAuthorChanged();
private:
    QString name_;
    QQuickView* view;
};


#endif //QUICK_DEMO_TESTOBJECT_H
