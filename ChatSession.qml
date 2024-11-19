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
    property int num_joinedGroup: 0
    property int num_waitingGroup: 0
    property string user_id: cookieId.loadCookie("user_id")
    property string user_name: cookieId.loadCookie("user_name")
    signal chatSessionSelected(int groupId)

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
            groupListWaitingModel.clear()
            chatSection.loadDataChatSession()
        }

        function onMessageSignal() {
            console.log("Reloading chat session")
            groupListModel.clear()
            groupListWaitingModel.clear()
            chatSection.loadDataChatSession()
        }

        function onRemoveGroupSuccessSignal() {
            console.log("Reloading chat session")
            groupListModel.clear()
            groupListWaitingModel.clear()
            chatSection.loadDataChatSession()
        }

        function onLeaveGroupSuccessSignal() {
            groupListModel.clear()
            groupListWaitingModel.clear()
            chatSection.loadDataChatSession()
        }
    }

    ColumnLayout {
        anchors.fill: parent
        width: parent.width
        height: parent.height

        Rectangle {
            width: parent.width
            height: 80
            color: "transparent"

            // Search Header
            Rectangle {
                id: searchBtn
                width: parent.width
                height: 40
                color: "transparent"
                anchors.top: parent.top
                anchors.topMargin: 10

                Rectangle {
                    id: btnMenu
                    width: 40
                    height: 40
                    color: "transparent"
                    radius: 5
                    anchors.left: parent.left
                    anchors.leftMargin: 5

                    Image {
                        source: settings.darkMode ? "qrc:/images/mn2.png" : "qrc:/images/mn1.png"
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

            //  Breadcrumb switch list item
            Rectangle {
                id: breadScrumId
                width: parent.width
                height: 30
                color: "transparent"
                anchors.top: searchBtn.bottom

                //joined list
                Rectangle {
                    id: joinedRectBtn
                    width: parent.width * 0.5
                    height: 20
                    anchors.verticalCenter: parent.verticalCenter
                    color: "transparent"
                    anchors.left: breadScrumId.left

                    // Main text
                    Text {
                        id: txtJoinedGroup
                        text: "Joined Group (" + chatSection.num_joinedGroup + ")"
                        color: stackLayout.currentIndex
                               === 0 ? settings.highlight_text : settings.txt_color
                        font.bold: stackLayout.currentIndex === 0
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: joinedRectBtn.top
                    }

                    // Custom underline
                    Rectangle {
                        width: joinedRectBtn.width * 0.8
                        height: 2
                        color: stackLayout.currentIndex
                               === 0 ? settings.highlight_text : "transparent"
                        visible: stackLayout.currentIndex === 0
                        anchors.top: txtJoinedGroup.bottom
                        anchors.topMargin: 5
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            stackLayout.currentIndex = 0
                        }
                    }
                }

                //waiting list
                Rectangle {
                    id: waitingList
                    width: parent.width * 0.5
                    height: 20
                    anchors.verticalCenter: parent.verticalCenter
                    color: "transparent"
                    anchors.left: joinedRectBtn.right

                    // Main text
                    Text {
                        id: txtWaitingGroup
                        text: "Waiting Group (" + num_waitingGroup + ")"
                        color: stackLayout.currentIndex
                               === 1 ? settings.highlight_text : settings.txt_color
                        font.bold: stackLayout.currentIndex === 1
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                    }

                    // Custom underline
                    Rectangle {
                        width: waitingList.width * 0.8
                        height: 2
                        color: stackLayout.currentIndex
                               === 1 ? settings.highlight_text : "transparent"
                        visible: stackLayout.currentIndex === 1
                        anchors.top: txtWaitingGroup.bottom
                        anchors.topMargin: 5
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            stackLayout.currentIndex = 1
                        }
                    }
                }
            }
        }

        StackLayout {
            id: stackLayout
            Layout.fillWidth: true
            Layout.fillHeight: true

            // Scrollable group joined
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
                                        source: model.avatar
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
                                                        return model.latest_ms_username === "" ? model.latest_ms_content : model.latest_ms_username + ": " + model.latest_ms_content
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
                                                font.pixelSize: 11
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
                                    //chatSection.chatSessionSelected(model.group_id)
                                    app_state.chatSessionSelected(
                                                model.group_id)
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

            // Scrollable group waiting
            ScrollView {

                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true

                ListView {
                    id: listViewGroupWaitingId
                    width: parent.width
                    anchors.fill: parent
                    model: ListModel {
                        id: groupListWaitingModel
                    }
                    delegate: Item {
                        width: parent ? parent.width : 0
                        height: 70
                        property bool isSelected: false
                        property bool isHovered: false

                        Rectangle {
                            id: itemRectWaiting
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
                                    id: rectImgWaiting
                                    width: 60
                                    height: 60
                                    radius: width
                                    ImageRounded {
                                        source: model.avatar
                                        r_width: parent.width
                                        r_height: parent.height
                                    }
                                }

                                //group content
                                Rectangle {
                                    id: rectMsgWaiting
                                    width: parent.width - rectImgWaiting.width - 20
                                    height: 60
                                    color: "transparent"
                                    ColumnLayout {
                                        Rectangle {
                                            width: rectMsgWaiting.width
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
                                            color: "transparent"
                                            width: rectMsgWaiting.width
                                            height: 15
                                            Text {
                                                text: model.status
                                                color: settings.txt_color
                                            }
                                        }
                                        Rectangle {
                                            color: "transparent"
                                            width: rectMsgWaiting.width
                                            height: 15
                                            Text {
                                                text: "..."
                                                color: settings.txt_color
                                            }
                                        }
                                    }
                                }
                            }

                            MouseArea {
                                id: itemMouseAreaWaiting
                                anchors.fill: parent
                                hoverEnabled: true

                                onClicked: {
                                    listViewGroupWaitingId.currentIndex = index
                                    for (var i = 0; i < listViewGroupWaitingId.count; i++) {
                                        listViewGroupWaitingId.itemAtIndex(
                                                    i).isSelected = false
                                    }
                                    isSelected = true
                                    // app_state.chatSessionSelected(
                                    //             model.group_id)   // readonly
                                }

                                onEntered: isHovered = true
                                onExited: isHovered = false
                            }
                        }
                    }
                }

                // Customized scroll bar
                ScrollBar.vertical: ScrollBar {
                    id: customScrollBar2
                    width: 5
                    height: parent.height
                    policy: ScrollBar.AsNeeded

                    anchors.right: parent.right
                    anchors.margins: 5
                }
            }
        }
    }
    // services register
    Cookie {
        id: cookieId
    }

    //fetch data
    NetworkManager {
        id: networkManager
        onDataReceived: function (response) {
            //console.log("Response from API:", response)
            if (response) {
                var object = JSON.parse(response)

                num_joinedGroup = object.total_gr
                object.list_gr.forEach(function (data) {
                    var timeResult = ChatServices.formatTimeDifference(
                                data.created_at, data.latest_ms_content,
                                data.latest_ms_time)

                    groupListModel.append({
                                              "group_id": data.group_id,
                                              "avatar": "https://placehold.co/50X50?text=Group",
                                              "group_name": data.group_name,
                                              "group_code": data.group_code,
                                              "expired_at": data.expired_at,
                                              "created_at": data.created_at,
                                              "latest_ms_content": timeResult.latestMsContent,
                                              "latest_ms_time": timeResult.timeString,
                                              "latest_ms_username": data.latest_ms_username === user_name ? "You" : data.latest_ms_username
                                          })
                })

                num_waitingGroup = object.list_waiting_gr.length
                object.list_waiting_gr.forEach(function (data) {

                    groupListWaitingModel.append({
                                                     "group_id": data.group_id,
                                                     "avatar": "https://placehold.co/50X50?text=Group",
                                                     "group_name": data.group_name,
                                                     "status": "Waiting for approve"
                                                 })
                })
            } else {
                console.log("Failed to fetch data")
            }
        }
        onRequestError: function (error) {
            console.log("Error from API:", error)
        }
    }

    //fn load data chat section
    function loadDataChatSession() {

        networkManager.fetchData(`http://127.0.0.1:8080/gr/list/${user_id}`,
                                 "GET")
    }

    Component.onCompleted: {
        loadDataChatSession()
    }
}
