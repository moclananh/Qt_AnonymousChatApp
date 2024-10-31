import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material

// ApplicationWindow {
//     visible: true
//     width: 900
//     height: 500
//     title: "Join Room"
Rectangle {
    width: parent.width
    height: parent.height
    color: "white"
    Loader {
        id: pageLoader
        anchors.fill: parent
    }
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
                    source: "qrc:/images/landing4.gif"
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
                // anchors.verticalCenter: parent.verticalCenter
                Rectangle {
                    id: rectChatHeader
                    width: parent.width * 0.8
                    height: parent.height * 0.7
                    anchors.centerIn: parent

                    color: "transparent"
                    Column {
                        id: containter
                        spacing: 10

                        Text {
                            text: "Join Room"
                            font.bold: true
                            font.pixelSize: 35
                            color: "#761f84"
                        }

                        //user name
                        Text {
                            text: "User Name"
                            color: "#761f84"
                        }
                        TextField {
                            id: txtName
                            placeholderText: "Enter your name..."
                            width: chatContent.width * 0.6
                            height: 40
                        }

                        //room code
                        Text {
                            text: "Room Code"
                            color: "#761f84"
                        }
                        TextField {
                            id: txtRoomCode
                            placeholderText: "Enter room code..."
                            width: chatContent.width * 0.6
                            height: 40
                        }

                        //room code
                        Text {
                            text: "Message"
                            color: "#761f84"
                        }
                        TextField {
                            id: txtMessage
                            placeholderText: "Enter a message..."
                            width: chatContent.width * 0.6
                            height: 40
                        }
                    }

                    //btn join room
                    MyButton {
                        id: btnJoinRoom
                        height: 40
                        width: 100
                        text: "Join"
                        anchors.top: containter.bottom
                        anchors.topMargin: 20
                        MouseArea {
                            anchors.fill: btnJoinRoom

                            onClicked: {
                                // Validation logic
                                if (txtName.text.trim() === "") {
                                    txtName.focus = true
                                    txtName.placeholderText = "Name is required!"
                                } else if (txtRoomCode.text.trim() === "") {
                                    txtRoomCode.focus = true
                                    txtRoomCode.placeholderText = "Room code is required!"
                                } else {
                                    // Validation successful, proceed
                                    pageLoader.source = "LoadingPage.qml"
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
