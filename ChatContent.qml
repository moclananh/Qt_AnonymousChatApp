import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Universal
import QtQuick.Effects
import QtQuick.Dialogs
import "ChatServices.js" as ChatServices
import cookie.service 1.0
import network.service 1.0

// Chat Content
Rectangle {
    id: chatContent

    //property init
    property int c_user_id: cookieId.loadCookie("user_id")
    property int groupId: 0
    property int maximum_mem: 0
    property int gr_owner_id: 0
    property int total_waiting_member: 0
    property int total_joined_member: 0
    property QtObject settings

    Layout.fillWidth: true
    Layout.fillHeight: true
    color: settings.bg_chatcontent_color

    // signal connect to get groupId
    function loadGroupDataLayout() {
        chatContentLayout.loadGroupData()
    }

    Connections {
        target: app_state
        function onGroupIdSignal(groupId) {
            console.log("Reloading chat details")
            chatContent.groupId = groupId
            chatContentLayout.loadGroupData()
        }
    }
    //containner
    Column {
        id: chatContentLayout
        anchors.fill: parent
        width: parent.width
        height: parent.height

        // Chat Header
        Rectangle {
            id: chatContentHeader
            width: parent.width - 20
            anchors.horizontalCenter: parent.horizontalCenter
            height: 60
            color: "transparent"
            Layout.alignment: Qt.AlignTop
            Layout.fillWidth: true
            visible: chatContent.groupId !== 0 ? true : false
            RowLayout {
                spacing: 15
                anchors.verticalCenter: parent.verticalCenter

                //Group Avatar
                Rectangle {
                    width: 50
                    height: 50
                    radius: 25
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
                        id: chatGroupName
                        text: ""
                        font.pixelSize: 20
                        font.bold: true
                        color: settings.txt_color
                        verticalAlignment: Text.AlignVCenter
                    }
                    Text {
                        id: chatDuration
                        text: ""
                        font.pixelSize: 10
                        opacity: 0.8
                        color: settings.txt_color
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }

            // Button group setting
            Button {
                id: btnGroupSetting
                width: 40
                height: 40
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                background: Rectangle {
                    id: btnBackgroundGroupSetting
                    color: "transparent" // Default background color
                    anchors.fill: parent

                    radius: 5
                    Image {
                        source: settings.darkMode ? "qrc:/images/sequence2.png" : "qrc:/images/sequence.png"
                        width: 30
                        height: 30
                        smooth: true
                        anchors.centerIn: parent
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true

                        onEntered: btnBackgroundGroupSetting.color = settings.hover_color
                        onExited: btnBackgroundGroupSetting.color = "transparent"
                    }
                }

                onClicked: {
                    chatContentLayout.loadGroupSetting()
                    drawerGroupSetting.open()
                }
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
                color: settings.drawer_color
                radius: 5
            }

            Rectangle {
                width: parent.width
                height: parent.height
                color: "transparent"
                border.color: settings.border_color
                border.width: 1

                Column {
                    width: parent.width

                    //chat detail header
                    Rectangle {
                        width: parent.width
                        height: 150
                        color: "transparent"
                        border.color: settings.border_color

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
                                id: groupNameInSetting
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: ""
                                font.pixelSize: 16
                                font.bold: true
                                horizontalAlignment: Text.AlignHCenter
                                color: settings.txt_color
                            }
                        }
                    }

                    //btn option
                    Rectangle {
                        width: parent.width
                        height: 50
                        color: "transparent"
                        border.color: settings.border_color
                        border.width: 1
                        anchors.horizontalCenter: parent.horizontalCenter
                        Row {
                            spacing: 30
                            anchors.centerIn: parent

                            //btn notify
                            Rectangle {
                                width: 40
                                height: 40
                                color: hovered ? settings.hover_color : "transparent"
                                property bool hovered: false
                                radius: 5
                                Image {
                                    anchors.centerIn: parent
                                    source: settings.darkMode ? "qrc:/images/notify2.png" : "qrc:/images/notice.png"
                                    width: 24
                                    height: 24
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    hoverEnabled: true // Enable hover detection
                                    onEntered: parent.hovered = true
                                    onExited: parent.hovered = false
                                }
                            }

                            //btn pin
                            Rectangle {
                                width: 40
                                height: 40
                                color: hovered ? settings.hover_color : "transparent"
                                property bool hovered: false
                                radius: 5
                                anchors.verticalCenter: parent.verticalCenter
                                Image {
                                    anchors.centerIn: parent
                                    source: settings.darkMode ? "qrc:/images/pin2.png" : "qrc:/images/pin.png"
                                    width: 24
                                    height: 24
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onEntered: parent.hovered = true
                                    onExited: parent.hovered = false
                                }
                            }

                            //btn search
                            Rectangle {
                                width: 40
                                height: 40
                                color: hovered ? settings.hover_color : "transparent"
                                property bool hovered: false
                                radius: 5
                                anchors.verticalCenter: parent.verticalCenter
                                Image {
                                    anchors.centerIn: parent
                                    source: settings.darkMode ? "qrc:/images/search2.png" : "qrc:/images/search.png"
                                    width: 24
                                    height: 24
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onEntered: parent.hovered = true
                                    onExited: parent.hovered = false
                                }
                            }

                            //btn setting
                            Rectangle {
                                width: 40
                                height: 40
                                color: hovered ? settings.hover_color : "transparent"
                                property bool hovered: false
                                radius: 5
                                anchors.verticalCenter: parent.verticalCenter
                                Image {
                                    anchors.centerIn: parent
                                    source: settings.darkMode ? "qrc:/images/setting2.png" : "qrc:/images/setting.png"
                                    width: 24
                                    height: 24
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onEntered: parent.hovered = true
                                    onExited: parent.hovered = false
                                }
                            }
                        }
                    }

                    //member list
                    Rectangle {
                        id: rectMemberList
                        width: parent.width
                        border.color: settings.border_color
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
                                    color: settings.txt_color
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
                                color: hovered ? settings.hover_color : "transparent"

                                MouseArea {
                                    id: mouseArea
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onEntered: parent.hovered = true
                                    onExited: parent.hovered = false
                                    onClicked: {
                                        drawerManageMember.open()
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
                                        source: settings.darkMode ? "qrc:/images/friend2.png" : "qrc:/images/friend_4309056.png"
                                        width: 20
                                        height: 20
                                    }

                                    Rectangle {
                                        color: "transparent"
                                        width: rectMemberList.width - 60
                                        height: parent.height

                                        Text {
                                            anchors.verticalCenter: parent.verticalCenter
                                            text: "Member (" + total_joined_member
                                                  + "/" + maximum_mem + ")"
                                            color: settings.txt_color
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
                        border.color: settings.border_color
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
                                    color: settings.txt_color
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
                                color: hovered ? settings.hover_color : "transparent"

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
                                        source: settings.darkMode ? "qrc:/images/add2.png" : "qrc:/images/addmem.png"
                                        width: 20
                                        height: 20
                                    }

                                    Rectangle {
                                        color: "transparent"
                                        width: rectMemberRequest.width - 60
                                        height: parent.height

                                        Text {
                                            anchors.verticalCenter: parent.verticalCenter
                                            text: "Request (" + total_waiting_member + ")"
                                            color: settings.txt_color
                                        }
                                    }
                                }
                            }
                        }
                    }

                    // Group option
                    Rectangle {
                        id: rectOutGroup
                        width: parent.width
                        border.color: settings.border_color
                        height: rectGroupOpLable.height + rectLeaveGroup.height
                        color: "transparent"
                        anchors.horizontalCenter: parent.horizontalCenter

                        Rectangle {
                            id: rectGroupOpLable
                            width: parent.width
                            height: 35
                            color: "transparent"
                            Text {
                                anchors.left: parent.left
                                anchors.top: parent.top
                                anchors.leftMargin: 10
                                anchors.topMargin: 10
                                text: "Group Option"
                                font.pixelSize: 12
                                color: settings.txt_color
                                font.bold: true

                                Layout.fillWidth: true
                            }
                        }

                        Rectangle {
                            id: rectLeaveGroup
                            width: parent.width
                            height: 35

                            color: hovered ? settings.hover_color : "transparent"
                            anchors.top: rectGroupOpLable.bottom
                            MouseArea {

                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered: parent.hovered = true
                                onExited: parent.hovered = false
                                onClicked: {

                                    leaveGroupConfirm.open()
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
                                    source: settings.darkMode ? "qrc:/images/exit2.png" : "qrc:/images/exit.png"
                                    width: 20
                                    height: 20
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

                    // Owner option
                    Rectangle {
                        id: rectOwnerOption
                        width: parent.width
                        border.color: settings.border_color
                        height: rectOwnerOpLable.height + rectRemoveGroup.height
                        color: "transparent"
                        anchors.horizontalCenter: parent.horizontalCenter
                        visible: gr_owner_id === c_user_id ? true : false
                        Rectangle {
                            id: rectOwnerOpLable
                            width: parent.width
                            height: 35
                            color: "transparent"
                            Text {
                                anchors.left: parent.left
                                anchors.top: parent.top
                                anchors.leftMargin: 10
                                anchors.topMargin: 10
                                text: "Owner Option"
                                font.pixelSize: 12
                                color: settings.txt_color
                                font.bold: true

                                Layout.fillWidth: true
                            }
                        }

                        Rectangle {
                            id: rectRemoveGroup
                            width: parent.width
                            height: 35
                            color: hovered ? settings.hover_color : "transparent"
                            anchors.top: rectOwnerOpLable.bottom
                            MouseArea {

                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered: parent.hovered = true
                                onExited: parent.hovered = false
                                onClicked: {

                                    removeGroupConfirm.open()
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
                                    source: settings.darkMode ? "qrc:/images/exit2.png" : "qrc:/images/exit.png"
                                    width: 20
                                    height: 20
                                }

                                Rectangle {
                                    color: "transparent"
                                    width: rectOwnerOption.width - 60
                                    height: parent.height

                                    Text {
                                        anchors.verticalCenter: parent.verticalCenter
                                        text: "Remove Group"
                                        color: "red"
                                    }
                                }
                            }
                        }
                    }

                    // Remove group confirm dialog
                    MessageDialog {
                        id: removeGroupConfirm
                        title: "Notice"
                        text: "Are you sure to remove this group?"
                        buttons: MessageDialog.Ok | MessageDialog.Cancel

                        onAccepted: function () {

                            chatContentLayout.removeGroup()
                            console.log("remove clicked!")
                        }

                        onRejected: function () {
                            console.log("Cancelled")
                        }
                    }

                    // Drawer for member management
                    CustomDrawer {
                        id: drawerManageMember
                        control_handle: false
                        lableText: "Member (" + total_joined_member + "/" + maximum_mem + ")"
                        d_settings: settings
                        membersModel: ListModel {}
                    }

                    // Drawer for member request
                    CustomDrawer {
                        id: drawerMemberRequest
                        control_handle: true
                        lableText: "Request (" + total_waiting_member + ")"
                        d_settings: settings
                        membersModel: ListModel {}
                    }

                    // Leave group confirm dialog
                    MessageDialog {
                        id: leaveGroupConfirm
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
        ScrollView {
            id: scrollViewMessage
            width: parent.width
            height: parent.height - messRectId.height - chatContentHeader.height - 10
            clip: true

            ListView {
                id: lsViewId
                width: parent.width
                height: parent.height
                clip: true

                model: ListModel {
                    id: chatContentModel
                }

                delegate: Rectangle {
                    color: settings.chat_theme
                    width: parent ? parent.width : 0
                    height: positionId.height
                    Rectangle {

                        color: "transparent"
                        width: parent ? parent.width - 30 : 0

                        Component.onCompleted: {
                            if (parent)
                                anchors.horizontalCenter = parent.horizontalCenter
                        }

                        height: positionId.height

                        Row {
                            id: positionId
                            spacing: 10
                            Component.onCompleted: {
                                if (model.user_id === c_user_id) {
                                    positionId.anchors.right = parent.right
                                }
                            }
                            height: Math.max(avatarContent.height,
                                             msgContent.height) + 20

                            layoutDirection: model.user_id
                                             === c_user_id ? "RightToLeft" : "LeftToRight"

                            // Avatar
                            Rectangle {
                                width: 35
                                height: rectMessage.height
                                color: "transparent"
                                visible: model.user_id === c_user_id ? false : true
                                Rectangle {
                                    id: avatarContent
                                    width: 35
                                    height: 35
                                    radius: 1
                                    color: "transparent"
                                    border.color: "transparent"
                                    visible: model.user_id === c_user_id ? false : true
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 2
                                    ImageRounded {
                                        x: parent.width / 2 - r_width / 2
                                        source: model.image
                                        r_width: parent.width
                                        r_height: parent.height
                                    }
                                }
                            }

                            // Message contents
                            Column {
                                id: msgContent
                                height: rectMessage.height

                                // Message Box
                                Rectangle {
                                    id: rectMessage
                                    width: usernameId.implicitWidth >= messageId.implicitWidth ? Math.min(usernameId.implicitWidth + 20, 500) : Math.min(messageId.implicitWidth + 20, 500)
                                    height: messageId.implicitHeight + messageTimeId.implicitHeight
                                            + 20 + ((usernameId.visible
                                                     === false) ? 0 : usernameId.implicitHeight)
                                    radius: 10
                                    color: model.user_id === c_user_id ? settings.messsagebox_chat_sender : settings.messsagebox_chat_receiver

                                    // Username
                                    Text {
                                        id: usernameId
                                        text: model.sender
                                        color: "#be0cc7"
                                        font.bold: true
                                        anchors.top: parent.top
                                        anchors.topMargin: 5
                                        anchors.left: parent.left
                                        anchors.leftMargin: 10
                                        visible: model.user_id === c_user_id ? false : true
                                    }

                                    // message content
                                    Text {
                                        id: messageId
                                        text: model.message
                                        color: model.user_id
                                               === c_user_id ? "white" : settings.message_txt_sender
                                        anchors.top: usernameId.visible
                                                     === true ? usernameId.bottom : parent.top
                                        anchors.topMargin: usernameId.visible === true ? 3 : 5
                                        anchors.left: parent.left
                                        anchors.leftMargin: 10
                                        wrapMode: Text.WordWrap
                                        width: parent.width - 20
                                    }

                                    // message created date
                                    Text {
                                        id: messageTimeId
                                        text: model.created_at
                                        color: model.user_id
                                               === c_user_id ? "white" : settings.message_txt_sender
                                        anchors.top: messageId.bottom
                                        anchors.topMargin: 5
                                        anchors.right: parent.right
                                        anchors.rightMargin: 10
                                        font.pixelSize: 10
                                    }
                                }
                            }
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

        // File attached display
        Text {
            id: txtId
            width: parent.width
            height: 20
            visible: false
            color: settings.txt_color
            text: "User haven't choose any file"
            wrapMode: Text.Wrap
        }

        // Message Input
        Rectangle {
            id: messRectId
            height: sendMessageId.height
            property int line_height: 30
            color: "transparent"
            width: parent.width
            Layout.fillWidth: true
            visible: chatContent.groupId !== 0 ? true : false
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
                    width: messRectId.width - btnOpenFile.width - btnSend.width - 10
                    height: messageTextArena.height
                    ScrollView {
                        id: scrollText
                        width: parent.width
                        TextArea {
                            id: messageTextArena
                            textMargin: 0
                            background: Rectangle {
                                width: parent.width
                                height: parent.height
                                color: settings.message_input
                                radius: 15
                                border.color: settings.border_color
                                border.width: 1
                            }
                            color: settings.txt_color

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

                                    messageTextArena.height = messageTextArena.intial_size
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

                    anchors.verticalCenter: parent.verticalCenter
                    background: Rectangle {
                        id: btnBackgroundOpenFile
                        color: "transparent"
                        anchors.fill: parent
                        anchors.centerIn: parent
                        radius: 5
                        Image {

                            source: settings.darkMode ? "qrc:/images/attach_file_2.png" : "qrc:/images/attach_file.png"
                            width: 35
                            height: 35
                            anchors.centerIn: parent
                        }

                        MouseArea {

                            anchors.fill: parent
                            hoverEnabled: true

                            onEntered: btnBackgroundOpenFile.color = settings.hover_color
                            onExited: btnBackgroundOpenFile.color = "transparent"
                        }
                    }

                    onClicked: function () {
                        fileDialogId.open()
                    }

                    FileDialog {
                        id: fileDialogId
                        title: "Choose file"
                        nameFilters: ["Text files (*.txt)", "HTML Files (*.html *.htm)", "Image files (*.jpg *.png)"]
                        fileMode: FileDialog.OpenFile
                        onAccepted: function () {
                            txtId.text = currentFile
                            if (!txtId.visible) {
                                txtId.visible = true
                                lsViewId.height -= txtId.height
                            }
                        }

                        onRejected: function () {
                            if (txtId.visible) {
                                txtId.visible = false
                                lsViewId.height += txtId.height
                            }
                        }
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
                        color: "transparent"
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

                            onEntered: btnBackground.color = settings.hover_color
                            onExited: btnBackground.color = "transparent"
                        }
                    }

                    onClicked: {

                        if (messageTextArena.text.trim().length > 0) {
                            chatContentLayout.sendMessage()
                        } else {
                            messageTextArena.focus = true
                            messageTextArena.placeholderText = "Message required!"
                        }
                    }
                }
            }
        }

        //services register
        Cookie {
            id: cookieId
        }

        CustomNotify {
            id: notifyMessageBoxId
            message: ""
        }

        //fetch data for group details
        NetworkManager {
            id: networkManagerGroupDetails
            onDataReceived: function (response) {
                // console.log("Response from API:", response)
                if (response) {
                    var data = JSON.parse(response)
                    chatGroupName.text = data.group_name
                    chatDuration.text = ChatServices.calculateDuration(
                                data.expired_at)
                    gr_owner_id = data.user_id
                    lsViewId.model.clear()
                    for (var i = 0; i < data.messages.length; i++) {
                        var formattedTime = ChatServices.formatTime(
                                    data.messages[i].created_at)

                        lsViewId.model.append({
                                                  "ms_id": data.messages[i].id,
                                                  "sender": data.messages[i].user_name,
                                                  "message": data.messages[i].content,
                                                  "time": data.messages[i].created_at,
                                                  "image": "https://placehold.co/50x50",
                                                  "message_type": data.messages[i].message_type,
                                                  "user_id": data.messages[i].user_id,
                                                  "created_at": formattedTime
                                              })
                    }

                    // Scroll to the bottom after adding new data
                    if (chatContentModel.count > 0) {
                        lsViewId.currentIndex = chatContentModel.count - 1
                        lsViewId.positionViewAtIndex(lsViewId.currentIndex,
                                                     ListView.End)
                    }
                } else {
                    console.error("Failed to fetch data from the API")
                }
            }
            onRequestError: function (error) {
                console.log("Error from API:", error)
            }
        }

        //fetch data for group settings
        NetworkManager {
            id: networkManagerGroupSettings
            onDataReceived: function (response) {
                // console.log("Response from API:", response)
                if (response) {
                    var respObject = JSON.parse(response)
                    var groupSettingRes = respObject.data
                    groupNameInSetting.text = groupSettingRes.group_name
                    maximum_mem = groupSettingRes.maximum_members
                    total_joined_member = groupSettingRes.total_joined_member
                    total_waiting_member = groupSettingRes.total_waiting_member

                    drawerMemberRequest.membersModel.clear()
                    for (var i = 0; i < groupSettingRes.list_waiting_member.length; i++) {
                        drawerMemberRequest.membersModel.append({
                                                                    "username": groupSettingRes.list_waiting_member[i].username,
                                                                    "image": "https://placehold.co/50x50"
                                                                })
                    }

                    drawerManageMember.membersModel.clear()
                    for (var j = 0; j < groupSettingRes.list_joined_member.length; j++) {
                        drawerManageMember.membersModel.append({
                                                                   "username": groupSettingRes.list_joined_member[j].username,
                                                                   "image": "https://placehold.co/50x50"
                                                               })
                    }
                } else {
                    console.error("Failed to fetch data from the API")
                }
            }
            onRequestError: function (error) {
                console.log("Error from API:", error)

                var errorParts = error.split(": ")
                var statusCode = parseInt(errorParts[0], 10)
                var responseBody = errorParts.slice(1).join(": ")

                if (statusCode === 400) {
                    notifyMessageBoxId.message = responseBody
                    notifyMessageBoxId.open()
                } else {
                    notifyMessageBoxId.message = "Error from server"
                    notifyMessageBoxId.open()
                }
            }
        }

        //fetch data for remove group
        NetworkManager {
            id: networkManagerRemoveGroup
            onDataReceived: function (response) {

                var dataRes = JSON.parse(response)
                if (dataRes.code === 0) {
                    drawerGroupSetting.close()
                    console.log("Group Deleted: " + dataRes.data.gr_id)
                    notifyMessageBoxId.message = "Group deleted successfully!"
                    notifyMessageBoxId.open()
                } else {
                    console.log("Failed to delete group")
                }
            }

            onRequestError: function (error) {
                console.log("Error from API:", error)

                var errorParts = error.split(": ")
                var statusCode = parseInt(errorParts[0], 10)
                var responseBody = errorParts.slice(1).join(": ")

                if (statusCode === 400) {
                    notifyMessageBoxId.message = responseBody
                    notifyMessageBoxId.open()
                } else {
                    notifyMessageBoxId.message = "Error from server"
                    notifyMessageBoxId.open()
                }
            }
        }

        //fetch data for send message
        NetworkManager {
            id: networkManagerSendMessage
            onDataReceived: function (response) {
                if (response) {
                    let resObject = JSON.parse(response)
                    console.log("Send message sucess!", resObject.data.content)
                    messageTextArena.text = ""
                } else {
                    console.log("Failed to send message")
                }
            }

            onRequestError: function (error) {
                console.log("Error from API:", error)

                var errorParts = error.split(": ")
                var statusCode = parseInt(errorParts[0], 10)
                var responseBody = errorParts.slice(1).join(": ")

                if (statusCode === 400) {
                    notifyMessageBoxId.message = responseBody
                    notifyMessageBoxId.open()
                } else {
                    notifyMessageBoxId.message = "Error from server"
                    notifyMessageBoxId.open()
                }
            }
        }

        // fn load group details
        function loadGroupData() {
            networkManagerGroupDetails.fetchData(
                        `http://localhost:8080/group-detail/${chatContent.groupId}`,
                        "GET")
        }

        //fn load group settings
        function loadGroupSetting() {
            networkManagerGroupSettings.fetchData(
                        `http://localhost:8080/group-detail/setting/${chatContent.groupId}`,
                        "GET")
        }

        //fn remove group
        function removeGroup() {
            var headers = {}
            var requestData = {
                "gr_id": groupId,
                "u_id": gr_owner_id
            }
            var jsonData = JSON.stringify(requestData)
            networkManagerRemoveGroup.fetchData('http://localhost:8080/del-gr',
                                                "POST", headers, jsonData)
        }

        //fn send message
        function sendMessage() {
            var headers = {}
            var requestData = {
                "user_id": c_user_id,
                "group_id": chatContent.groupId,
                "content": messageTextArena.text,
                "message_type": "string"
            }
            var jsonData = JSON.stringify(requestData)

            networkManagerSendMessage.fetchData(
                        `http://localhost:8080/send-msg`, "POST",
                        headers, jsonData)
        }

        Component.onCompleted: {
            loadGroupData()
        }
    }
}
