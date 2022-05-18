import QtQuick 2.0
import QtQuick.Dialogs 1.1

Item {
    property string title_text: ""
    property string message_text: ""
    function _open(){

        messageDialog.open()
    }
    function _close(){
        messageDialog.close()
    }

    MessageDialog {
        id:messageDialog
        title: title_text
        text: message_text

        onAccepted: {
            //none
        }
    }
}
