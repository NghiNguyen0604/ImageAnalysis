#ifndef IMAGEPROVIDER_H
#define IMAGEPROVIDER_H

#include <QObject>
#include <QThread>

#include <QImage>
#include <opencv2/opencv.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/highgui.hpp>
#include <QQuickImageProvider>
#include <QMutex>
#include "process_image.h"
using namespace cv;

class ImageProvider : public QObject, public QQuickImageProvider
{
    Q_OBJECT
    QThread processImageThread;
public:
    ImageProvider(QObject *parent= nullptr);
    ~ImageProvider();
    QImage requestImage(const QString &id,QSize *size,const QSize &requestedSize) override;
    Q_INVOKABLE void setImagePath(QString path);
public slots:
    ///This function reserved for multithreading
    void imageWithLaplaceOperatorHandler( QImage image,double sharpness);

private slots:
    void _processImage();
signals:
    ///This function reserved for multithreading
    void readyToProcessInOtherThread(QString path);
    void selectedImagePath(QString path);
    void imageRawChanged();
    void imageFilteredChanged();
    void resultWithLaplaceOperator(double sharpness);

private:

    void updateImage(QImage &input, QImage image);
    void processImageWithLaplace(cv::Mat grayImage);
    void processImageWithFFT(cv::Mat grayImage);

    void reset();
    ProcessImage *processImage= new ProcessImage();
    QString _image_path;
    QImage imageRaw;
    QImage imageFiltered;
    QMutex mutex;
};


#endif // IMAGEPROVIDER_H
