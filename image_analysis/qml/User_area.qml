import QtQuick 2.0
import QtQuick.Controls 2.15
Item {
    property int click_current_index_: -1
    property double sharpness_:0

    onClick_current_index_Changed: {

        if(click_current_index_ == 1){
            bt_sharpness.checked=true
            bt_reserved.checked=false

        }
        else if(click_current_index_ == 2){
            bt_sharpness.checked=false
            bt_reserved.checked=true

        }
        else if(click_current_index_ == 3){
            bt_sharpness.checked=false
            bt_reserved.checked=false

        }
        else if(click_current_index_ == 4){
            bt_sharpness.checked=false
            bt_reserved.checked=false

        }
    }


    property bool _checkpoint: false

    Rectangle{
        anchors.fill: parent
        color: "#171717"
        Column{
            id:user_area
            anchors.fill: parent
            Item{
                id:pn_title
                width: parent.width
                height: parent.height*0.075
            }
            Item{
                id:user_analysis
                height: parent.height*0.75
                width: parent.width
                Column{
                    anchors.fill: parent
                    Item{
                        id:pn_analysis
                        height: parent.height*0.1
                        width: parent.width
                        enabled: true
                        Text {
                            anchors.fill: parent
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: height*0.25
                            text: "Results"
                            color: "#ffffff"
                            opacity: 3
                        }


                    }
                    Item{
                        id:pn_space_
                        height: parent.height*0.002
                        width: parent.width
                    }
                    Item{
                        height: parent.height*0.898
                        width: parent.width
                        Column{
                            anchors.fill: parent
                            Rectangle{
                                width: parent.width
                                height: parent.height*0.002
                                color: "#e8e8e8"
                            }
                            Item{
                                width: parent.width
                                height: parent.height*0.075
                                Row{
                                    anchors.fill: parent
                                    Rectangle{
                                        id:border_tab
                                        width: 1.0
                                        height: parent.height
                                        color: "#777777"
                                    }
                                    Button_bar{
                                        id:bt_sharpness
                                        enabled: true
                                        width: parent.width*0.5
                                        height:parent.height
                                        img_src_active: ""
                                        img_src_unactive: ""
                                        img_width: 0
                                        img_height: 0
                                        item_height: height
                                        item_width: width
                                        object_name: "Sharpness"

                                        onUser_click: {
                                            click_current_index_=1

                                        }
                                    }
                                    Rectangle{
                                        id:border_tab1
                                        width: 1.0
                                        height: parent.height
                                        color: "#777777"
                                    }

                                    Button_bar{
                                        id:bt_reserved
                                        enabled: true
                                        height: parent.height
                                        width: parent.width*0.5
                                        img_src_active: ""
                                        img_src_unactive: ""

                                        img_width: 0
                                        img_height:0
                                        item_height: height
                                        item_width: width
                                        object_name: "Reserved"
                                        onUser_click: {
                                            click_current_index_=2
                                        }
                                    }
                                    Rectangle{
                                        id:border_tab2
                                        width: 1.0
                                        height: parent.height
                                        color: "#777777"
                                    }


                                }
                            }
                            Rectangle{
                                width: parent.width
                                height: parent.height*0.002
                                color: "#e8e8e8"
                            }
                            Item{
                                id:pn_output
                                width: parent.width
                                height: parent.height*0.921
                                Item{
                                    id:pn_output_sharpness
                                    visible: (click_current_index_==1)? true : false
                                    anchors.fill: parent
                                    Column{
                                        anchors.fill: parent

                                        Item{
                                            id:pn_note
                                            height: parent.height*0.05
                                            width: parent.width
                                            Row{
                                            anchors.fill:parent
                                            Text {

                                                text: qsTr("Variance: ")
                                                color: "#e8e8e8"
                                            }
                                            Text {

                                                text: sharpness_
                                                color: "#ffffff"
                                            }
                                            }
                                        }
                                    }
                                }
                                Item{
                                    id:pn_output_reserved
                                    visible: (click_current_index_==2)? true : false
                                    anchors.fill: parent
                                    Column{
                                        anchors.fill: parent

                                        Item{
                                            id:pn_note_
                                            height: parent.height*0.05
                                            width: parent.width
                                            Text {
                                                id: txt_note_
                                                text: qsTr("Reserved.")
                                                color: "#e8e8e8"
                                            }
                                        }
                                    }

                                }


                            }

                            Rectangle{
                                id:space___
                                width: parent.width
                                height: parent.height*0.002
                                color: "#e8e8e8"
                            }

                        }
                    }
                }
            }
        }
    }
    Component.onCompleted:{
        click_current_index_=1
    }
    Connections{
        target:imageProvider
        ignoreUnknownSignals: true

        function onResultWithLaplaceOperator(sharpness){
            sharpness_=sharpness
        }

    }


}

