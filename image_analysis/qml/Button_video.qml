
import QtQuick 2.12
import QtGraphicalEffects 1.12

Item{
    signal user_click()
    property bool checked: true
    onCheckedChanged: {
        if(checked){
            // active
//            background_color_active
            img_src = img_src_active
        }else{
//            background_color_unactive
            img_src = img_src_unactive
        }
    }
    property string background_color: "#3B3A3A"
//    property string background_color_active: "#3B3A3A"
//    property string background_color_unactive: "#171717"

    property string img_src: img_src_active
    property string img_src_active: ""
    property string img_src_unactive: ""


    Rectangle{
        id: pn_background
        anchors.fill: parent
        color: background_color
        MouseArea{
            id:focusArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: enabled ? Qt.PointingHandCursor : Qt.BusyCursor
            onClicked: {
                user_click()
            }
            onEntered: {
            }
            onExited: {
            }
        }
        Image{
            id: image_video

            anchors.fill: parent
            source: img_src
        }


    }
}


