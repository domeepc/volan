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
            id: frame

            anchors.centerIn: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: "black"
            text: qsTr("0")
            font.pointSize: 24

            Connections{
                target: canInterface


                function onProcess(frameId){
                    frame.text = frameId
                }
            }

        }
    }

}

