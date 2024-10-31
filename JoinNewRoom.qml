import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Universal

Drawer {

    property QtObject settings
    width: 300
    height: parent.height
    edge: Qt.LeftEdge
    //  modal: false
    background: Rectangle {
        color: settings.user_drawer
    }

    Rectangle {
        id: rectJoinNewRoom
        width: parent.width * 0.85
        height: parent.height * 0.5
        color: "transparent"
        anchors.centerIn: parent

        Column {
            id: containter
            spacing: 10

            Text {
                text: "Join New Room"
                font.bold: true
                font.pixelSize: 30
                color: settings.txt_color
            }

            //room code
            Text {
                text: "Room Code"
                color: settings.txt_color
            }
            TextField {
                id: txtNewRoomCode
                placeholderText: "Enter room code..."
                color: "#232323"
                width: rectJoinNewRoom.width
                height: 40
            }

            //room code
            Text {
                text: "Message"
                color: settings.txt_color
            }
            TextField {
                id: txtNewMessage
                placeholderText: "Enter a message..."
                color: "#232323"
                width: rectJoinNewRoom.width
                height: 40
            }
        }

        //btn join room
        MyButton {
            id: btnJoinNewRoom
            height: 40
            width: 100
            text: "Join"
            anchors.top: containter.bottom
            anchors.topMargin: 20
            MouseArea {
                anchors.fill: btnJoinNewRoom

                onClicked: {
                    // Validation logic
                    if (txtNewRoomCode.text.trim() === "") {
                        txtNewRoomCode.focus = true
                        txtNewRoomCode.placeholderText = "Room code is required!"
                    } else {

                        console.log("Checking....")
                        // handle success here
                    }
                }
            }
        }
    }
}
