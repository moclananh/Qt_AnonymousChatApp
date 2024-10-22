import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material

ApplicationWindow {
    visible: true
    width: 500
    height: 300
    title: "Waiting"
    color: "white"
    Column {
        anchors.centerIn: parent
        spacing: 10
        width: parent.width
        AnimatedImage {
            id: imgId
            source: "qrc:/images/waiting.gif"
            anchors.horizontalCenter: parent.horizontalCenter
            width: 200
            height: 200
        }

        Text {
            text: "Request sended, please wait a second "
            font.bold: true
            font.pixelSize: 20
            color: "#761f84"
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
        }
    }
}
