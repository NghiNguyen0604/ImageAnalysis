QT += quick

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        main.cpp \
        src/imageprovider.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
win32{
    INCLUDEPATH +=src\
                $$PWD\third-party\opencv_4.4.0\include\


    Debug{
        LIBS += \
             $$PWD/third-party/opencv_4.4.0/libopencv_core440.dll \
             $$PWD/third-party/opencv_4.4.0/libopencv_highgui440.dll \
             $$PWD/third-party/opencv_4.4.0/libopencv_imgcodecs440.dll \
             $$PWD/third-party/opencv_4.4.0/libopencv_imgproc440.dll \
             $$PWD/third-party/opencv_4.4.0/libopencv_features2d440.dll \
             $$PWD/third-party/opencv_4.4.0/libopencv_calib3d440.dll \
             $$PWD/third-party/opencv_4.4.0/libopencv_videoio440.dll \
             $$PWD/third-party/opencv_4.4.0/libopencv_video440.dll \
             $$PWD/third-party/opencv_4.4.0/opencv_videoio_ffmpeg440.dll
    }
    Release{

        LIBS += \
             $$PWD/third-party/opencv_4.4.0/libopencv_core440.dll \
             $$PWD/third-party/opencv_4.4.0/libopencv_highgui440.dll \
             $$PWD/third-party/opencv_4.4.0/libopencv_imgcodecs440.dll \
             $$PWD/third-party/opencv_4.4.0/libopencv_imgproc440.dll \
             $$PWD/third-party/opencv_4.4.0/libopencv_features2d440.dll \
             $$PWD/third-party/opencv_4.4.0/libopencv_calib3d440.dll \
             $$PWD/third-party/opencv_4.4.0/libopencv_videoio440.dll \
             $$PWD/third-party/opencv_4.4.0/libopencv_video440.dll \
             $$PWD/third-party/opencv_4.4.0/opencv_videoio_ffmpeg440.dll
    }
}

HEADERS += \
    src/imageprovider.h
