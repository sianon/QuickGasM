#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickItem>
#include <thread>

#include "frame_provider.h"
#include "tdlas_device.h"
#include "video_hub.h"
#include "device_status.h"


int main(int argc, char* argv[]){
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine& engine = QmlEngineSingleton::instance();

    qmlRegisterType<TdlasDevice>("Local", 1, 0, "TdlasDevice");
    qmlRegisterType<DeviceStatus>("Local", 1, 0, "DeviceStatus");

    thread t1([&](){
        VideoHub::moGetInstance()->mvTest(VideoType::VIDEO_TYPE_THERMAL, "thermal1.mp4");
    });

    qmlRegisterType<FrameProvider>("Local", 1, 0, "FrameProvider");
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated, &app, [url](QObject* obj, const QUrl& objUrl){
        if(!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    QObject *rootObject = engine.rootObjects().first();

    return app.exec();
}
