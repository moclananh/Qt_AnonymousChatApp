import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Helpers 1.0
import network.service 1.0
import cookie.service 1.0

Popup {

    property int c_user_id: cookieId.loadCookie("user_id")
    property string c_user_code: cookieId.loadCookie("user_code")
    signal messageSignal(int groupId)

    id: messageOption
    background: Rectangle {
        width: parent.width
        height: parent.height
        color: "transparent"
    }

    //services register
    Cookie {
        id: cookieId
    }

    ClipboardHelper {
        id: clipboardHelper
    }

    CustomNotify {
        id: notifyMessageBoxId
        message: ""
    }

    // Reaction Popup
    Rectangle {
        id: rect_reaction
        width: 160
        height: 30
        color: settings.icon_bg
        radius: 15
        anchors.horizontalCenter: parent.horizontalCenter
        Row {
            anchors.centerIn: parent
            spacing: 5
            Rectangle {
                width: 20
                height: 20
                color: "transparent"
                Text {
                    id: r_like
                    font.pixelSize: 15
                    anchors.centerIn: parent
                    text: "👍"
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("Reaction: Like")
                        messageOption.close()
                    }
                    hoverEnabled: true
                    onEntered: r_like.font.pixelSize = 20
                    onExited: r_like.font.pixelSize = 15
                }
            }

            Rectangle {
                width: 20
                height: 20
                color: "transparent"
                Text {
                    id: r_love
                    anchors.centerIn: parent
                    text: "❤️"
                    font.pixelSize: 15
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("Reaction: Love")
                        messageOption.close()
                    }
                    hoverEnabled: true
                    onEntered: r_love.font.pixelSize = 20
                    onExited: r_love.font.pixelSize = 15
                }
            }

            Rectangle {
                width: 20
                height: 20
                color: "transparent"
                Text {
                    id: r_haha
                    anchors.centerIn: parent
                    text: "😆"
                    font.pixelSize: 15
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("Reaction: Haha")
                        messageOption.close()
                    }
                    hoverEnabled: true
                    onEntered: r_haha.font.pixelSize = 20
                    onExited: r_haha.font.pixelSize = 15
                }
            }

            Rectangle {
                width: 20
                height: 20
                color: "transparent"
                Text {
                    id: r_wow
                    anchors.centerIn: parent
                    text: "😯"
                    font.pixelSize: 15
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("Reaction: Wow")
                        messageOption.close()
                    }
                    hoverEnabled: true
                    onEntered: r_wow.font.pixelSize = 20
                    onExited: r_wow.font.pixelSize = 15
                }
            }

            Rectangle {
                width: 20
                height: 20
                color: "transparent"
                Text {
                    id: r_sad
                    anchors.centerIn: parent
                    text: "☹️"
                    font.pixelSize: 15
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("Reaction: Sad")
                        messageOption.close()
                    }
                    hoverEnabled: true
                    onEntered: r_sad.font.pixelSize = 20
                    onExited: r_sad.font.pixelSize = 15
                }
            }

            Rectangle {
                width: 20
                height: 20
                color: "transparent"
                Text {
                    id: r_angry
                    anchors.centerIn: parent
                    text: "😠"
                    font.pixelSize: 15
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("Reaction: Angry")
                        messageOption.close()
                    }
                    hoverEnabled: true
                    onEntered: r_angry.font.pixelSize = 20
                    onExited: r_angry.font.pixelSize = 15
                }
            }
        }
    }

    // message option Popup
    Rectangle {
        id: rect_messageOption
        width: 150
        radius: 5
        height: model.user_id === chatContent.c_user_id ? 150 : 90
        color: settings.icon_bg
        anchors.top: rect_reaction.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter

        Rectangle {
            width: parent.width - 4
            anchors.centerIn: parent
            height: parent.height - 4
            color: "transparent"

            ColumnLayout {
                spacing: 5
                anchors.fill: parent
                Rectangle {
                    id: p_copy
                    width: parent.width

                    height: 25
                    radius: 5
                    color: "transparent"

                    Text {
                        id: p_copy_txt
                        text: "  Copy text"
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            clipboardHelper.setText(model.message)
                            console.log("Group code was copied into clipboard: " + model.message)

                            messageOption.close()
                        }
                        hoverEnabled: true
                        onEntered: p_copy.color = "#e5e7eb"
                        onExited: p_copy.color = "transparent"
                    }
                }

                Rectangle {
                    id: p_reply
                    width: parent.width

                    height: 25
                    color: "transparent"
                    radius: 5
                    Text {
                        text: "  Reply"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            console.log("Reply clicked")
                            messageOption.close()
                        }
                        hoverEnabled: true
                        onEntered: p_reply.color = "#e5e7eb"
                        onExited: p_reply.color = "transparent"
                    }
                }

                Rectangle {
                    id: p_edit
                    width: parent.width

                    height: 25
                    color: "transparent"
                    radius: 5
                    visible: model.user_id === c_user_id
                    Text {
                        text: "  Edit"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            console.log("Edit clicked")
                            messageOption.close()
                        }
                        hoverEnabled: true
                        onEntered: p_edit.color = "#e5e7eb"
                        onExited: p_edit.color = "transparent"
                    }
                }

                Rectangle {
                    id: p_pin
                    width: parent.width

                    height: 25
                    color: "transparent"
                    radius: 5
                    Text {
                        text: "  Pin message"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            console.log("Pin clicked")
                            messageOption.close()
                        }
                        hoverEnabled: true
                        onEntered: p_pin.color = "#e5e7eb"
                        onExited: p_pin.color = "transparent"
                    }
                }

                Rectangle {
                    id: p_delete
                    width: parent.width

                    height: 25
                    radius: 5
                    color: "transparent"

                    visible: model.user_id === c_user_id
                    Text {
                        text: "  Delete message"
                        anchors.verticalCenter: parent.verticalCenter
                        color: "red"
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            console.log("Delete message clicked on message_id: " + model.ms_id)
                            deleteMessage(model.ms_id)
                            messageOption.close()
                        }
                        hoverEnabled: true
                        onEntered: p_delete.color = "#e5e7eb"
                        onExited: p_delete.color = "transparent"
                    }
                }
            }
        }
    }

    NetworkManager {
        id: networkManager
        onStatusCodeReceived: function (response) {
            var jsonData = JSON.parse(response)

            console.log("Data received: " + jsonData)
            // if (response) {
            var statusCode = parseInt(jsonData)
            console.log("Status code received: " + statusCode)

            console.log("Message deleted!")
            app_state.messageSignal()
            //}
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
    function deleteMessage(message_id) {

        var headers = {
            "x-user-code": c_user_code
        }

        // API call using ChatServices.fetchData
        networkManager.fetchData(
                    `http://127.0.0.1:8080/messages/${message_id}`,
                    "DELETE", headers)
    }
}
