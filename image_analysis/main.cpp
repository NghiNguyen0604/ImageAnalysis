#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QIcon>
#include "imageprovider.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    app.setWindowIcon(QIcon(":/resources/Logo.png"));
    app.setOrganizationName("Gremsy");
    app.setOrganizationDomain("www.gremsy.com");

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    ImageProvider imageProvider;
    engine.rootContext()->setContextProperty("imageProvider",&imageProvider);
    engine.addImageProvider("live",&imageProvider);
    engine.load(url);
    return app.exec();
}
