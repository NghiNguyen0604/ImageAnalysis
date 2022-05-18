import QtQuick 2.12
import QtQuick.Controls 2.12
Item {
    id: box
    anchors.fill:parent
    property bool display_text: false
    property var model_list: []


    property string text_selected: ""
    property int cb_currentIndex:0
    ComboBox {

        id: control
        anchors.fill: parent
        model: model_list
        delegate: ItemDelegate {
            width: control.width

            contentItem: Text {
                text: modelData
                color: "black"
                font.pixelSize: control.height * 0.2
                elide: Text.ElideRight
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
//            highlighted: control.highlightedIndex = index
        }

        indicator: Canvas {
            id: canvas
            x: parent.width*0.8
            y: parent.height*0.4
            width: control.height * 0.25
            height: control.width * 0.1
            contextType: "2d"
            onPaint: {
                context.reset();
                context.moveTo(0, 0);
                context.lineTo(width, 0);
                context.lineTo(width / 2, height);
                context.closePath();
                context.fillStyle = control.pressed ? "darkgray" : "#e8e8e8";
                context.fill();
            }
        }

        contentItem: Text {
            leftPadding: 2
            rightPadding: control.indicator.width + control.spacing

            text: (model_list[control.currentIndex] === undefined) ? "Gimbal ID" : control.displayText
            font.pixelSize: control.height * 0.3
            color: control.pressed ? "darkgray" : "#e8e8e8"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            elide: Text.ElideRight
        }

        background: Rectangle {
            implicitWidth: 120
            implicitHeight: 40
            color: "#55664F"
            border.color: control.pressed ? "darkgray" : "black"
            border.width: control.visualFocus ? 2 : 1
            radius: 2
        }

        popup: Popup {
            y: control.height - 1
            width: control.width
            implicitHeight: contentItem.implicitHeight
            padding: 1

            contentItem: ListView {
                clip: true

                implicitHeight: contentHeight
                model: control.popup.visible ? control.delegateModel : null
                currentIndex: control.highlightedIndex

                ScrollIndicator.vertical: ScrollIndicator { }
            }

            background: Rectangle {
                border.color: "black"
                radius: 2
            }
        }

        onCurrentIndexChanged: {
            if(model_list[control.currentIndex] !== undefined){
                text_selected = model_list[currentIndex]
            }
            cb_currentIndex=currentIndex
        }

    }

}
