import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Imagine

Rectangle {
    width: parent.width
    height: parent.height
    color: "white"

    ColumnLayout {
        anchors.fill: parent
        width: parent.width
        height: parent.height

        RowLayout {
            width: parent.width
            height: parent.height

            // Image
            Rectangle {
                Layout.minimumWidth: 0
                Layout.fillHeight: true
                color: "transparent"
                width: parent.width / 2 * 0.9
                height: parent.height
                visible: parent.width > 800
                AnimatedImage {
                    source: "qrc:/images/landing1.gif"
                    width: parent.width * 0.95
                    height: parent.height * 0.75
                    anchors.centerIn: parent
                }
            }

            // Information
            Rectangle {
                id: chatContent
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "#f9edf9"

                Rectangle {
                    id: rectChatHeader
                    width: parent.width * 0.8
                    height: parent.height * 0.4
                    anchors.centerIn: parent
                    color: "transparent"
                    Column {
                        spacing: 30

                        Text {
                            text: "Anonymous Chatting"
                            font.bold: true
                            font.pixelSize: 35
                            color: "#761f84"
                        }

                        Text {
                            text: "Create or join temporary chat groups without revealing your identity. Enjoy spontaneous conversations with a time limit for privacy. Connect freely and securely!"
                            font.pixelSize: 14
                            wrapMode: Text.WordWrap
                            width: rectChatHeader.width
                            color: "#761f84"
                        }

                        Button {
                            id: btnCreateRoom
                            height: 40
                            width: 100
                            text: "Read More"
                            background: Rectangle {
                                height: parent.height
                                width: parent.width
                                border.width: 1
                                radius: 5
                                color: "#a56dd0"
                            }

                            onClicked: {
                                Qt.openUrlExternally("https://example.com/")
                            }
                        }
                    }
                }
            }
        }
    }
}
