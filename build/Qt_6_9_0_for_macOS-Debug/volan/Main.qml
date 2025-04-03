import QtQuick
import volan


Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Back{
        id: backend
    }

    Text {
        id: _speed
        x: 220
        y: 180
        width: 201
        height: 121
        font.pixelSize: 100
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.styleName: "Bold"


        Connections{
            target: backend
            function onFrameReceived(msg){ _speed.text = msg}
        }
    }
}


