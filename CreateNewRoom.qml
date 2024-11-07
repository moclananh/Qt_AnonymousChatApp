import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Universal
import cookie.service 1.0
import network.service 1.0

Drawer {
    id: root

    // properties init
    property QtObject settings
    property string user_name: cookieId.loadCookie("user_name")
    property string user_code: cookieId.loadCookie("user_code")
    signal successSignal
    signal groupIdSignal(int groupId)

    width: 300
    height: parent.height
    edge: Qt.LeftEdge
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

            // room name
            Text {
                text: "Room Name"
                color: settings.txt_color
            }

            TextField {
                id: txtRoomName
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

                        if (txtRoomName.text.trim() === "") {
                            txtRoomName.focus = true
                            txtRoomName.placeholderText = "Room code is required!"
                        } else {
                            root.createNewRoom()
                        }
                    }
                }
            }
        }
    }

    // services register
    Cookie {
        id: cookieId
    }

    CustomNotify {
        id: notifyMessageBoxId
        message: ""
    }

    NetworkManager {
        id: networkManager
        onDataReceived: function (response) {
            var jsonData = JSON.parse(response)

            //console.log("Response from API:", response)
            if (jsonData.group_name) {
                console.log("Group created successfully:", jsonData.group_name)
                app_state.successSignal()
                app_state.groupIdSignal(jsonData.group_id)
                txtRoomName.text = ""
                root.close()
            } else {
                console.log("create room failed")
            }
        }
        onRequestError: function (error) {
            console.log("Error from API:", error)

            var errorParts = error.split(": ")
            var statusCode = parseInt(errorParts[0], 10)
            var responseBody = errorParts.slice(1).join(": ")

            if (statusCode === 400) {
                notifyMessageBoxId.message = responseBody
                notifyMessageBoxId.open()
            } else {
                notifyMessageBoxId.message = "Error from server"
                notifyMessageBoxId.open()
            }
        }
    }

    //fn create new room
    function createNewRoom() {
        let headers = {}
        if (user_code) {
            headers = {
                "x-user-code": `${user_code}`
            }
        }

        var requestData = {
            "approval_require": optinalId.checked,
            "duration": cbDuration.currentIndex === 3 ? 0 : parseInt(
                                                            cbDuration.currentText),
            "group_name": txtRoomName.text,
            "maximum_members": cbLimitMember.currentIndex === 3 ? 0 : parseInt(
                                                                      cbLimitMember.currentText),
            "username": user_name ? user_name : ""
        }

        var jsonData = JSON.stringify(requestData)

        // API call using ChatServices.fetchData
        networkManager.fetchData("http://127.0.0.1:8080/add-user-group",
                                 "POST", headers, jsonData)
    }
}
