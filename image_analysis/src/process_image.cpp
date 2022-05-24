#include "process_image.h"
#include <QDebug>

ProcessImage::ProcessImage()
{

}

void ProcessImage::processImageWithLaplaceOperator(QString path)
{
    Mat mat= imread(path.toStdString(),IMREAD_COLOR);
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
    // calculating the variance value from laplacian image.
    cv::meanStdDev(laplacianImage, mean, stddev, Mat());

    double variance = stddev.val[0] * stddev.val[0];
    qDebug()<< "Variance:"<<variance;
    ///converting back to CV_8U
    convertScaleAbs(laplacianImage, laplacianImage);
    emit completelyProcessedImageWithLaplaceOperator(QImage((uchar*) laplacianImage.data, laplacianImage.cols, laplacianImage.rows, laplacianImage.step,QImage::Format_Grayscale8),variance);
}
