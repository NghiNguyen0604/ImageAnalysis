#include "imageprovider.h"
#include <QDebug>
ImageProvider::ImageProvider(QObject *parent): QObject(parent), QQuickImageProvider(QQuickImageProvider::Image)
{
    imageRaw = QImage(200,200,QImage::Format_RGB32);
    imageRaw.fill(QColor("black"));
    imageFiltered = QImage(200,200,QImage::Format_RGB32);
    imageFiltered.fill(QColor("black"));
}

QImage ImageProvider::requestImage(const QString &id, QSize *size, const QSize &requestedSize)
{
    qDebug() <<id;


    if(id=="raw"){
        if(size){
            *size=imageRaw.size();
        }
        if(requestedSize.width()>0 && requestedSize.height()>0){
            imageRaw= imageRaw.scaled(requestedSize.width(),requestedSize.height(),Qt::KeepAspectRatio);
        }
        return imageRaw;
    }
    else{
        if(size){
            *size=imageFiltered.size();
        }
        if(requestedSize.width()>0 && requestedSize.height()>0){
            imageFiltered= imageFiltered.scaled(requestedSize.width(),requestedSize.height(),Qt::KeepAspectRatio);
        }
        return imageFiltered;
    }


}

void ImageProvider::updateImage(QImage &input,const QImage &image)
{

    if(!image.isNull()&&input != image){
        input=image;
    }
    qDebug()<<"Updated image";

}

void ImageProvider::test()
{
    qDebug()<<"TEST";
    Mat mat= imread("C:/Users/User/Downloads/gremsy-logo-trans.png",IMREAD_COLOR);
    updateImage(imageRaw,QImage((uchar*) mat.data, mat.cols, mat.rows, mat.step, QImage::Format_RGB888).rgbSwapped());
    emit imageRawChanged();

}
void ImageProvider::test1()
{
    qDebug()<<"TEST1";

    Mat mat= imread("C:/Users/User/Downloads/2.jpg",IMREAD_COLOR);
    updateImage(imageFiltered, QImage((uchar*) mat.data, mat.cols, mat.rows, mat.step, QImage::Format_RGB888).rgbSwapped());
    emit imageFilteredChanged();

}

void ImageProvider:: reset(){
    imageRaw = QImage(200,200,QImage::Format_RGB32);
    imageRaw.fill(QColor("black"));
    imageFiltered = QImage(200,200,QImage::Format_RGB32);
    imageFiltered.fill(QColor("black"));
    emit imageRawChanged();
    emit imageFilteredChanged();
}

