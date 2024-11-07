import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Universal
import QtQuick.Effects
import QtQuick.Dialogs
import "ChatServices.js" as ChatServices
import cookie.service 1.0
import network.service 1.0

// Chat Section
Rectangle {
    id: chatSection

    //property init
    property QtObject settings
    property QtObject drawer_settings
    signal chatSessionSelected(int groupId)
    property string user_id: cookieId.loadCookie("user_id")

    Layout.minimumWidth: 0
    Layout.fillHeight: true
    color: settings.bg_chatsession_color
    width: 300
    height: parent.height
    visible: parent.width > 800
    Connections {
        target: app_state
        function onSuccessSignal() {
            console.log("Reloading chat session")
            groupListModel.clear()
            chatSection.loadDataChatSession()
        }
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
            clip: true

            ListView {
                id: listViewSessionId
                width: parent.width
                anchors.fill: parent
                model: ListModel {
                    id: groupListModel
                }
                delegate: Item {
                    width: parent ? parent.width : 0
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

                            // avatar
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

                            //group content
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
                                            text: {
                                                var indexOfNewLine = model.latest_ms_content.indexOf(
                                                            "\n")
                                                if (indexOfNewLine > 0) {
                                                    return model.latest_ms_content.substr(
                                                                0,
                                                                indexOfNewLine)
                                                } else {
                                                    return model.latest_ms_content
                                                }
                                            }
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
    }
    // services register
    Cookie {
        id: cookieId
    }
    NetworkManager {
        id: networkManager
        onDataReceived: function (response) {
            //console.log("Response from API:", response)
            if (response) {
                var object = JSON.parse(response)
                object.list_gr.forEach(function (data) {
                    var timeResult = ChatServices.formatTimeDifference(
                                data.created_at, data.latest_ms_content,
                                data.latest_ms_time)

                    groupListModel.append({
                                              "group_id": data.group_id,
                                              "group_name": data.group_name,
                                              "group_id": data.group_id,
                                              "group_code": data.group_code,
                                              "expired_at": data.expired_at,
                                              "latest_ms_content": timeResult.latestMsContent,
                                              "latest_ms_time": timeResult.timeString
                                          })
                })
            } else {
                console.log("Failed to fetch data")
            }
        }
        onRequestError: console.log("Network error: " + error)
    }
    //fetch data
    Component.onCompleted: {
        loadDataChatSession()
    }

    //fn load data chat section
    function loadDataChatSession() {

        networkManager.fetchData(`http://127.0.0.1:8080/gr/list/${user_id}`,
                                 "GET")
    }
}
