import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Universal
import QtQuick.Effects
import QtQuick.Dialogs
import "ChatServices.js" as ChatServices

// Chat Section
Rectangle {
    property QtObject settings
    property QtObject drawer_settings
    id: chatSection
    // Layout.preferredWidth: 300
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
                        //handle here
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
                y: 10
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

        ListView {
            id: listView
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            model: ListModel {
                id: groupListModel
            }
            delegate: Item {
                width: parent.width
                height: 70

                // Add selected state tracking
                property bool isSelected: false
                property bool isHovered: false // Track hover state

                Rectangle {
                    id: itemRect
                    width: parent.width - 20
                    height: 70
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: isSelected ? settings.choose_color : (isHovered ? settings.hover_color : "transparent") // Change color when selected or hovered
                    border.color: "transparent"

                    RowLayout {
                        spacing: 10
                        anchors.fill: parent
                        anchors.margins: 5

                        //group session avatar
                        Rectangle {
                            id: rectImg
                            width: 60
                            height: 60
                            radius: width
                            ImageRounded {
                                // x: parent.width / 2 - r_width / 2
                                source: model.image
                                r_width: parent.width
                                r_height: parent.height
                            }
                        }

                        //group session content
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

                    // MouseArea for handling clicks and hover
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

                        onEntered: {
                            isHovered = true
                        }

                        onExited: {
                            isHovered = false
                        }
                    }
                }
            }
        }
        Component.onCompleted: {
            ChatServices.fetchData(
                        "https://2fd5986c-7c90-408a-8ea4-9a43f049c5c7.mock.pstmn.io/groups-ok",
                        function (response) {
                            if (response) {
                                var object = JSON.parse(response)

                                object.listGroup.forEach(function (data) {
                                    // Ensure the fetched time is correctly interpreted as UTC
                                    var fetchedTime = new Date(Date.parse(
                                                                   data.groupLastestMessageTime))
                                    var currentTime = new Date()
                                    // Get the current local time

                                    // Calculate time difference in seconds
                                    var timeDifference = Math.floor(
                                                (currentTime - fetchedTime) / 1000)

                                    // Format the time difference
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

                                    // Append data to the model
                                    groupListModel.append({
                                                              "name": data.groupName,
                                                              "message": data.groupLastestMessage,
                                                              "time": timeString,
                                                              "image"// Use formatted time
                                                              : data.groupAvatar
                                                          })
                                })
                            } else {
                                console.log("Failed to fetch data")
                            }
                        })
        }
    }
}
