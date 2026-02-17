import QtQuick
import QtQuick.Layouts
import volan

Window {
    id: window_ID
    // width: Screen.width
    // height: Screen.height
    //visibility: Window.FullScreen
    visible: true
    title: qsTr("Volan prototype")
    //color: "#000000"

    Item {
        anchors.fill: parent
        Text {
            id: speed

            anchors.centerIn: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: "black"
            text: signalHandler.speed
            font.pointSize: 24



        }
    }

}

