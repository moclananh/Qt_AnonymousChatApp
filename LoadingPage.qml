import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material

ApplicationWindow {
    visible: true
    width: 900
    height: 600
    title: "Waiting"

    Column {
        anchors.centerIn: parent
        spacing: 10
        width: parent.width
        AnimatedImage {
            id: imgId
            source: "qrc:/images/waiting.gif"
            anchors.horizontalCenter: parent.horizontalCenter
            width: 300
            height: 300
        }

        Text {
            text: "Request sended, please wait a second "
            font.bold: true
            font.pixelSize: 35
            color: "#761f84"
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
        }
    }
}
