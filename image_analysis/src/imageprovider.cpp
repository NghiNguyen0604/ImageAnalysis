#include "imageprovider.h"
#include <QDebug>
ImageProvider::ImageProvider(QObject *parent): QObject(parent), QQuickImageProvider(QQuickImageProvider::Image)
{
    processImage-> moveToThread(&processImageThread);
    imageRaw = QImage(200,200,QImage::Format_RGB32);
    imageRaw.fill(QColor("black"));
    imageFiltered = QImage(200,200,QImage::Format_RGB32);
    imageFiltered.fill(QColor("black"));

    ///Processed afther selected image path.
    connect(this,&ImageProvider::selectedImagePath,this,&ImageProvider::_processImage);

    /// terminal afther the thread finished.
    connect(&processImageThread,&QThread::finished,processImage,&QObject::deleteLater);
    /// processed in other thread after ready
    connect(this,&ImageProvider::readyToProcessInOtherThread,processImage,&ProcessImage::processImageWithLaplaceOperator);

    /// handle feedback from thread
    connect(processImage,&ProcessImage::completelyProcessedImageWithLaplaceOperator,this,&ImageProvider::imageWithLaplaceOperatorHandler);
    processImageThread.start();
}

ImageProvider::~ImageProvider()
{
    processImageThread.quit();
    processImageThread.wait();
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

void ImageProvider::setImagePath(QString path){
    reset();
    if(path =="") return;
    _image_path=path;
    emit resultWithLaplaceOperatorHandler(0);

    emit selectedImagePath(_image_path);

}


void ImageProvider::imageWithLaplaceOperatorHandler( QImage image, double sharpness)
{
    ///update filtered image to displaying in UI
//    imageFiltered= image;
//    updateImage(imageFiltered, image);
    qDebug() << "Variance:" << sharpness;
//    emit imageFilteredChanged();
    emit resultWithLaplaceOperatorHandler(roundf(sharpness*10000)/10000);
}


void ImageProvider:: reset(){
    imageRaw = QImage(200,200,QImage::Format_RGB32);
    imageRaw.fill(QColor("black"));
    imageFiltered = QImage(200,200,QImage::Format_RGB32);
    imageFiltered.fill(QColor("black"));
    emit imageRawChanged();
    emit imageFilteredChanged();
}

void ImageProvider::_processImage()
{
//        Mat mat= imread(_image_path.toStdString(),IMREAD_COLOR);
//        Mat grayImage,laplacianImage;
//        /// The kernel size of the laplace operator.
//        int kernel_size = 1;
//        int scale = 1;
//        int delta = 0;
//        int ddepth = CV_16S;
//        Scalar mean, stddev; // 0:1st channel, 1:2nd channel and 2:3rd channel
//        ///update raw image to displaying in UI
//        updateImage(imageRaw,QImage((uchar*) mat.data, mat.cols, mat.rows, mat.step, QImage::Format_RGB888).rgbSwapped());

//        //convert image to gray.
//        cv::cvtColor(mat,grayImage,cv::COLOR_BGR2GRAY);

//        //Implement a laplace filter
//        cv::Laplacian(grayImage, laplacianImage,ddepth,kernel_size,scale,delta, cv::BORDER_DEFAULT);


//        // calculating the variance value from laplacian image.
//        cv::meanStdDev(laplacianImage, mean, stddev, Mat());

//        double variance = stddev.val[0] * stddev.val[0];

//        double threshold = 2900;

//        if (variance <= threshold) {
//            qDebug()<< "Blurry" << variance;
//            // Blurry
//        } else {
//            qDebug()<< "Not blurry" << variance;

//            // Not blurry
//        }
//        ///converting back to CV_8U
//        convertScaleAbs( laplacianImage, laplacianImage );
//        ///update filtered image to displaying in UI
//        updateImage(imageFiltered,QImage((uchar*) laplacianImage.data, laplacianImage.cols, laplacianImage.rows, laplacianImage.step,QImage::Format_Grayscale8));
//        emit imageRawChanged();
//        emit imageFilteredChanged();

    Mat mat= imread(_image_path.toStdString(),IMREAD_COLOR);
    Mat grayImage,laplacianImage;
    /// The kernel size of the laplace operator.
    int kernel_size = 1;
    int scale = 1;
    int delta = 0;
    int ddepth = CV_16S;
    Scalar mean, stddev; // 0:1st channel, 1:2nd channel and 2:3rd channel

    //convert image to gray.
    cv::cvtColor(mat,grayImage,cv::COLOR_BGR2GRAY);

    //Implement a laplace filter
    cv::Laplacian(grayImage, laplacianImage,ddepth,kernel_size,scale,delta, cv::BORDER_DEFAULT);
    ///converting back to CV_8U
    convertScaleAbs( laplacianImage, laplacianImage );
    ///update filtered image to displaying in UI
    updateImage(imageFiltered,QImage((uchar*) laplacianImage.data, laplacianImage.cols, laplacianImage.rows, laplacianImage.step,QImage::Format_Grayscale8));
    emit imageFilteredChanged();
    ///update raw image to displaying in UI
    updateImage(imageRaw,QImage((uchar*) mat.data, mat.cols, mat.rows, mat.step, QImage::Format_RGB888).rgbSwapped());
    emit imageRawChanged();
    emit readyToProcessInOtherThread(_image_path);
}

