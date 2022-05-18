import QtQuick 2.0
Item{
    signal user_clicked()
    signal user_press()
    signal user_released()
    signal user_entered()
    signal user_exited()
    property bool checked: false

    property string background_color: "#3B3A3A"
    property string text_color: "#e8e8e8"
    property string border_color: "darkgray"
    property double text_scale: 1
    property double text_font: 0.25
    property string img_src: ""
    property string object_name: ""
    property int img_width: 0
    property int img_height: 0
    property int item_width: 0
    property int item_height: 0

    opacity: enabled ? 1 : 0.5
    Rectangle{
        anchors.fill: parent
        radius: 40
        color: background_color
        Row{
            anchors.fill: parent
            Image{
                height: img_height
                width: img_width
                source: img_src
                scale: 0.8
            }
            Item{
                height: item_height
                width: item_width
                Text {
                    anchors.fill: parent
                    font.pixelSize: height * text_font
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    text: qsTr(object_name)
                    color: text_color
                    scale: text_scale

                }
            }
        }
        MouseArea{
            id:focusArea2
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onPressed: {
                user_press()
            }
            onReleased:{
                user_released()
            }
            onClicked: {
                user_clicked()
            }
            onEntered: {
                user_entered()
            }
            onExited: {
                user_exited()

            }
        }

    }

}

