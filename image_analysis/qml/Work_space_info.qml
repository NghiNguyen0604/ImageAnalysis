import QtQuick 2.0

Item {
    anchors.fill: parent
    Column {
        anchors.fill: parent
        Item{
            height: parent.height * 0.1
            width: parent.width
        }
        Row{
            height: parent.height * 0.4
            width: parent.width

            Item{
                height: parent.height
                width: parent.width * 0.2
            }
            Item{
                height: parent.height
                width: parent.width * 0.6

                Image{
                    id: bug
                    height: parent.height
                    width: parent.width
                    fillMode: Image.PreserveAspectFit
                    anchors.centerIn: parent
                    source: "qrc:/resources/Logo.png"
                }
                Rectangle{
                    height: parent.height * 0.25
                    width: parent.width
                    color: "#3B3A3A"
                    anchors.bottom: parent.bottom
                }
            }
        }
        Row{
            height: parent.height * 0.1
            width: parent.width
            Item{
                height: parent.height
                width: parent.width * 0.25
            }

            Text{
                text: "Gremsy Flash Tools"
                height: parent.height
                width: parent.width * 0.5
                font.pixelSize: height * 0.5
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                color: "darkorange"
            }
        }
        Row{
            height: parent.height * 0.05
            width: parent.width
            Item{
                height: parent.height
                width: parent.width * 0.25
            }

            Text{
                text: "v1.0.1           "
                height: parent.height
                width: parent.width * 0.5
                font.pixelSize: height * 0.5
                verticalAlignment: Text.AlignTop
                horizontalAlignment: Text.AlignRight
                color: "#e8e8e8"
            }
        }
        Item{
            height: parent.height * 0.2
            width: parent.width
        }

        Row{
            height: parent.height * 0.05
            width: parent.width
            Item{
                height: parent.height
                width: parent.width * 0.25
            }

            Text{
                text: "Developed by Gremsy"
                height: parent.height
                width: parent.width * 0.5
                font.pixelSize: height * 0.5
                verticalAlignment: Text.AlignTop
                horizontalAlignment: Text.AlignHCenter
                color: "#e8e8e8"
            }
        }
    }
}

