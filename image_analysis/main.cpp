#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <iostream>
#include <opencv2/opencv.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/highgui.hpp>

using namespace std;
using namespace cv;

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

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
