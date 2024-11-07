import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

MessageDialog {
    property string message: ""
    title: "Notice"
    text: message
    buttons: MessageDialog.Ok

    onAccepted: function () {

        console.log("Accepted")
    }
}
