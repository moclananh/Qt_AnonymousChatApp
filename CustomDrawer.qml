import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

Drawer {
    id: drawerRoot
    width: 350
    height: parent.height
    edge: Qt.RightEdge

    property bool control_handle: false
    property string lableText
    property QtObject d_settings
    property ListModel membersModel

    background: Rectangle {
        anchors.fill: parent
        color: d_settings.drawer_color
        radius: 5
    }

    // Manage member header
    Column {
        spacing: 10
        padding: 10
        width: parent.width
        height: parent.height
        anchors.fill: parent

        Text {
            text: drawerRoot.lableText
            font.pixelSize: 20
            color: d_settings.txt_color
        }

        // Search field
        TextField {
            id: searchField
            placeholderText: "Search..."
            color: d_settings.txt_color
            height: 30
            width: parent.width - 20
            background: Rectangle {
                width: parent.width
                height: parent.height
                color: d_settings.message_input
                radius: 15
                border.color: d_settings.border_color
                border.width: 1
            }
        }

        // Member list
        ListView {
            spacing: 2
            id: memberListView
            width: parent.width
            height: parent.height * 0.8
            model: drawerRoot.membersModel
            clip: true
            delegate: Item {
                width: memberListView.width
                height: 40

                Rectangle {
                    id: itemBackground
                    width: parent.width - 20
                    height: parent.height
                    color: "transparent"
                    border.color: d_settings.border_color
                    Rectangle {
                        width: parent.width - 10
                        height: parent.height
                        color: "transparent"
                        anchors.horizontalCenter: parent.horizontalCenter

                        Image {
                            id: img
                            source: model.image
                            width: 30
                            height: 30
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                        }

                        Text {
                            text: model.username
                            font.pixelSize: 16
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: img.right
                            anchors.leftMargin: 5
                            color: d_settings.txt_color
                        }

                        // btn accept
                        Rectangle {
                            id: rectAcceptId
                            width: 30
                            height: 30
                            color: "transparent"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: rectRejectId.left
                            visible: control_handle ? true : false

                            Image {
                                source: d_settings.darkMode ? "qrc:/images/accept2.png" : "qrc:/images/checked.png"
                                smooth: true
                                anchors.centerIn: parent
                                height: 20
                                width: 20
                            }

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered: rectAcceptId.color = d_settings.hover_color
                                onExited: rectAcceptId.color = "transparent"
                                onClicked: {
                                    console.log("Accept button clicked")
                                }
                            }
                        }

                        //btn reject
                        Rectangle {
                            id: rectRejectId
                            width: 30
                            height: 30
                            color: "transparent"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right

                            // anchors.rightMargin: 5
                            Image {
                                id: btnDelete
                                source: d_settings.darkMode ? "qrc:/images/trash2.png" : "qrc:/images/delete_15194236.png"
                                anchors.centerIn: parent
                                smooth: true
                                height: 20
                                width: 20
                            }

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered: rectRejectId.color = d_settings.hover_color
                                onExited: rectRejectId.color = "transparent"
                                onClicked: {
                                    console.log("Reject button clicked")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
