import QtQuick
import QtQuick.Controls

Drawer {
    id: drawerRoot
    width: 350
    height: parent.height
    edge: Qt.RightEdge
    property string control_handle: ""
    property string lableText
    background: Rectangle {
        anchors.fill: parent
        color: "#f1f5f9"
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
        }

        //search field
        TextField {
            id: searchField
            placeholderText: "Search"
            height: 30
            width: parent.width - 20
        }

        //member list
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

                Row {
                    width: parent.width
                    height: parent.height
                    anchors.fill: parent

                    Rectangle {

                        width: parent.width - 20
                        height: parent.height
                        color: "transparent"

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
            }
        }
    }
}
