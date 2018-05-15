#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDebug>
//#include "device.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    qDebug()<<"argc is"<<argc;
    for (int i = 0; i<argc; i++)
           qDebug()<<"dsfdsfdsf" << argv[i] << endl;

    QQmlApplicationEngine engine;
    //    engine.rootContext()->setContextProperty("device", new Device);
    engine.load(QUrl(QStringLiteral("qrc:/server.qml")));

    return app.exec();
}
