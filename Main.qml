import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Universal
import QtQuick.Effects
import QtQuick.Dialogs
import QtCore

ApplicationWindow {
    id: rootId
    visible: true
    width: 1200
    height: 800
    title: "Chat Application"

    property QtObject sharedSettings: ThemeSettings {
        id: darkModeId
    }

    // Material.theme: Material.Light
    Drawer {
        id: sidebar
        width: 300
        height: parent.height
        edge: Qt.LeftEdge
        modal: false
        background: Rectangle {
            color: sharedSettings.user_drawer
        }

        Column {
            anchors.fill: parent
            anchors.topMargin: 50

            // User avatar
            Rectangle {
                width: parent.width
                height: 150
                color: "transparent"

                ImageRounded {
                    x: parent.width / 2 - r_width / 2
                    source: "https://placehold.co/100x100"
                    r_width: 100
                    r_height: 100
                }
            }

            // Chat Button
            Rectangle {
                id: chatButton
                width: parent.width
                height: 50
                color: "transparent" // Same as the parent by default

                radius: 10
                Row {
                    anchors.fill: parent
                    spacing: 10
                    Rectangle {
                        width: 20
                        color: "transparent"
                        height: parent.height
                    }

                    MyIcon {
                        m_source: "qrc:/images/audio_11781833.gif"
                        m_height: 32
                        m_width: 32
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Rectangle {
                        height: parent.height
                        color: "transparent"
                        width: parent.width * 0.8
                        Text {
                            id: txtChatColor
                            text: "Chat"
                            color: sharedSettings.txt_color
                            font.pixelSize: 18
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        chatButton.color = sharedSettings.hover_color
                        txtChatColor.color = sharedSettings.txt_color
                    }
                    onExited: {

                        chatButton.color = "transparent"
                        txtChatColor.color = sharedSettings.txt_color
                    }
                    onClicked: {

                        // Handle click
                    }
                }
            }

            // Another Button
            Rectangle {
                id: anotherButton
                width: parent.width
                height: 50
                color: "transparent" // Same as the parent by default
                radius: 10

                Row {
                    anchors.fill: parent
                    spacing: 10
                    Rectangle {
                        width: 20
                        color: "transparent"
                        height: parent.height
                    }

                    MyIcon {
                        m_source: "qrc:/images/comments_16903656.gif"
                        m_height: 32
                        m_width: 32
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Rectangle {
                        height: parent.height
                        color: "transparent"
                        width: parent.width * 0.8
                        Text {
                            id: txtAnotherBtn
                            text: "Another button"
                            color: sharedSettings.txt_color
                            font.pixelSize: 18
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        anotherButton.color = sharedSettings.hover_color
                        txtAnotherBtn.color = sharedSettings.txt_color
                    }
                    onExited: {

                        anotherButton.color = "transparent"
                        txtAnotherBtn.color = sharedSettings.txt_color
                    }
                    onClicked: {

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
                    settings: sharedSettings
                }

                // ChatContent
                ChatContent {
                    settings: sharedSettings
                }
            }
        }
    }

    // Settings saved
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
