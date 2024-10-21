import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Universal
import QtQuick.Effects
import QtQuick.Dialogs

ApplicationWindow {
    visible: true
    width: 1200
    height: 800
    title: "Chat Application"

    // Material.theme: Material.Light
    Drawer {
        id: sidebar
        width: 300
        height: parent.height
        edge: Qt.LeftEdge
        modal: false
        background: Rectangle {
            color: "#271932"
        }

        Column {
            anchors.fill: parent
            anchors.topMargin: 50

            // User avatar
            Rectangle {
                width: parent.width
                height: 150
                color: "#271932"

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
                color: "#271932" // Same as the parent by default

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
                            color: "white"
                            font.pixelSize: 22
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        chatButton.color = "white"
                        txtChatColor.color = "#271932"
                    }
                    onExited: {

                        chatButton.color = "#271932"
                        txtChatColor.color = "white"
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
                color: "#271932" // Same as the parent by default
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
                            color: "white"
                            font.pixelSize: 22
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        anotherButton.color = "white"
                        txtAnotherBtn.color = "#271932"
                    }
                    onExited: {

                        anotherButton.color = "#271932"
                        txtAnotherBtn.color = "white"
                    }
                    onClicked: {

                        // Handle click
                    }
                }
            }
        }
    }

    // Main Chat
    Rectangle {
        width: parent.width
        height: parent.height
        color: "#f5f7fb"

        ColumnLayout {
            anchors.fill: parent
            width: parent.width
            height: parent.height

            RowLayout {
                // Layout.fillWidth: true
                // Layout.fillHeight: true
                width: parent.width
                height: parent.height

                // Chat Section
                Rectangle {
                    id: chatSection
                    // Layout.preferredWidth: 300
                    Layout.minimumWidth: 0
                    Layout.fillHeight: true
                    color: "white"
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

                            // Search field
                            TextField {
                                id: chatField
                                width: parent.width - 20
                                anchors.horizontalCenter: parent.horizontalCenter
                                y: 10
                                height: 30

                                placeholderText: "Search..."
                                background: TextArea {
                                    color: "#f5f5f5"
                                }
                            }
                        }

                        ListView {
                            id: listView
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            clip: true
                            model: ListModel {
                                ListElement {
                                    name: "Group Chat 01"
                                    message: "Who are these three?"
                                    time: "6h"
                                    image: "https://placehold.co/50x50"
                                }
                                ListElement {
                                    name: "Group Chat 02"
                                    message: "Who are these three?"
                                    time: "6h"
                                    image: "https://placehold.co/50x50"
                                }
                                ListElement {
                                    name: "Group Chat 03"
                                    message: "Who are these three?"
                                    time: "6h"
                                    image: "https://placehold.co/50x50"
                                }
                                // Add more items as necessary...
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
                                    color: isSelected ? "#f8e8ff" : (isHovered ? "#e5e7eb" : "transparent") // Change color when selected or hovered
                                    border.color: "transparent"

                                    RowLayout {
                                        spacing: 5
                                        anchors.fill: parent
                                        anchors.margins: 5

                                        Rectangle {
                                            width: 61
                                            height: 61
                                            radius: width

                                            ImageRounded {
                                                x: parent.width / 2 - r_width / 2
                                                source: model.image
                                                r_width: 60
                                                r_height: 60
                                            }
                                        }

                                        ColumnLayout {
                                            spacing: 5

                                            Text {
                                                text: model.name
                                                font.bold: true
                                            }

                                            Text {
                                                text: model.message
                                                color: "#6b7280"
                                                elide: Text.ElideRight
                                            }

                                            Text {
                                                text: model.time
                                                color: "#9ca3af"
                                            }
                                        }
                                    }

                                    // MouseArea for handling clicks and hover
                                    MouseArea {
                                        id: itemMouseArea
                                        anchors.fill: parent
                                        hoverEnabled: true

                                        onClicked: {
                                            listView.currentIndex
                                                    = index // Set the current index on click
                                            for (var i = 0; i < listView.count; i++) {
                                                listView.itemAtIndex(
                                                            i).isSelected
                                                        = false // Reset all selections
                                            }
                                            isSelected = true // Set clicked item as selected
                                        }

                                        onEntered: {
                                            isHovered = true // Set hovered state
                                        }

                                        onExited: {
                                            isHovered = false // Remove hovered state
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                // Chat Content
                Rectangle {
                    id: chatContent
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    color: "transparent"

                    //radius: 20
                    Column {
                        anchors.fill: parent
                        width: parent.width
                        height: parent.height
                        spacing: 0
                        // Chat Header
                        Rectangle {
                            id: chatContentHeader
                            width: parent.width
                            height: 60
                            color: "white"
                            Layout.alignment: Qt.AlignTop
                            Layout.fillWidth: true

                            RowLayout {
                                spacing: 15
                                anchors.verticalCenter: parent.verticalCenter

                                Rectangle {
                                    width: 50
                                    height: 50
                                    radius: 25
                                    color: "transparent"
                                    border.color: "transparent"

                                    ImageRounded {
                                        x: parent.width / 2 - r_width / 2
                                        source: "https://placehold.co/50x50"
                                        r_width: 50
                                        r_height: 50
                                    }
                                }

                                //Group name and memmer
                                Column {

                                    Text {
                                        text: "Group Chat 01"
                                        font.pixelSize: 20
                                        font.bold: true
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                    Text {
                                        text: "Members: 30"
                                        font.pixelSize: 10
                                        opacity: 0.8
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                }
                            }

                            // Button group setting
                            Button {
                                id: btnGroupSetting
                                width: 50
                                height: 50
                                anchors.right: parent.right
                                background: Rectangle {
                                    id: btnBackgroundGroupSetting
                                    color: "white" // Default background color
                                    anchors.fill: parent
                                    radius: 5
                                    Image {
                                        source: "qrc:/images/menu_op.png"
                                        width: 30
                                        height: 30
                                        smooth: true
                                        anchors.centerIn: parent
                                    }

                                    MouseArea {
                                        anchors.fill: parent
                                        hoverEnabled: true

                                        onEntered: btnBackgroundGroupSetting.color
                                                   = "#d4b8e9" // Change to blue when hovered
                                        onExited: btnBackgroundGroupSetting.color
                                                  = "white" // Revert to default when not hovered
                                    }
                                }

                                onClicked: drawerGroupSetting.open()
                            }
                        }

                        //Drawer Group Setting
                        Drawer {
                            id: drawerGroupSetting
                            width: 350
                            height: parent.height
                            edge: Qt.RightEdge
                            background: Rectangle {
                                anchors.fill: parent
                                color: "#f1f5f9"
                                radius: 5
                            }

                            Rectangle {
                                width: parent.width
                                height: parent.height
                                color: "transparent"

                                Column {
                                    width: parent.width
                                    padding: 20

                                    //chat detail header
                                    Rectangle {
                                        width: parent.width
                                        height: 100
                                        color: "transparent"
                                        border.color: "#e0e0e0"

                                        anchors.horizontalCenter: parent.horizontalCenter
                                        Column {
                                            anchors.centerIn: parent
                                            spacing: 10

                                            Image {
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                source: "https://placehold.co/50x50"
                                                width: 50
                                                height: 50
                                                fillMode: Image.PreserveAspectFit
                                            }

                                            Text {
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                text: "Group Chat 01"
                                                font.pixelSize: 16
                                                font.bold: true
                                                color: "#333333"
                                                horizontalAlignment: Text.AlignHCenter
                                            }
                                        }
                                    }

                                    // button option
                                    Rectangle {
                                        width: parent.width
                                        height: 50
                                        color: "transparent"
                                        border.color: "#e0e0e0"
                                        border.width: 1
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        Row {

                                            spacing: 10
                                            anchors.horizontalCenter: parent.horizontalCenter

                                            Rectangle {
                                                width: 50
                                                height: 50
                                                color: "transparent"

                                                Image {
                                                    anchors.centerIn: parent
                                                    source: "https://placehold.co/50x50"
                                                    width: 24
                                                    height: 24
                                                }
                                            }
                                            Rectangle {
                                                width: 50
                                                height: 50
                                                color: "transparent"

                                                Image {
                                                    anchors.centerIn: parent
                                                    source: "https://placehold.co/50x50"
                                                    width: 24
                                                    height: 24
                                                }
                                            }
                                            Rectangle {
                                                width: 50
                                                height: 50
                                                color: "transparent"

                                                Image {
                                                    anchors.centerIn: parent
                                                    source: "https://placehold.co/50x50"
                                                    width: 24
                                                    height: 24
                                                }
                                            }
                                            Rectangle {
                                                width: 50
                                                height: 50
                                                color: "transparent"

                                                Image {
                                                    anchors.centerIn: parent
                                                    source: "https://placehold.co/50x50"
                                                    width: 24
                                                    height: 24
                                                }
                                            }
                                        }
                                    }

                                    //member list
                                    Rectangle {
                                        id: rectMemberList
                                        width: parent.width
                                        border.color: "#e0e0e0"
                                        height: children[0].height + children.length * 15
                                        color: "transparent"
                                        anchors.horizontalCenter: parent.horizontalCenter

                                        Column {
                                            width: parent.width
                                            height: children[0].height + children[1].height
                                            spacing: 15

                                            //member lable
                                            Rectangle {
                                                width: parent.width
                                                height: 20
                                                color: "transparent"
                                                Text {
                                                    anchors.left: parent.left
                                                    anchors.top: parent.top
                                                    anchors.leftMargin: 10
                                                    anchors.topMargin: 10
                                                    text: "Group Members"
                                                    font.pixelSize: 12
                                                    color: "#333333"
                                                    font.bold: true

                                                    Layout.fillWidth: true
                                                }
                                            }

                                            //member management
                                            Rectangle {
                                                width: parent.width
                                                height: 35
                                                border.color: "transparent"
                                                border.width: 1
                                                color: hovered ? "#e5e7eb" : "transparent"

                                                MouseArea {
                                                    id: mouseArea
                                                    anchors.fill: parent
                                                    hoverEnabled: true
                                                    onEntered: parent.hovered = true
                                                    onExited: parent.hovered = false
                                                    onClicked: {
                                                        drawerManageMember.open(
                                                                    )
                                                    }
                                                }

                                                property bool hovered: false

                                                Row {
                                                    width: parent.width
                                                    height: parent.height
                                                    anchors.fill: parent

                                                    spacing: 5
                                                    anchors.leftMargin: 10

                                                    Image {
                                                        anchors.verticalCenter: parent.verticalCenter
                                                        source: "qrc:/images/friend_4309056.png"
                                                        width: 15
                                                        height: 15
                                                    }

                                                    Rectangle {
                                                        color: "transparent"
                                                        width: rectMemberList.width - 60
                                                        height: parent.height

                                                        Text {
                                                            anchors.verticalCenter: parent.verticalCenter
                                                            text: "30 members"
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }

                                    //member request
                                    Rectangle {
                                        id: rectMemberRequest
                                        width: parent.width
                                        border.color: "#e0e0e0"
                                        height: children[0].height + children.length * 15
                                        color: "transparent"
                                        anchors.horizontalCenter: parent.horizontalCenter

                                        Column {
                                            width: parent.width
                                            height: children[0].height + children[1].height
                                            spacing: 15

                                            //member lable
                                            Rectangle {
                                                width: parent.width
                                                height: 20
                                                color: "transparent"
                                                Text {
                                                    anchors.left: parent.left
                                                    anchors.top: parent.top
                                                    anchors.leftMargin: 10
                                                    anchors.topMargin: 10
                                                    text: "Group Request"
                                                    font.pixelSize: 12
                                                    color: "#333333"
                                                    font.bold: true

                                                    Layout.fillWidth: true
                                                }
                                            }

                                            //member management
                                            Rectangle {
                                                width: parent.width
                                                height: 35
                                                border.color: "transparent"
                                                border.width: 1
                                                color: hovered ? "#e5e7eb" : "transparent"

                                                MouseArea {

                                                    anchors.fill: parent
                                                    hoverEnabled: true
                                                    onEntered: parent.hovered = true
                                                    onExited: parent.hovered = false
                                                    onClicked: {
                                                        drawerMemberRequest.open()
                                                    }
                                                }

                                                property bool hovered: false

                                                Row {
                                                    width: parent.width
                                                    height: parent.height
                                                    anchors.fill: parent

                                                    spacing: 5
                                                    anchors.leftMargin: 10

                                                    Image {
                                                        anchors.verticalCenter: parent.verticalCenter
                                                        source: "qrc:/images/friend_4309056.png"
                                                        width: 15
                                                        height: 15
                                                    }

                                                    Rectangle {
                                                        color: "transparent"
                                                        width: rectMemberRequest.width - 60
                                                        height: parent.height

                                                        Text {
                                                            anchors.verticalCenter: parent.verticalCenter
                                                            text: "Request (5)"
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }

                                    //Out group
                                    Rectangle {
                                        id: rectOutGroup
                                        width: parent.width
                                        border.color: "#e0e0e0"
                                        height: children[0].height + children.length * 15
                                        color: "transparent"
                                        anchors.horizontalCenter: parent.horizontalCenter

                                        Column {
                                            width: parent.width
                                            height: children[0].height + children[1].height
                                            spacing: 15

                                            //member lable
                                            Rectangle {
                                                width: parent.width
                                                height: 20
                                                color: "transparent"
                                                Text {
                                                    anchors.left: parent.left
                                                    anchors.top: parent.top
                                                    anchors.leftMargin: 10
                                                    anchors.topMargin: 10
                                                    text: "Group Option"
                                                    font.pixelSize: 12
                                                    color: "#333333"
                                                    font.bold: true

                                                    Layout.fillWidth: true
                                                }
                                            }

                                            //member management
                                            Rectangle {
                                                width: parent.width
                                                height: 35
                                                border.color: "transparent"
                                                border.width: 1
                                                color: hovered ? "#e5e7eb" : "transparent"

                                                MouseArea {

                                                    anchors.fill: parent
                                                    hoverEnabled: true
                                                    onEntered: parent.hovered = true
                                                    onExited: parent.hovered = false
                                                    onClicked: {

                                                        messageDialogId.open()
                                                    }
                                                }

                                                property bool hovered: false

                                                Row {
                                                    width: parent.width
                                                    height: parent.height
                                                    anchors.fill: parent

                                                    spacing: 5
                                                    anchors.leftMargin: 10

                                                    Image {
                                                        anchors.verticalCenter: parent.verticalCenter
                                                        source: "qrc:/images/friend_4309056.png"
                                                        width: 15
                                                        height: 15
                                                    }

                                                    Rectangle {
                                                        color: "transparent"
                                                        width: rectOutGroup.width - 60
                                                        height: parent.height

                                                        Text {
                                                            anchors.verticalCenter: parent.verticalCenter
                                                            text: "Leave Group"
                                                            color: "red"
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }

                                    // Drawer for member management
                                    CustomDrawer {
                                        id: drawerManageMember
                                        control_handle: ""
                                        lableText: "Member (30)"
                                    }

                                    // Drawer for member request
                                    CustomDrawer {
                                        id: drawerMemberRequest
                                        control_handle: "accept"
                                        lableText: "Request (5)"
                                    }

                                    //Message dialog
                                    MessageDialog {
                                        id: messageDialogId
                                        title: "Notice"
                                        text: "Are you sure to leave this group?"
                                        buttons: MessageDialog.Ok | MessageDialog.Cancel

                                        onAccepted: function () {
                                            console.log("Accepted")
                                        }

                                        onRejected: function () {
                                            console.log("Rejected")
                                        }
                                    }
                                }
                            }
                        }

                        // Messages List
                        ListView {
                            // Layout.fillWidth: true
                            // Layout.fillHeight: true
                            width: parent.width
                            height: parent.height - messRectId.height
                                    - chatContentHeader.height - 10

                            //spacing: 10
                            clip: true
                            model: ListModel {
                                ListElement {
                                    sender: "Janice"
                                    message: "Similar to the West Lake and Thousand Island Lake"
                                    time: "9:31am"
                                    image: "https://placehold.co/50x50"
                                }
                                ListElement {
                                    sender: "User"
                                    message: "What is that?"
                                    time: "9:31am"
                                    image: "https://placehold.co/50x50"
                                }
                                ListElement {
                                    sender: "Janice"
                                    message: "I want to see some other ways to explain the scenic spots."
                                    time: "9:31am"
                                    image: "https://placehold.co/50x50"
                                }
                                ListElement {
                                    sender: "User"
                                    message: "I do not know!"
                                    time: "9:31am"
                                    image: "https://placehold.co/50x50"
                                }
                                ListElement {
                                    sender: "User"
                                    message: "I don't use this kind of class very much."
                                    time: "9:31am"
                                    image: "https://placehold.co/50x50"
                                }
                                ListElement {
                                    sender: "Janice"
                                    message: "Who are these three?"
                                    time: "9:31am"
                                    image: "https://placehold.co/50x50"
                                }
                            }
                            delegate: Rectangle {
                                color: "transparent"
                                width: parent.width - 20
                                anchors.horizontalCenter: parent.horizontalCenter
                                height: 70

                                Row {
                                    spacing: 10
                                    id: positionId
                                    Component.onCompleted: {
                                        if (model.sender === "User") {
                                            positionId.anchors.right = parent.right
                                        }
                                    }

                                    layoutDirection: model.sender
                                                     === "User" ? "RightToLeft" : "LeftToRight"
                                    // Avatar
                                    Rectangle {
                                        width: 45
                                        height: 45
                                        radius: width
                                        color: "transparent"
                                        border.color: "transparent"
                                        anchors.verticalCenter: parent.verticalCenter

                                        ImageRounded {
                                            x: parent.width / 2 - r_width / 2
                                            source: model.image
                                            r_width: 45
                                            r_height: 45
                                        }
                                    }

                                    // Message Box
                                    Rectangle {
                                        width: messageId.width + 50
                                        height: 35
                                        radius: 20
                                        color: model.sender === "User" ? "#9b4ad5" : "#e5e7eb"
                                        anchors.verticalCenter: parent.verticalCenter

                                        Text {
                                            id: messageId
                                            text: model.message
                                            color: model.sender === "User" ? "white" : "#4d226b"
                                            anchors.centerIn: parent
                                            wrapMode: Text.WordWrap
                                        }
                                    }
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {

                                        // Handle click
                                    }
                                }
                            }
                        }

                        // Enter new message
                        Rectangle {
                            id: messRectId
                            height: sendMessageId.height
                            property int line_height: 30
                            color: "white"
                            width: parent.width
                            Layout.fillWidth: true

                            Row {
                                id: sendMessageId
                                height: editMessageContainer.height
                                spacing: 4
                                Component.onCompleted: {
                                    sendMessageId.anchors.right = parent.right
                                }
                                Rectangle {
                                    id: editMessageContainer
                                    color: "transparent"
                                    width: messRectId.width - btnOpenFile.width - btnSend.width
                                           - 10 // Adjusted for better fit with button
                                    height: messageTextArena.height
                                    ScrollView {
                                        id: scrollText
                                        width: parent.width
                                        // anchors.fill: parent
                                        TextArea {
                                            id: messageTextArena
                                            textMargin: 0
                                            width: parent.width
                                            height: font.pixelSize + padding * 2
                                            placeholderText: "Type a message..."
                                            font.pixelSize: 14
                                            wrapMode: "WrapAtWordBoundaryOrAnywhere"
                                            property int intial_size: font.pixelSize + padding * 2
                                            onTextChanged: {

                                                var content = text

                                                if (content.length === 0
                                                        || content.length === undefined) {

                                                    messageTextArena.height
                                                            = messageTextArena.intial_size
                                                    scrollText.height = messageTextArena.height
                                                    messRectId.height = messageTextArena.height
                                                    sendMessageId.height = messageTextArena.height
                                                    return
                                                }
                                                var count = 1
                                                for (var i = 0; i < content.length; i++) {
                                                    if (content[i] === "\n") {
                                                        count++
                                                    }
                                                }

                                                var new_height = count * 19 + 12 + 5
                                                if (count > 5) {
                                                    messageTextArena.height = 5 * 19 + 12 + 5
                                                    scrollText.height = messageTextArena.height
                                                    messRectId.height = messageTextArena.height
                                                    sendMessageId.height = messageTextArena.height
                                                    return
                                                } else {

                                                    messageTextArena.height = new_height
                                                    scrollText.height = messageTextArena.height
                                                    messRectId.height = messageTextArena.height
                                                    sendMessageId.height = messageTextArena.height
                                                }
                                            }
                                        }
                                    }
                                }

                                //open file
                                Button {
                                    id: btnOpenFile
                                    width: 40
                                    height: 40

                                    // anchors.right: parent.right
                                    anchors.verticalCenter: parent.verticalCenter
                                    background: Rectangle {
                                        id: btnBackgroundOpenFile
                                        color: "#f1f5f9" // Default background color
                                        anchors.fill: parent
                                        anchors.centerIn: parent
                                        radius: 5
                                        Image {

                                            source: "qrc:/images/attach_file.png"
                                            width: 35
                                            height: 35
                                            anchors.centerIn: parent
                                        }

                                        MouseArea {

                                            anchors.fill: parent
                                            hoverEnabled: true

                                            onEntered: btnBackgroundOpenFile.color
                                                       = "#d4b8e9" // Change to blue when hovered
                                            onExited: btnBackgroundOpenFile.color = "#f1f5f9" // Revert to default when not hovered
                                        }
                                    }

                                    onClicked: {

                                        // handle send click
                                    }
                                }

                                //btn send
                                Button {
                                    id: btnSend
                                    width: 40
                                    height: 40
                                    anchors.verticalCenter: parent.verticalCenter
                                    background: Rectangle {
                                        id: btnBackground
                                        color: "#f1f5f9" // Default background color
                                        anchors.fill: parent
                                        radius: 5
                                        Image {
                                            id: sendIcon
                                            source: "qrc:/images/send_9068805.png"
                                            width: 30
                                            height: 30
                                            anchors.centerIn: parent
                                        }

                                        MouseArea {
                                            id: hoverArea
                                            anchors.fill: parent
                                            hoverEnabled: true

                                            onEntered: btnBackground.color
                                                       = "#d4b8e9" // Change to blue when hovered
                                            onExited: btnBackground.color = "#f1f5f9" // Revert to default when not hovered
                                        }
                                    }

                                    onClicked: {

                                        // handle send click
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
