import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Universal
import cookie.service 1.0
import "ChatServices.js" as ChatServices

Drawer {
    id: root
    property QtObject settings
    width: 300
    height: parent.height
    edge: Qt.LeftEdge
    background: Rectangle {
        color: settings.user_drawer
    }

    Cookie {
        id: cookieId
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

            // room name
            Text {
                text: "Room Name"
                color: settings.txt_color
            }

            TextField {
                id: txtRoomCode
                placeholderText: "Enter room name ..."
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
                model: ["15 minutes", "30 minutes", "60 minutes"]
            }

            // maximum member
            Text {
                text: "Maximum Member"
                color: settings.txt_color
            }

            ComboBox {
                id: cbLimitMember
                height: 35
                width: rectChatHeader.width * 0.5
                model: ["10 members", "20 members", "30 members"]
            }

            // group approve checking
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

                        if (txtRoomCode.text.trim() === "") {
                            txtRoomCode.focus = true
                            txtRoomCode.placeholderText = "Room code is required!"
                        } else {
                            var user_name = cookieId.loadCookie("user_name")
                            var user_code = cookieId.loadCookie("user_code")

                            let headers = null
                            if (user_code) {
                                headers = {
                                    "x-user-code": `${user_code}`
                                }
                            }

                            var requestData = {
                                "approval_require": optinalId.checked,
                                "duration": cbDuration.currentIndex
                                            === 3 ? 0 : parseInt(
                                                        cbDuration.currentText),
                                "group_name": txtRoomCode.text,
                                "maximum_members": cbLimitMember.currentIndex
                                                   === 3 ? 0 : parseInt(
                                                               cbLimitMember.currentText),
                                "username": user_name ? user_name : ""
                            }

                            ChatServices.fetchData(
                                        "http://127.0.0.1:8080/add-user-group",
                                        "POST", headers, function (response) {
                                            if (response) {
                                                let resObject = JSON.parse(
                                                        response)
                                                console.log("Room created successfully:",
                                                            resObject)
                                                root.close()
                                            } else {
                                                console.log("Failed to create room")
                                            }
                                        }, requestData)
                        }
                    }
                }
            }
        }
    }
}
