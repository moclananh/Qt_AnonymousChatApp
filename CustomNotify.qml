import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

MessageDialog {
    property string message: ""
    title: "Notice"
    text: message
    buttons: MessageDialog.Ok | MessageDialog.Cancel

    onAccepted: function () {

        console.log("Accepted")
    }

    onRejected: function () {
        console.log("Cancelled")
    }
}
