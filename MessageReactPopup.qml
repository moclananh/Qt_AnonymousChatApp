import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Helpers 1.0

Popup {
    id: messageOption
    background: Rectangle {
        width: parent.width
        height: parent.height
        color: "transparent"
    }

    ClipboardHelper {
        id: clipboardHelper
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
}
