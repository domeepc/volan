import QtQuick
import volan123 1.0

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Text {
        id: _speed
        x: 220
        y: 180
        width: 201
        text:qsTr("100");
        height: 121
        font.pixelSize: 100
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.styleName: "Bold"
    }
}
