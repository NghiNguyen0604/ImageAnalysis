#ifndef IMAGEPROVIDER_H
#define IMAGEPROVIDER_H

#include <QObject>
#include <QThread>
#include <QCoreApplication>
#include <QImage>
#include <opencv2/opencv.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/highgui.hpp>
#include <QQuickImageProvider>
#include <QMutex>
#include <QDir>
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
    void rawImageChanged();
    void laplaceImageChanged();
    void fftImageChanged();
    void resultProcess(double laplaceFilterResult,double fftFilterResult);

private:

    void updateImage(QImage &input,const QImage &image);
    double processImageWithLaplace(cv::Mat grayImage);
    double processImageWithFFT(cv::Mat grayImage);

    void reset();
    ProcessImage *processImage= new ProcessImage();
    QString _image_path;
    QImage rawImage,laplaceImage,fftImage,testImage;
    void saveImage(QString &imageName, cv::Mat &imageData);
    QMutex mutex;
    QDir pwd=QCoreApplication::applicationDirPath();
//    QDir pwd= QDir::currentPath();
};


#endif // IMAGEPROVIDER_H
