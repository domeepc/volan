import QtQuick
import QtQuick.Layouts
import volan

Window {
    id: window_ID
    width: 853
    height: 479

    visible: true

    Rectangle {
        width: parent.width
        height: parent.height
        color: "black"
    }

    Item {
        anchors.fill: parent
        Text {
            id: speed

            anchors.centerIn: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: "white"
            text: signalHandler.speed
            font.pointSize: 24



        }
    }

}

