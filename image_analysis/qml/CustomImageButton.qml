
import QtQuick 2.12
import QtGraphicalEffects 1.12

Item{
    signal user_click()
    property bool checked: false

    property string img_src

    property double img_scale: 0.75
    Item {
        id: pn_background
        anchors.fill: parent
        MouseArea{
            id:focusArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: enabled ? Qt.PointingHandCursor : Qt.BusyCursor
            onClicked: {
                user_click()
            }
            onEntered: {
//                if(checked) return
//                text_color = text_color_active
//                img_src = img_src_active
            }
            onExited: {
//                if(checked) return
//                text_color = text_color_unactive
//                img_src = img_src_unactive
            }
        }

        Item{
            anchors.fill: parent
            Image{
                id: bug
                height: parent.height * img_scale
                width: parent.width * img_scale
                anchors.centerIn: parent
                source: img_src
            }
        }
    }
}

