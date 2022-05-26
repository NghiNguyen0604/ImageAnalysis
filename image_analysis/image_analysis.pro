QT += widgets quick

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        main.cpp \
        src/imageprovider.cpp \
        src/process_image.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target




## Windows common build here

contains(QT_ARCH, i386) {

        #OpenCV used for 32 bit

        INCLUDEPATH +=src\
                    $$PWD\third-party\opencv_4.5.5\include\

        LIBS += \
             $$PWD/third-party/opencv_4.5.5/libopencv_core455.dll \
             $$PWD/third-party/opencv_4.5.5/libopencv_highgui455.dll \
             $$PWD/third-party/opencv_4.5.5/libopencv_imgcodecs455.dll \
             $$PWD/third-party/opencv_4.5.5/libopencv_imgproc455.dll \
             $$PWD/third-party/opencv_4.5.5/libopencv_features2d455.dll \
             $$PWD/third-party/opencv_4.5.5/libopencv_calib3d455.dll \
             $$PWD/third-party/opencv_4.5.5/libopencv_videoio455.dll \
             $$PWD/third-party/opencv_4.5.5/libopencv_video455.dll \
             $$PWD/third-party/opencv_4.5.5/opencv_videoio_ffmpeg455.dll

    ## Windows x86 (32bit) specific build here

} else {
         #OpenCV used for 64 bit

         INCLUDEPATH +=src\
                     $$PWD\third-party\opencv_4.5.5_64bit\include\


         LIBS += \
              $$PWD/third-party/opencv_4.5.5_64bit/libopencv_core455.dll \
              $$PWD/third-party/opencv_4.5.5_64bit/libopencv_highgui455.dll \
              $$PWD/third-party/opencv_4.5.5_64bit/libopencv_imgcodecs455.dll \
              $$PWD/third-party/opencv_4.5.5_64bit/libopencv_imgproc455.dll \
              $$PWD/third-party/opencv_4.5.5_64bit/libopencv_features2d455.dll \
              $$PWD/third-party/opencv_4.5.5_64bit/libopencv_calib3d455.dll \
              $$PWD/third-party/opencv_4.5.5_64bit/libopencv_videoio455.dll \
              $$PWD/third-party/opencv_4.5.5_64bit/libopencv_video455.dll \
              $$PWD/third-party/opencv_4.5.5_64bit/opencv_videoio_ffmpeg455_64.dll

    ## Windows x64 (64bit) specific build here

}


HEADERS += \
    src/imageprovider.h \
    src/process_image.h
