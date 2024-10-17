import QtQuick
import QtQuick.Controls

Item {
    id: root
    property string m_source
    property int m_width: 20
    property int m_height: 20
    width: m_width
    height: m_height

    // Image {
    //     source: root.m_source
    //     width: root.m_width
    //     height: root.m_height
    // }
    AnimatedImage {
        // id: gifImage
        anchors.centerIn: parent
        source: root.m_source
        width: root.m_width
        height: root.m_height
        fillMode: Image.PreserveAspectFit
    }
}
