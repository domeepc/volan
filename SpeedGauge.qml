import QtQuick
import QtQuick.Layouts


Rectangle {
    id: root
    property int speed: 0

    Layout.fillHeight: true
    Layout.fillWidth: true
    Layout.horizontalStretchFactor: 2
    Layout.topMargin: 20
    Layout.bottomMargin: 20

    radius: height / 2
    color: "black"
    border.width: 8
    border.color: "white"

    Text {
        text: root.speed
        anchors.centerIn: parent
        color: "white"
        font.bold: true
        fontSizeMode: Text.Fit
        minimumPixelSize: 20
        font.pixelSize: 200
    }
}
