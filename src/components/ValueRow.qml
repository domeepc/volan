import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root
    color: "black"

    property var values: []

    RowLayout {
        anchors.fill: parent
        spacing: 6

        Repeater {
            model: root.values

            Text {
                text: modelData
                color: "white"
                font.bold: true

                Layout.fillWidth: true

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                font.pixelSize: root.height * 0.55
            }
        }
    }
}
