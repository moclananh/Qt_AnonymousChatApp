import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material
import cookie.service 1.0
import network.service 1.0

Rectangle {
    id: createChatRoomId
    width: parent.width
    height: parent.height
    color: "white"

    //signal register
    signal roomCreated(int groupId)

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
                            model: ["15 minutes", "30 minutes", "60 minutes"]
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
                            model: ["10 members", "20 members", "30 members"]
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
                            MouseArea {
                                anchors.fill: btnCreateRoom
                                onClicked: {
                                    if (txtName.text.trim() === "") {
                                        txtName.focus = true
                                        txtName.placeholderText = "Name is required!"
                                    } else if (txtRoomCode.text.trim() === "") {
                                        txtRoomCode.focus = true
                                        txtRoomCode.placeholderText = "Room code is required!"
                                    } else {
                                        createChatRoomId.createChatRoom()
                                    }
                                }
                            }
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

            // console.log("Response from API:", response)
            if (jsonData.group_name) {
                console.log("Group created successfully:", jsonData.group_name)
                cookieId.saveCookie("user_id", jsonData.user_id, 3600000)
                cookieId.saveCookie("user_name", jsonData.username, 3600000)
                cookieId.saveCookie("user_code", jsonData.user_code, 3600000)

                notifyMessageBoxId.message = "Create room successfully"
                notifyMessageBoxId.open()

                createChatRoomId.roomCreated(jsonData.group_id)
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

    // fn create new room
    function createChatRoom() {
        // Validation successful, proceed
        var requestData = {
            "approval_require": optinalId.checked,
            "duration": cbDuration.currentIndex === 3 ? 0 : parseInt(
                                                            cbDuration.currentText),
            "group_name": txtRoomCode.text,
            "maximum_members": cbLimitMember.currentIndex === 3 ? 0 : parseInt(
                                                                      cbLimitMember.currentText),
            "username": txtName.text
        }

        var jsonData = JSON.stringify(requestData)

        var headers = {}

        // API call using ChatServices.fetchData
        networkManager.fetchData("http://127.0.0.1:8080/add-user-group",
                                 "POST", headers, jsonData)
    }
}
