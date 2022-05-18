import QtQuick 2.0

Item {
    property bool wait_connect: false
    property int m_value: 0
    property double run_x: 0
    property double step_x: 10
    property bool button_busy: false
    property int mode: 0 // 0: percent, 1: wait


    Rectangle{
        id: background
        anchors.fill: parent
        color: "gray"
        Text {
            z:2
            anchors.fill: parent
            text: m_value + "%"
            visible: (mode == 0) && (m_value > 0)

            color: "black"
            font.pixelSize: height * 0.4
            verticalAlignment:Text.AlignVCenter
            horizontalAlignment:Text.AlignHCenter
        }
        Rectangle{ // progress
            x: 0
            z:1
            visible: (mode == 0)
            height: parent.height
            width: (m_value * parent.width)/100
            color: "green"


        }
        Rectangle{      // wait
            id: pn_wait
            x: run_x  // 0 <--> (parent.width - width)
            visible: (mode == 1)
            height: parent.height
            width: parent.width*0.25
            color: "green"
        }
    }


    Timer {
        interval: 10
        repeat: true
        running: (mode == 1)
        onTriggered: {
            run_x +=step_x

            if(run_x >= (parent.width - pn_wait.width)){
                step_x = -1 * Math.abs(step_x)
            }else if(run_x <= 1){
                step_x = 1 * Math.abs(step_x)
            }

        }
     }

    function mode_change_wait(){
        mode = 1
    }
    function mode_change_progress(){
        mode = 0
        m_value =0

    }
}
