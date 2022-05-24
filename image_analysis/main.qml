import QtQuick 2.12
import QtQml 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12


import "./qml"

ApplicationWindow {
    id:window

    property double m_scale: 0.8

    width: 1920 * m_scale
    height: 1080 * m_scale
    visible: true
    title: qsTr("Image Analysis")

    property bool bt_analysis_clicked: false

    property string text_filename: ""
    property int progress_bar_status: 0
    property int click_current_index: -1



    //* click_current_index
    // 1 - PSDK
    // 2 - T3P
    // 3 - Information

    onClick_current_indexChanged: {     //Clicked Events
//        console.log("click on " + click_current_index)
//        if(click_current_index == 1){
//            bt_blur_analysis.checked = true
//            bt_info.checked=false
//        }
//        else if(click_current_index == 2){
//            bt_blur_analysis.checked=false
//            bt_info.checked = true

//        }
    }
    //* progress_bar_status
    // 1 - Flash PSDK
    // 2 - Flash T3P
    onProgress_bar_statusChanged: {
        if (progress_bar_status==1){
            progress.m_value=0
        }
        else if (progress_bar_status==2){
            progress.m_value=0
        }
        else if (progress_bar_status==3){
            progress.m_value=0
        }
    }
    Item{
        anchors.fill: parent
        Rectangle{
            id:background
            width: parent.width
            height: parent.height
            color: "#3B3A3A"
            Column{
                spacing:0

                anchors.fill: parent
                ///reserved
//                Rectangle{                      //toolbar
//                    id: menu_bar
//                    width: parent.width
//                    height: parent.height*0.075
//                    color: "#171717"
//                    Row{                 //menubar
//                        spacing:0
//                        width: parent.width
//                        height: parent.height
//                        Button_bar{
//                            id:bt_blur_analysis
//                            enabled: true
//                            width: parent.width*0.1
//                            height:parent.height
//                            img_src_active: ""
//                            img_src_unactive: ""
//                            item_height: height
//                            item_width: width
//                            object_name: "Blurred Image Analysis"

//                            onUser_click: {
//                                click_current_index=1

//                            }
//                        }
//                        Rectangle{
//                            id:border_tab1
//                            width: 1.0
//                            height: parent.height
//                            color: "#777777"
//                        }
//                        Button_bar{
//                            id:bt_info
//                            enabled: true
//                            height: parent.height
//                            width: parent.width*0.1
//                            img_src_active: ""
//                            img_src_unactive: ""
//                            item_height: height
//                            item_width: width
//                            object_name: "Information"
//                            onUser_click: {
//                                click_current_index=2
//                            }
//                        }
//                        Rectangle{
//                            id:border_tab4
//                            width: 1.0
//                            height: parent.height
//                            color: "#777777"
//                        }
//                    }
//                }
                //workspace
                Row{
                    spacing: 0
                    width: parent.width
                    height: parent.height
                    Column{
                        id:workspace
                        width: parent.width*0.8
                        height: parent.height
                        Item{
                            height: parent.height * 0.975
                            width: parent.width
                            Work_space_BlurAnalysis {
                                id:workspace_BlurAnalysis
                                visible: (click_current_index == 1) ? true : false
                                anchors.fill: parent
                            }
                            Work_space_info {
                                id:workspace_info
                                visible: (click_current_index == 2) ? true : false
                                anchors.fill: parent
                            }
                        }
                        Item{
                            id: status_bar
                            visible: true
                            width: parent.width
                            height: parent.height * 0.025

                            M_Progress_Bar {
                                id: progress
                                anchors.fill: parent
                            }


                        }
                    }
                    User_area{
                        id:user_tab
                        width: parent.width*0.2
                        height: parent.height
                    }
                }
            }

        }
    }

    Message_dialog{
        id:user_dialog
        height: parent.height*0.5
        width: parent.width*0.5
        anchors.centerIn: parent
    }

    Component.onCompleted: {
        click_current_index=1
    }
}
