import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Universal
import cookie.service 1.0
import network.service 1.0

Drawer {
    id: root
    property QtObject settings
    width: 300
    height: parent.height
    edge: Qt.LeftEdge
    background: Rectangle {
        color: settings.user_drawer
    }

    // services register
    Cookie {
        id: cookieId
    }

    NetworkManager {
        id: networkManager
        onDataReceived: function (response) {
            var jsonData = JSON.parse(response)

            // console.log("Response from API:", response)
            if (jsonData.group_name) {
                console.log("Join group successfully:", jsonData.group_name)
                root.close()
            }
        }
        onRequestError: console.log("Network error: " + error)
    }

    Rectangle {
        id: rectJoinNewRoom
        width: parent.width * 0.85
        height: parent.height * 0.5
        color: "transparent"
        anchors.centerIn: parent

        Column {
            id: containter
            spacing: 10

            Text {
                text: "Join New Room"
                font.bold: true
                font.pixelSize: 30
                color: settings.txt_color
            }

            //room code
            Text {
                text: "Room Code"
                color: settings.txt_color
            }
            TextField {
                id: txtNewRoomCode
                placeholderText: "Enter room code..."
                color: "#232323"
                width: rectJoinNewRoom.width
                height: 40
            }

            //room code
            Text {
                text: "Message"
                color: settings.txt_color
            }
            TextField {
                id: txtNewMessage
                placeholderText: "Enter a message..."
                color: "#232323"
                width: rectJoinNewRoom.width
                height: 40
            }
        }

        //btn join room
        MyButton {
            id: btnJoinNewRoom
            height: 40
            width: 100
            text: "Join"
            anchors.top: containter.bottom
            anchors.topMargin: 20
            MouseArea {
                anchors.fill: btnJoinNewRoom

                onClicked: {
                    // Validation logic
                    if (txtNewRoomCode.text.trim() === "") {
                        txtNewRoomCode.focus = true
                        txtNewRoomCode.placeholderText = "Room code is required!"
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
                            "group_code": txtNewRoomCode.text.trim(),
                            "message": txtNewMessage.text.trim(),
                            "username": user_name ? user_name : ""
                        }

                        var jsonData = JSON.stringify(requestData)

                        // API call using ChatServices.fetchData
                        networkManager.fetchData(
                                    "http://127.0.0.1:8080/join-group", "POST",
                                    headers, jsonData)
                    }
                }
            }
        }
    }
}
