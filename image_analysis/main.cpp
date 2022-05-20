#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <iostream>
#include <QIcon>
#include "imageprovider.h"

using namespace std;

int main(int argc, char *argv[])
{
//    cv::Laplacian(gray, laplacianImage, CV_64F);
//    Scalar mean, stddev; // 0:1st channel, 1:2nd channel and 2:3rd channel
//    cv::meanStdDev(laplacianImage, mean, stddev, Mat());
//    double variance = stddev.val[0] * stddev.val[0];

//    double threshold = 2900;

//    if (variance <= threshold) {
//        // Blurry
//    } else {
//        // Not blurry
//    }
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
    ImageProvider *imageProvider = new ImageProvider();
   engine.rootContext()->setContextProperty("imageProvider",imageProvider);
   engine.addImageProvider("live",imageProvider);
    engine.load(url);
    return app.exec();
}
