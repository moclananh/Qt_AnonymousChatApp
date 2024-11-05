import QtQuick
import QtQuick.Effects

Item {
    id: roundedItem
    property string source
    property alias r_width: sourceItem.width
    property alias r_height: sourceItem.height
    Image {
        id: sourceItem
        source: roundedItem.source
        visible: false
    }

    MultiEffect {
        source: sourceItem
        anchors.fill: sourceItem
        maskEnabled: true
        maskSource: mask
    }

    Item {
        id: mask
        width: sourceItem.width
        height: sourceItem.height
        layer.enabled: true
        visible: false
        Rectangle {
            width: sourceItem.width
            height: sourceItem.height
            radius: width / 2
            color: "black"
        }
    }
}
