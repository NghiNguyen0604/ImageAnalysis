#ifndef PROCESS_IMAGE_H
#define PROCESS_IMAGE_H

#include <QObject>
#include <QImage>
#include <opencv2/opencv.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/highgui.hpp>
using namespace cv;

class ProcessImage: public QObject
{
    Q_OBJECT
public:
    ProcessImage();
public slots:
    void processImageWithLaplaceOperator(QString path);

signals:
    void completelyProcessedImageWithLaplaceOperator(QImage image,double sharpness);

private:
};



#endif // PROCESS_IMAGE_H
