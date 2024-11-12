import QtQuick
import QtQuick.Controls

Popup {
    id: messageOption
    background: Rectangle {
        width: parent.width
        height: parent.height
        color: "transparent"
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
        height: model.user_id === chatContent.c_user_id ? 133 : 79
        color: settings.icon_bg
        anchors.top: rect_reaction.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter

        Column {
            anchors.fill: parent
            spacing: 2
            Rectangle {
                id: p_copy
                width: parent.width
                height: 25
                color: "transparent"

                Text {
                    text: "  Copy text"
                    anchors.verticalCenter: parent.verticalCenter
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("Copy clicked")
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
                        console.log("Delete message clicked")
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
