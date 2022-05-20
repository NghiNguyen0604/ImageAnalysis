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
//    void updateImage(QImage &input,const QImage &image);
    Q_INVOKABLE void setImagePath(QString path);

private slots:
    void _processImage();


signals:
    void selectedImagePath(QString path);
    void imageRawChanged();
    void imageFilteredChanged();

private:
    void updateImage(QImage &input,const QImage &image);
    void reset();
    QString _image_path;
    QImage imageRaw;
    QImage imageFiltered;
};


#endif // IMAGEPROVIDER_H
