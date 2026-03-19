import QtQuick

Rectangle {
    id: root
    color: "black"
    property string title: ""

    Text {
        anchors.fill: parent
        text: root.title

        color: "white"
        font.bold: true
        font.pixelSize: parent.height * 0.45

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
