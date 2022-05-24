#include "imageprovider.h"
#include <QDebug>
ImageProvider::ImageProvider(QObject *parent): QObject(parent), QQuickImageProvider(QQuickImageProvider::Image)
{
    //    processImage-> moveToThread(&processImageThread);
    rawImage = QImage(200,200,QImage::Format_RGB32);
    rawImage.fill(QColor(59,58,58));
    laplaceImage = QImage(200,200,QImage::Format_RGB32);
    laplaceImage.fill(QColor(59,58,58));
    fftImage = QImage(200,200,QImage::Format_RGB32);
    fftImage.fill(QColor(59,58,58));
    ///Processed afther selected image path.
    connect(this,&ImageProvider::selectedImagePath,this,&ImageProvider::_processImage);
    ///This function reserved for multithreading handle feedback from thread

    /*
    /// terminal afther the thread finished.
    connect(&processImageThread,&QThread::finished,processImage,&QObject::deleteLater);
    /// processed in other thread after ready
    connect(this,&ImageProvider::readyToProcessInOtherThread,processImage,&ProcessImage::processImageWithLaplaceOperator);

    connect(processImage,&ProcessImage::completelyProcessedImageWithLaplaceOperator,this,&ImageProvider::imageWithLaplaceOperatorHandler);
    processImageThread.start();
    */
}

ImageProvider::~ImageProvider()
{
    //    processImageThread.quit();
    //    processImageThread.wait();
}

QImage ImageProvider::requestImage(const QString &id, QSize *size, const QSize &requestedSize)
{
    qDebug() <<"Image ID:"<<id;


    if(id=="raw"){
        if(size){
            *size=rawImage.size();
        }
        if(requestedSize.width()>0 && requestedSize.height()>0){
            rawImage= rawImage.scaled(requestedSize.width(),requestedSize.height(),Qt::KeepAspectRatio);
        }
        return rawImage;
    }
    else if(id=="laplace"){

        if(size == nullptr){
            qDebug()<< "Image null";
        }
        if(size){
            *size=laplaceImage.size();
        }
        if(requestedSize.width()>0 && requestedSize.height()>0){
            qDebug()<< "Image prepare to scale:";

            laplaceImage= laplaceImage.scaled(requestedSize.width(),requestedSize.height(),Qt::KeepAspectRatio);
            qDebug()<< "Image width scaled:"<<requestedSize.width();

        }
        return laplaceImage;
    }
    else{

        if(size == nullptr){
            qDebug()<< "Image null";
        }
        if(size){
            *size=fftImage.size();
        }
        if(requestedSize.width()>0 && requestedSize.height()>0){
            qDebug()<< "Image prepare to scale:";

            fftImage= fftImage.scaled(requestedSize.width(),requestedSize.height(),Qt::KeepAspectRatio);
            qDebug()<< "Image width scaled:"<<requestedSize.width();

        }
        return fftImage;
    }

}

void ImageProvider::updateImage(  QImage &input,const QImage& image)
{
    if(input.isNull()){
        qDebug()<< "Input null";
        return;
    }
    if(!image.isNull()&&input != image){
        input=image;
    }
}
void ImageProvider::setImagePath(QString path){
    reset();
    if(path =="") return;
    _image_path=path;
    emit resultProcess(0,0);

    emit selectedImagePath(_image_path);

}

void ImageProvider::imageWithLaplaceOperatorHandler(QImage image, double sharpness)
{

}

void ImageProvider:: reset(){
    rawImage = QImage(200,200,QImage::Format_RGB32);
    rawImage.fill(QColor("black"));
    laplaceImage = QImage(200,200,QImage::Format_RGB32);
    laplaceImage.fill(QColor("black"));
    emit rawImageChanged();
    emit laplaceImageChanged();
}

void ImageProvider::_processImage()
{
    Mat mat= imread(_image_path.toStdString(),IMREAD_COLOR);
    Mat grayImage;
    //convert image to gray.
    cv::cvtColor(mat,grayImage,cv::COLOR_BGR2GRAY);
    //update raw image to displaying in UI
    this->updateImage(rawImage,QImage((uchar*) mat.data, mat.cols, mat.rows, mat.step, QImage::Format_RGB888).rgbSwapped());
    emit rawImageChanged();
    //processing image with laplace
    double _laplaceFilterResult=  this->processImageWithLaplace(grayImage.clone());

    //processing image with fft

   double _fftFilterResult= this->processImageWithFFT(grayImage.clone());
//   qDebug()<< "Result" << _laplaceFilterResult<< _fftFilterResult;
   emit resultProcess(_laplaceFilterResult,_fftFilterResult);
}
double ImageProvider::processImageWithLaplace(cv::Mat grayImage)
{
    Mat laplacianImage;
    /// The kernel size of the laplace operator.
    int kernel_size = 1;
    int scale = 1;
    int delta = 0;
    int ddepth = CV_16S;
    Scalar mean, stddev; // 0:1st channel, 1:2nd channel and 2:3rd channel


    //Implement a laplace filter
    cv::Laplacian(grayImage, laplacianImage,ddepth,kernel_size,scale,delta, cv::BORDER_DEFAULT);
    // calculating the variance value from laplacian image.
    cv::meanStdDev(laplacianImage, mean, stddev, Mat());

    double variance = stddev.val[0] * stddev.val[0];
//    qDebug()<< "Variance:"<<variance;
    ///converting back to CV_8U
    convertScaleAbs(laplacianImage, laplacianImage);
    ///update filtered image to displaying in UI
    this->updateImage(laplaceImage,QImage((uchar*) laplacianImage.data, laplacianImage.cols, laplacianImage.rows, laplacianImage.step,QImage::Format_Grayscale8));
    emit laplaceImageChanged();
    return roundf(variance*10000)/10000;
}

double ImageProvider::processImageWithFFT(Mat grayImage)
{
    const char BLOCK = 60;
    int cx = grayImage.cols/2;
    int cy = grayImage.rows/2;
    // Go float
    Mat fImage;
    grayImage.convertTo(fImage, CV_32F);
    // FFT
    Mat fourierTransform;
    dft(fImage, fourierTransform, cv::DFT_SCALE|cv::DFT_COMPLEX_OUTPUT);

    //center low frequencies in the middle
    //by shuffling the quadrants.
    Mat q0(fourierTransform, Rect(0, 0, cx, cy));       // Top-Left - Create a ROI per quadrant
    Mat q1(fourierTransform, Rect(cx, 0, cx, cy));      // Top-Right
    Mat q2(fourierTransform, Rect(0, cy, cx, cy));      // Bottom-Left
    Mat q3(fourierTransform, Rect(cx, cy, cx, cy));     // Bottom-Right

    Mat tmp;                                            // swap quadrants (Top-Left with Bottom-Right)
    q0.copyTo(tmp);
    q3.copyTo(q0);
    tmp.copyTo(q3);

    q1.copyTo(tmp);                                     // swap quadrant (Top-Right with Bottom-Left)
    q2.copyTo(q1);
    tmp.copyTo(q2);

    // Block the low frequencies
    // #define BLOCK could also be a argument on the command line of course
    fourierTransform(Rect(cx-BLOCK,cy-BLOCK,2*BLOCK,2*BLOCK)).setTo(0);

    //shuffle the quadrants to their original position
    Mat orgFFT;
    fourierTransform.copyTo(orgFFT);

    Mat p0(orgFFT, Rect(0, 0, cx, cy));       // Top-Left - Create a ROI per quadrant
    Mat p1(orgFFT, Rect(cx, 0, cx, cy));      // Top-Right
    Mat p2(orgFFT, Rect(0, cy, cx, cy));      // Bottom-Left
    Mat p3(orgFFT, Rect(cx, cy, cx, cy));     // Bottom-Right

    p0.copyTo(tmp);
    p3.copyTo(p0);
    tmp.copyTo(p3);

    p1.copyTo(tmp);                                     // swap quadrant (Top-Right with Bottom-Left)
    p2.copyTo(p1);
    tmp.copyTo(p2);

    // IFFT
    Mat invFFT;
    Mat logFFT;
    double minVal,maxVal;

    dft(orgFFT, invFFT, DFT_INVERSE|DFT_REAL_OUTPUT);

    //img_fft = 20*numpy.log(numpy.abs(img_fft))
    invFFT = cv::abs(invFFT);
    cv::minMaxLoc(invFFT,&minVal,&maxVal,NULL,NULL);

    //check for impossible values
    if(maxVal<=0.0){
        qDebug() << "No information, complete black image!\n";
        return 0;

    }else {
        cv::log(invFFT,logFFT);
        logFFT *= 20;
        //result = numpy.mean(img_fft)
        cv::Scalar mean, stddev; // 0:1st channel, 1:2nd channel and 2:3rd channel
        cv::meanStdDev(logFFT, mean, stddev, Mat());
        double variance = stddev.val[0] * stddev.val[0];
        ///converting back to CV_8U
        convertScaleAbs(logFFT, logFFT);
        this->updateImage(fftImage,QImage((uchar*)logFFT.data,logFFT.cols,logFFT.rows,logFFT.step,QImage::Format_Grayscale8));

        emit fftImageChanged();
        return roundf(variance*10000)/10000;
    }
}
