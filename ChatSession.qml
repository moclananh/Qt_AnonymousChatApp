import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Universal
import QtQuick.Effects
import QtQuick.Dialogs
import "ChatServices.js" as ChatServices
import cookie.service 1.0

// Chat Section
Rectangle {
    property QtObject settings
    property QtObject drawer_settings

    id: chatSection
    signal chatSessionSelected(int groupId)
    Layout.minimumWidth: 0
    Layout.fillHeight: true
    color: settings.bg_chatsession_color
    width: 300
    height: parent.height
    visible: parent.width > 800

    //Service
    Cookie {
        id: cookieId
    }

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
                        width: parent.width
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
                                    source: "https://placehold.co/50x50"
                                    r_width: parent.width
                                    r_height: parent.height
                                }
                            }

                            Rectangle {
                                id: rectMsg
                                width: parent.width - rectImg.width - 20
                                height: 60
                                color: "transparent"
                                ColumnLayout {
                                    Rectangle {
                                        width: rectMsg.width
                                        height: 15
                                        color: "transparent"
                                        Text {
                                            text: model.group_name
                                            font.bold: true
                                            color: settings.txt_color
                                            elide: Text.ElideRight
                                            width: parent.width
                                        }
                                    }
                                    Rectangle {
                                        width: rectMsg.width
                                        height: 15
                                        color: "transparent"
                                        Text {
                                            text: model.latest_ms_content
                                            color: settings.txt_color
                                            elide: Text.ElideRight
                                            width: parent.width
                                        }
                                    }
                                    Rectangle {
                                        color: "transparent"
                                        width: rectMsg.width
                                        height: 15
                                        Text {
                                            text: model.latest_ms_time
                                            color: settings.txt_color
                                        }
                                    }
                                }
                            }
                        }

                        MouseArea {
                            id: itemMouseArea
                            anchors.fill: parent
                            hoverEnabled: true

                            onClicked: {
                                listViewSessionId.currentIndex = index
                                for (var i = 0; i < listViewSessionId.count; i++) {
                                    listViewSessionId.itemAtIndex(
                                                i).isSelected = false
                                }
                                isSelected = true
                                chatSection.chatSessionSelected(model.group_id)
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
            var user_id = cookieId.loadCookie("user_id")
            ChatServices.fetchData(`http://127.0.0.1:8080/gr/list/${user_id}`,
                                   "GET", null, function (response) {
                                       if (response) {
                                           var object = JSON.parse(response)
                                           object.list_gr.forEach(
                                                       function (data) {
                                                           var fetchedTime
                                                           var timeString

                                                           if (data.latest_ms_content === "") {
                                                               data.latest_ms_content
                                                                       = "Group just created"
                                                               // Adjust for local time zone (GMT+7)
                                                               fetchedTime = new Date(new Date(data.created_at).getTime() + 7 * 60 * 60 * 1000)
                                                           } else {
                                                               data.latest_ms_content
                                                                       = data.latest_ms_content
                                                               // Adjust for local time zone (GMT+7)
                                                               fetchedTime = new Date(new Date(data.latest_ms_time).getTime() + 7 * 60 * 60 * 1000)
                                                           }

                                                           var currentTime = new Date()

                                                           var timeDifference = Math.floor(
                                                                       (currentTime - fetchedTime)
                                                                       / 1000)

                                                           // Calculate timeString based on the fetchedTime
                                                           if (timeDifference < 60) {
                                                               timeString = timeDifference
                                                                       + " seconds ago"
                                                           } else if (timeDifference < 3600) {
                                                               timeString = Math.floor(
                                                                           timeDifference / 60)
                                                                       + " minutes ago"
                                                           } else if (timeDifference < 86400) {
                                                               timeString = Math.floor(
                                                                           timeDifference / 3600)
                                                                       + " hours ago"
                                                           } else {
                                                               timeString = Math.floor(
                                                                           timeDifference / 86400)
                                                                       + " days ago"
                                                           }

                                                           groupListModel.append({
                                                                                     "group_id": data.group_id,
                                                                                     "group_name": data.group_name,
                                                                                     "group_id": data.group_id,
                                                                                     "group_code": data.group_code,
                                                                                     "expired_at": data.expired_at,
                                                                                     "latest_ms_content": data.latest_ms_content,
                                                                                     "latest_ms_time": timeString
                                                                                 })
                                                       })

                                           // Scroll to the bottom after adding new data
                                           if (groupListModel.count > 0) {
                                               listViewSessionId.currentIndex
                                                       = groupListModel.count - 1
                                               listViewSessionId.positionViewAtIndex(
                                                           listViewSessionId.currentIndex,
                                                           ListView.End)
                                           }
                                       } else {
                                           console.log("Failed to fetch data")
                                       }
                                   })
        }
    }
}
