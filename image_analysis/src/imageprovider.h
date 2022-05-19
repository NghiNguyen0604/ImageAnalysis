#ifndef IMAGEPROVIDER_H
#define IMAGEPROVIDER_H

#include <QObject>
#include <QImage>
#include <opencv2/opencv.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/highgui.hpp>
#include <QQuickImageProvider>
using namespace cv;

class ImageProvider : public QObject, public QQuickImageProvider
{
    Q_OBJECT
public:
    ImageProvider(QObject *parent= nullptr);
    QImage requestImage(const QString &id,QSize *size,const QSize &requestedSize) override;
    void updateImage(QImage &input,const QImage &image);
    Q_INVOKABLE void test();
    Q_INVOKABLE void test1();
    Q_INVOKABLE void reset();
signals:
    void imageRawChanged();
    void imageFilteredChanged();

private:
    void init();
    QImage imageRaw;
    QImage imageFiltered;
};


#endif // IMAGEPROVIDER_H
