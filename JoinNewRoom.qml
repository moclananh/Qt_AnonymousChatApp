import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Universal
import cookie.service 1.0
import network.service 1.0

Drawer {
    id: root

    //properties init
    property QtObject settings
    property string user_code: cookieId.loadCookie("user_code")
    property string user_name: cookieId.loadCookie("user_name")
    signal successSignal
    signal groupIdSignal(int groupId)

    width: 300
    height: parent.height
    edge: Qt.LeftEdge
    background: Rectangle {
        color: settings.user_drawer
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
                        root.joinNewRoom()
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
            console.log("Response from API:", response)
            if (response) {
                var jsonData = JSON.parse(response)
                if (jsonData.is_waiting === true) {
                    console.log("request sended!, waiting for accpt")
                    notifyMessageBoxId.message = "Request Sended, please wait for admin of group approve your request !"
                    notifyMessageBoxId.open()
                } else {
                    console.log("Join group successfully:", jsonData.group_name)
                }
                app_state.successSignal()
                app_state.groupIdSignal(jsonData.group_id)
                txtNewRoomCode.text = ""
                txtNewMessage.text = ""
                root.close()
            } else {
                console.log("Failed to fetch apis")
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
            } else if (statusCode === 404) {
                notifyMessageBoxId.message = "Group not found, try again!"
                notifyMessageBoxId.open()
            } else {
                notifyMessageBoxId.message = "Error from server"
                notifyMessageBoxId.open()
            }
        }
    }

    //fn join new room
    function joinNewRoom() {
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

        networkManager.fetchData("http://127.0.0.1:8080/join-group", "POST",
                                 headers, jsonData)
    }
}
