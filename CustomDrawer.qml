import QtQuick
import QtQuick.Controls

Drawer {
    property QtObject d_settings
    id: drawerRoot
    width: 350
    height: parent.height
    edge: Qt.RightEdge
    property string control_handle: ""
    property string lableText
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
            height: parent.height * 0.8 // Adjust height as needed
            model: ListModel {
                // Example data; replace with real data
                ListElement {
                    username: "John Doe"
                    image: "https://placehold.co/50x50"
                }
                ListElement {
                    username: "Jane Smith"
                    image: "https://placehold.co/50x50"
                }
                ListElement {
                    username: "John Cena"
                    image: "https://placehold.co/50x50"
                }
                ListElement {
                    username: "Halley Queen"
                    image: "https://placehold.co/50x50"
                }
                ListElement {
                    username: "Justin Biber"
                    image: "https://placehold.co/50x50"
                }
            }
            clip: true
            delegate: Item {
                width: memberListView.width
                height: 40

                Rectangle {
                    id: itemBackground
                    width: parent.width - 20
                    height: parent.height
                    color: "transparent"

                    Rectangle {
                        width: parent.width - 10
                        height: parent.height
                        color: "transparent"
                        anchors.horizontalCenter: parent.horizontalCenter

                        Row {
                            width: parent.width
                            height: parent.height
                            anchors.fill: parent

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

                            Image {
                                visible: control_handle === "accept" ? true : false
                                source: "qrc:/images/checked.png"
                                smooth: true
                                anchors.verticalCenter: parent.verticalCenter
                                height: 20
                                width: 20
                                anchors.right: btnDelete.left
                            }

                            Image {
                                id: btnDelete
                                source: "qrc:/images/delete_15194236.png"
                                smooth: true
                                anchors.verticalCenter: parent.verticalCenter
                                height: 20
                                width: 20
                                anchors.right: parent.right
                            }
                        }
                    }

                    // Hover effect
                    MouseArea {
                        id: hoverArea
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: itemBackground.color = d_settings.hover_color
                        onExited: itemBackground.color = "transparent"
                    }
                }
            }
        }
    }
}
