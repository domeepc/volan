import QtQuick
import QtQuick.Layouts

ColumnLayout{
    anchors.fill: parent
    spacing: 5
    RowLayout{
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.preferredHeight: 1

        spacing: 5
        Repeater {
            model: 17
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "black"

                Text {
                    text: index

                    color: "white"
                    font.pixelSize: parent.height * 0.5
                    font.bold: true
                }
            }
        }
    }
    RowLayout{
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.preferredHeight: 3
        Rectangle{
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: "black"
        }
    }
    RowLayout{
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.preferredHeight: 4
        Rectangle{
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: "black"
        }
    }
}
