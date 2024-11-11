import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Universal
import QtQuick.Effects
import QtQuick.Dialogs
import QtCore
import cookie.service 1.0

ApplicationWindow {
    id: rootId
    visible: true
    width: 1200
    height: 800
    title: "Chat Application"

    Cookie {
        id: cookieId
    }

    //properties init
    property QtObject sharedSettings: ThemeSettings {
        id: darkModeId
    }
    property string user_name: cookieId.loadCookie("user_name")

    //received groupId from signal in HomeScreen to pass for ChatContent
    property int groupId: 0

    property QtObject drawerRef: sidebar

    Connections {
        target: app_state
        function onSuccessSignal() {
            sidebar.close()
        }
    }

    // Chat menu
    Drawer {
        id: sidebar
        width: 300
        height: parent.height
        edge: Qt.LeftEdge
        background: Rectangle {
            color: sharedSettings.user_drawer
        }

        // User information
        Rectangle {
            width: parent.width
            height: 140
            color: "transparent"
            anchors.top: parent.top
            anchors.topMargin: 60
            ImageRounded {
                x: parent.width / 2 - r_width / 2
                source: "https://placehold.co/100x100"
                r_width: 100
                r_height: 100
            }

            Text {
                id: username
                text: rootId.user_name
                font.bold: true
                font.pixelSize: 20
                color: sharedSettings.txt_color
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        Rectangle {
            width: parent.width
            height: parent.height * 0.3
            color: "transparent"
            anchors.verticalCenter: parent.verticalCenter

            // Create new room button
            Rectangle {
                id: createNewRoom
                width: parent.width
                height: 50
                color: "transparent"
                anchors.top: parent.top

                AnimatedImage {
                    id: createRoomIcon
                    source: "qrc:/images/audio_11781833.gif"
                    height: 32
                    width: 32
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    paused: true
                }
                Rectangle {
                    height: parent.height
                    color: "transparent"
                    width: parent.width * 0.8
                    anchors.left: createRoomIcon.right
                    anchors.leftMargin: 10
                    Text {
                        id: txtCreateNewRoom
                        text: "Create Room"
                        color: sharedSettings.txt_color
                        font.pixelSize: 18
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        createNewRoom.color = sharedSettings.hover_color
                        txtCreateNewRoom.color = sharedSettings.txt_color
                        createRoomIcon.paused = false
                    }
                    onExited: {
                        createRoomIcon.paused = true
                        createNewRoom.color = "transparent"
                        txtCreateNewRoom.color = sharedSettings.txt_color
                    }
                    onClicked: {
                        createNewRoomId.open()
                    }
                }
            }

            // Join new room button
            Rectangle {
                id: joinNewRoomButton
                width: parent.width
                height: 50
                color: "transparent"

                anchors.top: createNewRoom.bottom

                AnimatedImage {
                    id: joinNewRoomIcon
                    source: "qrc:/images/comments_16903656.gif"
                    height: 32
                    width: 32
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    paused: true
                }

                Rectangle {
                    height: parent.height
                    color: "transparent"
                    width: parent.width * 0.8
                    anchors.left: joinNewRoomIcon.right
                    anchors.leftMargin: 10
                    Text {
                        id: txtJoinNewRoomBtn
                        text: "Join Room"
                        color: sharedSettings.txt_color
                        font.pixelSize: 18
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        joinNewRoomIcon.paused = false
                        joinNewRoomButton.color = sharedSettings.hover_color
                        txtJoinNewRoomBtn.color = sharedSettings.txt_color
                    }
                    onExited: {
                        joinNewRoomIcon.paused = true
                        joinNewRoomButton.color = "transparent"
                        txtJoinNewRoomBtn.color = sharedSettings.txt_color
                    }
                    onClicked: {
                        joinNewRoomId.open()
                    }
                }
            }

            //logout button
            Rectangle {
                id: logoutBtn
                width: parent.width
                height: 50
                color: "transparent"
                anchors.top: joinNewRoomButton.bottom

                AnimatedImage {
                    id: logoutIcon
                    source: "qrc:/images/logout.gif"
                    height: 32
                    width: 32
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    paused: true
                }
                Rectangle {
                    height: parent.height
                    color: "transparent"
                    width: parent.width * 0.8
                    anchors.left: logoutIcon.right
                    anchors.leftMargin: 10
                    Text {
                        id: txtLogout
                        text: "Logout"
                        color: sharedSettings.txt_color
                        font.pixelSize: 18
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        logoutIcon.paused = false
                        logoutBtn.color = sharedSettings.hover_color
                        txtLogout.color = sharedSettings.txt_color
                    }
                    onExited: {
                        logoutIcon.paused = true
                        logoutBtn.color = "transparent"
                        txtLogout.color = sharedSettings.txt_color
                    }
                    onClicked: {

                        // handle logout
                        cookieId.removeCookie()
                        Qt.quit()
                    }
                }
            }
        }

        // Switch button
        Rectangle {
            width: parent.width - 40
            height: 50
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            color: "transparent"
            Row {
                width: parent.width
                height: parent.height
                anchors.verticalCenter: parent.verticalCenter
                spacing: 10
                Switch {
                    id: mySwitch

                    anchors.verticalCenter: parent.verticalCenter
                    width: 50
                    height: 30
                    checked: sharedSettings.darkMode ? true : false
                    onToggled: sharedSettings.darkMode = !sharedSettings.darkMode
                }
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Dark Mode"
                    color: sharedSettings.txt_color
                }
            }
        }
    }

    // Main Chat
    Rectangle {
        width: parent.width
        height: parent.height
        color: sharedSettings.mainbg

        ColumnLayout {
            anchors.fill: parent
            width: parent.width
            height: parent.height

            RowLayout {
                width: parent.width
                height: parent.height

                // Chat Session
                ChatSession {
                    id: chatSession
                    settings: sharedSettings
                    drawer_settings: drawerRef
                }

                // Chat Content
                ChatContent {
                    id: chatContent
                    groupId: rootId.groupId
                    settings: {
                        sharedSettings
                    }
                }

                //drawer for join new room
                JoinNewRoom {
                    id: joinNewRoomId
                    settings: sharedSettings
                }

                //drawer for create new room
                CreateNewRoom {
                    id: createNewRoomId
                    settings: sharedSettings
                }
            }
        }
    }

    // Save setting
    Settings {
        category: "window"
        property alias x: rootId.x
        property alias y: rootId.y
        property alias width: rootId.width
        property alias height: rootId.height
    }

    // Save darkmode option
    Settings {
        id: themeSettingsSaver
        category: "theme"
        property alias darkMode: darkModeId.darkMode
    }
}
