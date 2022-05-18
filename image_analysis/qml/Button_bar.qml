
import QtQuick 2.12
import QtGraphicalEffects 1.12

Item{
    signal user_click()
    property bool checked: false
    onCheckedChanged: {
        if(checked){
            // active
            background_color = background_color_active
            text_color = text_color_active
            img_src = img_src_active
        }else{
            background_color = background_color_unactive
            text_color = text_color_unactive
            img_src = img_src_unactive
        }
    }

    property string background_color: background_color_unactive
    property string background_color_active: "#3B3A3A"
    property string background_color_unactive: "#171717"

    property string text_color: text_color_unactive
    property string text_color_active: "#F68215"
    property string text_color_unactive: "#007c8c"

    property string border_color: "white"

    property string img_src: img_src_unactive
    property string img_src_active: ""
    property string img_src_unactive: ""

    property string object_name: ""
    property int img_width: 0
    property int img_height: 0
    property int item_width: 0
    property int item_height: 0
    property double img_scale: 0.75
    Rectangle {
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
                if(checked) return
                text_color = text_color_active
                img_src = img_src_active
            }
            onExited: {
                if(checked) return
                text_color = text_color_unactive
                img_src = img_src_unactive
            }
        }

        Row{
            anchors.fill: parent

            Item{
                height: img_height
                width: img_width
                Image{
                    id: bug
                    height: parent.height * img_scale
                    width: parent.width * img_scale
                    anchors.centerIn: parent
                    source: img_src
                }

            }



            Item{
                height: item_height
                width: item_width
                Rectangle{
                    id:rect2
                    anchors.fill: parent
                    color: background_color
                    Text {
                        anchors.fill: parent
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.pixelSize: height*0.25
                        text: qsTr(object_name)
                        color: text_color
                        opacity: 3
                    }

                }
            }
        }
    }

}

