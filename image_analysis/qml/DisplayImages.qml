import QtQuick 2.0
import QtQuick.Controls 1.4

import QtQuick.Layouts 1.0
import QtMultimedia 5.15

Item {
    property string sourceRaw:"image://live/raw"
    property string sourceFiltered:"image://live/filtered"

    Row{
        anchors.fill: parent
        Image{
            id:imageRaw
            height:parent.height
            width: parent.width*0.5
            source:sourceRaw
            cache:false
            function reload(){
                sourceRaw=""
                sourceRaw="image://live/raw"
            }

        }
        Image{
            id:imageFiltered
            height:parent.height
            width: parent.width*0.5
            source:sourceFiltered
            cache:false
            function reload(){
                sourceFiltered=""
                sourceFiltered="image://live/filtered"
            }

        }
    }



    Component.onCompleted: {

    }
    Connections{
        target:imageProvider
        ignoreUnknownSignals: true
        function onImageRawChanged(){
            imageRaw.reload()

        }
        function onImageFilteredChanged(){
           imageFiltered.reload()

        }
    }

}










































