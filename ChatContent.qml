import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Universal
import QtQuick.Effects
import QtQuick.Dialogs
import "ChatServices.js" as ChatServices
import cookie.service 1.0

// Chat Content
Rectangle {

    property int c_user_id: cookieId.loadCookie("user_id")
    property int groupId: 0
    property int maximum_mem: 0
    property int gr_owner_id: 0
    property QtObject settings

    id: chatContent
    Layout.fillWidth: true
    Layout.fillHeight: true
    color: settings.bg_chatcontent_color
    function loadGroupDataLayout() {
        chatContentLayout.loadGroupData()
    }

    Cookie {
        id: cookieId
    }

    //radius: 20
    Column {
        id: chatContentLayout
        anchors.fill: parent
        width: parent.width
        height: parent.height
        spacing: 0
        // Chat Header
        Rectangle {
            id: chatContentHeader
            width: parent.width - 20
            anchors.horizontalCenter: parent.horizontalCenter
            height: 60
            color: "transparent"
            Layout.alignment: Qt.AlignTop
            Layout.fillWidth: true

            RowLayout {
                spacing: 15
                anchors.verticalCenter: parent.verticalCenter

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
                        text: "Group Name"
                        font.pixelSize: 20
                        font.bold: true
                        color: settings.txt_color
                        verticalAlignment: Text.AlignVCenter
                    }
                    Text {
                        id: chatDuration
                        text: "Duration"
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
                                text: "Group Name"
                                font.pixelSize: 16
                                font.bold: true
                                horizontalAlignment: Text.AlignHCenter
                                color: settings.txt_color
                            }
                        }
                    }

                    // button option
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
                            //btn notice
                            Rectangle {
                                width: 40
                                height: 40
                                color: hovered ? settings.hover_color : "transparent"
                                property bool hovered: false
                                radius: 5
                                //  anchors.verticalCenter: parent.verticalCenter
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
                                    hoverEnabled: true // Enable hover detection
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
                                    hoverEnabled: true // Enable hover detection
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
                                    hoverEnabled: true // Enable hover detection
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
                                            text: "Member (5/" + maximum_mem + ")"
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
                                            text: "Request (5)"
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

                    // RemoveGroupConfirm
                    MessageDialog {
                        id: removeGroupConfirm
                        title: "Notice"
                        text: "Are you sure to remove this group?"
                        buttons: MessageDialog.Ok | MessageDialog.Cancel

                        onAccepted: function () {
                            var url = "http://localhost:8080/del-gr"
                            var method = "POST"
                            var data = {
                                "gr_id": groupId,
                                "u_id": gr_owner_id
                            }

                            ChatServices.fetchData(url, method, null,
                                                   function (responseText) {
                                                       if (responseText) {
                                                           var response = JSON.parse(
                                                                       responseText)
                                                           if (response.code === 0) {
                                                               console.log("Group Deleted")
                                                           } else {
                                                               console.log("Failed to delete group")
                                                           }
                                                       } else {
                                                           console.log("Failed to delete group due to an error.")
                                                       }
                                                   }, data)
                        }

                        onRejected: function () {
                            console.log("Cancelled")
                        }
                    }

                    // Drawer for member management
                    CustomDrawer {
                        id: drawerManageMember
                        control_handle: false
                        lableText: "Member (5/" + maximum_mem + ")"
                        d_settings: settings
                    }

                    // Drawer for member request
                    CustomDrawer {
                        id: drawerMemberRequest
                        control_handle: true
                        lableText: "Request (5)"
                        d_settings: settings
                    }

                    // LeaveGroupConfirm
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

            width: parent.width
            height: parent.height - messRectId.height - chatContentHeader.height - 10
            clip: true

            ListView {
                id: lsViewId
                width: parent.width
                height: parent.height
                //spacing: 10
                clip: true
                model: ListModel {
                    id: chatContentModel
                }
                delegate: Rectangle {
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

                        layoutDirection: model.user_id === c_user_id ? "RightToLeft" : "LeftToRight"

                        // Avatar
                        Rectangle {
                            width: 35
                            height: username.height + rectMessage.height
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
                        Column {
                            id: msgContent
                            height: username.height + rectMessage.height
                            // Username
                            Rectangle {
                                id: username
                                width: rectMessage.width
                                height: 20
                                color: "transparent"
                                visible: model.user_id === c_user_id ? false : true
                                //anchors.bottom: rectMessage.top
                                Text {
                                    text: model.sender
                                    color: settings.txt_color
                                    anchors.left: parent.left
                                    anchors.leftMargin: 5
                                }
                            }

                            // Message Box
                            Rectangle {
                                id: rectMessage
                                width: Math.min(messageId.implicitWidth + 40,
                                                500)
                                height: messageId.implicitHeight + 20
                                radius: 20
                                color: model.user_id === c_user_id ? settings.messsagebox_chat_sender : settings.messsagebox_chat_receiver

                                Text {
                                    id: messageId
                                    text: model.message
                                    color: model.user_id
                                           === c_user_id ? "white" : settings.message_txt_sender
                                    anchors.centerIn: rectMessage
                                    wrapMode: Text.WordWrap
                                    width: parent.width - 40
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

        //File attached display
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

                    // anchors.right: parent.right
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
                            onExited: btnBackgroundOpenFile.color
                                      = "transparent" // Revert to default when not hovered
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
                        color: "transparent" // Default background color
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
                            onExited: btnBackground.color
                                      = "transparent" // Revert to default when not hovered
                        }
                    }

                    onClicked: {

                        // messageTextArena.text = ""
                        // txtId.text = ""
                        // txtId.visible = false
                        // lsViewId.height += txtId.height
                        if (messageTextArena.text.trim().length > 0) {
                            // Prepare the data to be sent
                            var requestData = {
                                "user_id": c_user_id,
                                "group_id": chatContent.groupId,
                                "content": messageTextArena.text,
                                "message_type": "string"
                            }

                            var handler = function (response) {
                                if (response) {
                                    let resObject = JSON.parse(response)
                                    console.log("Send message sucess!",
                                                resObject)
                                    messageTextArena.text = ""
                                } else {
                                    console.log("Failed to send message")
                                }
                            }

                            ChatServices.fetchData(
                                        "http://localhost:8080/send-msg",
                                        "POST", null, handler, requestData)
                        }
                    }
                }
            }
        }

        //fetch api
        Component.onCompleted: {
            loadGroupData()
        }
        function loadGroupData() {
            ChatServices.fetchData(
                        `http://localhost:8080/group-detail/${chatContent.groupId}`,
                        "GET", null, function (response) {
                            if (response) {
                                var data = JSON.parse(response)
                                chatGroupName.text = data.group_name
                                groupNameInSetting.text = data.group_name
                                maximum_mem = data.max_member
                                gr_owner_id = data.user_id
                                chatDuration.text = ChatServices.calculateDuration(
                                            data.expired_at)

                                // Populate message list
                                lsViewId.model.clear()
                                for (var i = 0; i < data.messages.length; i++) {
                                    lsViewId.model.append({
                                                              "ms_id": data.messages[i].id,
                                                              "sender": data.messages[i].user_name,
                                                              "message": data.messages[i].content,
                                                              "time": data.messages[i].created_at,
                                                              "image": "https://placehold.co/50x50",
                                                              "message_type": data.messages[i].message_type,
                                                              "user_id": data.messages[i].user_id
                                                          })
                                }
                                // Scroll to the bottom after adding new data
                                if (chatContentModel.count > 0) {
                                    lsViewId.currentIndex = chatContentModel.count - 1
                                    lsViewId.positionViewAtIndex(
                                                lsViewId.currentIndex,
                                                ListView.End)
                                }
                            } else {
                                console.error(
                                            "Failed to fetch data from the API")
                            }
                        })
        }
    }
}
