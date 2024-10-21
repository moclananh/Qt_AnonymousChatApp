import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material

// ApplicationWindow {
//     visible: true
//     width: 900
//     height: 500
//     title: "Create Chat Room"
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
                    source: "qrc:/images/landing2.gif"
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
                    height: parent.height * 0.9
                    // anchors.fill: parent
                    anchors.centerIn: parent

                    color: "transparent"
                    Column {

                        spacing: 10

                        Text {
                            text: "Create New Room"
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
                            width: parent.width
                            height: 40
                        }

                        //room code
                        Text {
                            text: "Room Name"
                            color: "#761f84"
                        }
                        TextField {
                            id: txtRoomCode
                            placeholderText: "Enter room code..."
                            width: parent.width
                            height: 40
                        }

                        //duration
                        Text {
                            text: "Duration"
                            color: "#761f84"
                        }
                        ComboBox {
                            id: cbDuration
                            height: 35
                            width: parent.width * 0.5
                            model: ["15 minutes", "30 minutes", "60 minutes", "Unlimited"]
                        }

                        // Maximum member
                        Text {
                            text: "Maximum Member"
                            color: "#761f84"
                        }
                        ComboBox {
                            id: cbLimitMember
                            height: 35
                            width: parent.width * 0.5
                            model: ["10 members", "20 members", "30 members", "Unlimited"]
                        }

                        //Check box
                        CheckBox {
                            id: optinalId
                            text: "A new member need to be approved to join"
                        }

                        //btn create
                        MyButton {

                            id: btnCreateRoom
                            height: 40
                            width: 100
                            text: "Create"
                            // anchors.top: optinalId.bottom
                            // width: 100
                            // height: 40
                            MouseArea {
                                anchors.fill: btnCreateRoom
                                onClicked: {
                                    pageLoader.source = "Main.qml"
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
