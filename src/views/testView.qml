import QtQuick

Item {
    id: testView
    anchors.fill: parent
    Rectangle{
        width: parent.width
        height: parent.height
        color: "red"
    }

    Text {
        id: test1
        text: qsTr("TEST VIEW")
        font.pixelSize:  32
    }
}
