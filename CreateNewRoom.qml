import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Universal

Drawer {

    property QtObject settings
    width: 300
    height: parent.height
    edge: Qt.LeftEdge
    //  modal: false
    background: Rectangle {
        color: settings.user_drawer
    }

    Rectangle {
        id: rectChatHeader
        width: parent.width * 0.85
        height: parent.height * 0.75
        anchors.centerIn: parent

        color: "transparent"
        Column {

            spacing: 10

            Text {
                text: "Create New Room"
                font.bold: true
                font.pixelSize: 30
                color: settings.txt_color
            }

            //user name
            Text {
                text: "User Name"
                color: settings.txt_color
            }
            TextField {
                id: txtName
                placeholderText: "Enter your name..."
                width: rectChatHeader.width
                height: 40
            }

            //room code
            Text {
                text: "Room Name"
                color: settings.txt_color
            }
            TextField {
                id: txtRoomCode
                placeholderText: "Enter room code..."
                width: rectChatHeader.width
                height: 40
            }

            //duration
            Text {
                text: "Duration"
                color: settings.txt_color
            }
            ComboBox {
                id: cbDuration
                height: 35
                width: rectChatHeader.width * 0.5
                model: ["15 minutes", "30 minutes", "60 minutes", "Unlimited"]
            }

            // Maximum member
            Text {
                text: "Maximum Member"
                color: settings.txt_color
            }
            ComboBox {
                id: cbLimitMember
                height: 35
                width: rectChatHeader.width * 0.5
                model: ["10 members", "20 members", "30 members", "Unlimited"]
            }

            //Check box
            CheckBox {
                id: optinalId
                background: Rectangle {
                    width: 15
                    height: 15
                    anchors.centerIn: parent
                }

                Text {
                    text: "Member must be approve to join"
                    color: settings.txt_color
                    anchors.left: optinalId.right
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            //btn create
            MyButton {

                id: btnCreateRoom
                height: 40
                width: 100
                text: "Create"
                MouseArea {
                    anchors.fill: btnCreateRoom
                    onClicked: {
                        // Validation logic
                        if (txtName.text.trim() === "") {
                            txtName.focus = true
                            txtName.placeholderText = "Name is required!"
                        } else if (txtRoomCode.text.trim() === "") {
                            txtRoomCode.focus = true
                            txtRoomCode.placeholderText = "Room code is required!"
                        } else {
                            console.log("Create new room")
                        }
                    }
                }
            }
        }
    }
}
