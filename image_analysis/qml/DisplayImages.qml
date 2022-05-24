import QtQuick 2.0
import QtQuick.Controls 1.4

import QtQuick.Layouts 1.0
import QtMultimedia 5.15

Item {
    property string sourceRaw:"image://live/raw"
    property  string sourceLaplaceImage: "image://live/laplace"
    property string sourceFFTImage:"image://live/fft"

    Row{
        anchors.fill: parent
        Image{
            id:imageRaw
            height:parent.height
            width: parent.width*0.33
            source:sourceRaw
            cache:false
            function reload(){
                sourceRaw=""
                sourceRaw="image://live/raw"
            }

        }
        Image{
            id:laplaceImage
            height:parent.height
            width: parent.width*0.33
            source:sourceLaplaceImage
            cache:false
            function reload(){
                sourceLaplaceImage=""
                sourceLaplaceImage="image://live/laplace"
            }

        }
        Image{
            id:fftImage
            height:parent.height
            width: parent.width*0.33
            source:sourceFFTImage
            cache:false
            function reload(){
                sourceFFTImage=""
                sourceFFTImage="image://live/fft"
            }

        }
    }



    Component.onCompleted: {

    }
    Connections{
        target:imageProvider
        ignoreUnknownSignals: true
        function onRawImageChanged(){
            imageRaw.reload()

        }
        function onLaplaceImageChanged(){
            laplaceImage.reload()
        }
        function onFftImageChanged(){
            fftImage.reload()
            console.log("Updated fft image.")
        }
    }

}










































