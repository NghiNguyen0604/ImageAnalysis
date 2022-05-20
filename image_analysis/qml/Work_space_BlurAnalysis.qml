import QtQuick 2.15
import QtQuick.Dialogs 1.1
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtMultimedia 5.15

Item{
    anchors.fill: parent

    property var pre_model_list_changed: []
    property var model_list_changed: []
    property string _image_path: ""

        FileDialog {
            id:image_filedialog
            title: "Images"
            folder: shortcuts.home
            selectExisting: true
    //        selectMultiple:true
    //        onSelectMultipleChanged: {}
            nameFilters: ["JPG file (*.jpg)","JPEG file (*.jpeg)","PNG file (*.png)"]
            onAccepted: {

                _image_path =image_filedialog.fileUrl.toString();
                _image_path=_image_path.replace(/^(file:\/{3})/,"");
                _image_path=decodeURIComponent(_image_path);
                console.log(_image_path)
                imageProvider.setImagePath(_image_path)

            }
            onRejected: {
                _image_path= ""
            }
        }
    Column{
        anchors.fill: parent
        Item{
            id:pn_title
            width: parent.width
            height: parent.height*0.075
        }
        Item{
            id:pn_info_gimbal
            width:parent.width
            height: parent.height*0.075
            Row{
                anchors.fill:parent
                Rectangle{
                    color: "#3B3A3A"
                    width: parent.width*0.85
                    height: parent.height
                }

                Button_workspace{
                    id:bt_openfile_video
                    enabled: true
                    height: parent.height
                    width: parent.width *0.15
                    img_src: ""
                    img_width: 0
                    img_height: 0
                    item_height: height
                    item_width: width
                    object_name: "Image"
                    txt_tooltip: "Select file path."
                    onUser_press: {
                        text_scale=0.8
                    }
                    onUser_released: {
                        text_scale=1
                    }
                    onUser_clicked: {
//                        imageProvider.test()

                                                image_filedialog.open()
                    }
                }

            }

        }
        ///reserved for tool bar
        //        Item{
        //            id:video_option
        //            height: parent.height*0.075
        //            width: parent.width
        //            Row{
        //                anchors.fill:parent
        //                Rectangle{
        //                    color: "#3B3A3A"
        //                    width: parent.width*0.55
        //                    height: parent.height
        //                }
        //                Item{
        //                    id:pn_hide_show_video
        //                    height: parent.height
        //                    width: parent.width *0.15
        //                    enabled: bt_analysis_clicked
        //                    Button_workspace{
        //                        id:bt_hide_video
        //                        anchors.fill: parent
        //                        enabled: true
        //                        visible: _visible_hide_video
        //                        img_src: ""
        //                        img_width: 0
        //                        img_height: 0
        //                        item_height: height
        //                        item_width: width
        //                        object_name: "Hide Video"
        //                        onUser_press: {
        //                            text_scale=0.8
        //                        }
        //                        onUser_released: {
        //                            text_scale=1
        //                        }
        //                        onUser_clicked: {
        //                            _visible_video= false

        //                            _visible_hide_video=false
        //                            _visible_show_video=true
        //                        }
        //                    }
        //                    Button_workspace{
        //                        id:bt_show_video
        //                        anchors.fill: parent
        //                        enabled: true
        //                        visible: _visible_show_video
        //                        img_src: ""
        //                        img_width: 0
        //                        img_height: 0
        //                        item_height: height
        //                        item_width: width
        //                        object_name: "Show Video"
        //                        onUser_press: {
        //                            text_scale=0.8
        //                        }
        //                        onUser_released: {
        //                            text_scale=1
        //                        }
        //                        onUser_clicked: {
        //                            _visible_video=true
        //                            _visible_hide_video=true
        //                            _visible_show_video=false

        //                        }

        //                    }

        //                }

        //                Button_workspace {
        //                    id:bt_clear_chart
        //                    height: parent.height
        //                    width: parent.width*0.15
        //                    enabled: bt_analysis_clicked
        //                    img_src: ""
        //                    img_width: 0
        //                    img_height: 0
        //                    item_height: height
        //                    item_width: width
        //                    object_name: "Clear Chart"
        //                    onUser_press: {
        //                        text_scale=0.8
        //                    }
        //                    onUser_released: {
        //                        text_scale=1
        //                    }

        //                    onUser_clicked: {
        //                        bt_clear_clicked=true
        //                        bt_clear_change(bt_clear_clicked)

        //                        clear_chart()
        //                        console.log("Clicked clear")
        //                    }
        //                }
        //                Item{
        //                    id:pn_hide_show_chart
        //                    enabled: bt_analysis_clicked
        //                    height: parent.height
        //                    width: parent.width *0.15
        //                    Button_workspace{
        //                        id:bt_hide_chart
        //                        anchors.fill: parent
        //                        enabled: true
        //                        visible: _visible_hide_bt
        //                        img_src: ""
        //                        img_width: 0
        //                        img_height: 0
        //                        item_height: height
        //                        item_width: width
        //                        object_name: "Hide Chart"
        //                        onUser_press: {
        //                            text_scale=0.8
        //                        }
        //                        onUser_released: {
        //                            text_scale=1
        //                        }

        //                        onUser_clicked: {
        //                            _visible_dx=false
        //                            _visible_dy=false
        //                            _visible_da=false
        //                            pn_vertical.visible=fasle
        //                            pn_horizontal.visible=false
        //                            _visible_hide_bt=false
        //                            _visible_show_bt=true

        //                        }

        //                    }
        //                    Button_workspace{
        //                        id:bt_show_chart
        //                        anchors.fill: parent
        //                        enabled: true
        //                        visible: _visible_show_bt
        //                        img_src: ""
        //                        img_width: 0
        //                        img_height: 0
        //                        item_height: height
        //                        item_width: width
        //                        object_name: "Show Chart"
        //                        onUser_press: {
        //                            text_scale=0.8
        //                        }
        //                        onUser_released: {
        //                            text_scale=1
        //                        }

        //                        onUser_clicked: {
        //                            _visible_dx=true
        //                            _visible_dy=true
        //                            _visible_da=true
        //                            pn_vertical.visible=true
        //                            pn_horizontal.visible=true
        //                            _visible_hide_bt=true
        //                            _visible_show_bt=false

        //                        }

        //                    }


        //                }
        //            }
        //        }

        Item{
            id:pn_video
            width: parent.width
            height: parent.height*0.75
            DisplayImages{
                anchors.fill: parent
                sourceRaw:"image://live/raw"
                sourceFiltered:"image://live/filtered"
            }

        }
        Item{
            id:pn_path_video_file
            width: parent.width
            height: parent.height*0.25
            Text {
                id: txt_file_path
                anchors.fill: parent
                text: _image_path
                color: "#e8e8e8"
            }
        }
    }
    Component.onCompleted: {
    }
    Connections{
        target:imageProvider
        ignoreUnknownSignals: true

    }
}
