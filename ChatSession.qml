import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Universal
import QtQuick.Effects
import QtQuick.Dialogs
import "ChatServices.js" as ChatServices

// Chat Section
// Chat Section
Rectangle {
    property QtObject settings
    property QtObject drawer_settings
    id: chatSection
    Layout.minimumWidth: 0
    Layout.fillHeight: true
    color: settings.bg_chatsession_color
    width: 300
    height: parent.height
    visible: parent.width > 800

    ColumnLayout {
        anchors.fill: parent
        width: parent.width
        height: parent.height

        // Search Header
        Rectangle {
            width: parent.width
            height: 40
            color: "transparent"
            Layout.alignment: Qt.AlignTop
            Layout.fillWidth: true

            Rectangle {
                id: btnMenu
                width: 40
                height: 40
                color: "transparent"
                radius: 5
                anchors.left: parent.left
                anchors.leftMargin: 5

                Image {
                    source: settings.darkMode ? "qrc:/images/menu_2.png" : "qrc:/images/menu_1.png"
                    width: 30
                    height: 30
                    anchors.centerIn: parent
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: btnMenu.color = settings.hover_color
                    onExited: btnMenu.color = "transparent"
                    onClicked: {
                        drawer_settings.open()
                    }
                }
            }

            // Search field
            TextArea {
                id: chatField
                width: parent.width - 60
                anchors.left: btnMenu.right
                anchors.leftMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                height: 30
                placeholderText: "Search..."
                color: settings.txt_color
                background: Rectangle {
                    width: parent.width
                    height: parent.height
                    color: settings.message_input
                    radius: 15
                    border.color: settings.border_color
                    border.width: 1
                }
            }
        }

        // Scrollable group list
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true // Ensure scrolling happens within bounds

            ListView {
                id: listViewSessionId
                width: parent.width
                anchors.fill: parent
                model: ListModel {
                    id: groupListModel
                }
                delegate: Item {
                    width: parent.width
                    height: 70
                    property bool isSelected: false
                    property bool isHovered: false

                    Rectangle {
                        id: itemRect
                        width: parent.width - 20
                        height: 70
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: isSelected ? settings.choose_color : (isHovered ? settings.hover_color : "transparent")
                        border.color: "transparent"

                        RowLayout {
                            spacing: 10
                            anchors.fill: parent
                            anchors.margins: 5

                            Rectangle {
                                id: rectImg
                                width: 60
                                height: 60
                                radius: width
                                ImageRounded {
                                    source: model.image
                                    r_width: parent.width
                                    r_height: parent.height
                                }
                            }

                            Rectangle {
                                width: parent.width - rectImg.width - 20
                                height: 60
                                color: "transparent"

                                ColumnLayout {
                                    spacing: 3
                                    Text {
                                        text: model.name
                                        font.bold: true
                                        color: settings.txt_color
                                    }
                                    Text {
                                        text: model.message
                                        color: settings.txt_color
                                        elide: Text.ElideRight
                                    }
                                    Text {
                                        text: model.time
                                        color: settings.txt_color
                                    }
                                }
                            }
                        }

                        MouseArea {
                            id: itemMouseArea
                            anchors.fill: parent
                            hoverEnabled: true

                            onClicked: {
                                listView.currentIndex = index
                                for (var i = 0; i < listView.count; i++) {
                                    listView.itemAtIndex(i).isSelected = false
                                }
                                isSelected = true
                            }

                            onEntered: isHovered = true
                            onExited: isHovered = false
                        }
                    }
                }
            }

            // Customized scroll bar
            ScrollBar.vertical: ScrollBar {
                id: customScrollBar
                width: 5
                height: parent.height
                policy: ScrollBar.AsNeeded

                anchors.right: parent.right
                anchors.margins: 5
            }
        }

        Component.onCompleted: {
            ChatServices.fetchData(
                        "https://2fd5986c-7c90-408a-8ea4-9a43f049c5c7.mock.pstmn.io/groups-ok",
                        function (response) {
                            if (response) {
                                var object = JSON.parse(response)
                                object.listGroup.forEach(function (data) {
                                    var fetchedTime = new Date(Date.parse(
                                                                   data.groupLastestMessageTime))
                                    var currentTime = new Date()
                                    var timeDifference = Math.floor(
                                                (currentTime - fetchedTime) / 1000)
                                    var timeString

                                    if (timeDifference < 60) {
                                        timeString = timeDifference + " seconds ago"
                                    } else if (timeDifference < 3600) {
                                        timeString = Math.floor(
                                                    timeDifference / 60) + " minutes ago"
                                    } else if (timeDifference < 86400) {
                                        timeString = Math.floor(
                                                    timeDifference / 3600) + " hours ago"
                                    } else {
                                        timeString = Math.floor(
                                                    timeDifference / 86400) + " days ago"
                                    }

                                    groupListModel.append({
                                                              "name": data.groupName,
                                                              "message": data.groupLastestMessage,
                                                              "time": timeString,
                                                              "image": data.groupAvatar
                                                          })
                                })
                                // Scroll to the bottom after adding new data
                                if (groupListModel.count > 0) {
                                    listViewSessionId.currentIndex = groupListModel.count - 1
                                    listViewSessionId.positionViewAtIndex(
                                                listViewSessionId.currentIndex,
                                                ListView.End) // Optionally set scroll position
                                }
                            } else {
                                console.log("Failed to fetch data")
                            }
                        })
        }
    }
}
