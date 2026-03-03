import QtQuick
import QtQuick.Layouts

RowLayout{
    anchors.fill: parent
    spacing: 10

    ColumnLayout {
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.preferredWidth: 1

        RowLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 10

            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "black"

                Text{
                    text: "SM"
                    anchors.centerIn: parent
                    color: "white"
                    font.pixelSize: parent.height * 0.4
                    font.bold: true
                }
            }
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "black"

                Text{
                    text: "SW 45 45"
                    anchors.centerIn: parent
                    color: "white"
                    font.pixelSize: parent.height * 0.4
                    font.bold: true
                }
            }
        }

        RowLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 10

            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "black"

                Text{
                    text: "BMS[A]:10"
                    anchors.centerIn: parent
                    color: "white"
                    font.pixelSize: parent.height * 0.4
                    font.bold: true
                }
            }
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "black"

                Text{
                    text: "VCU[A]:10"
                    anchors.centerIn: parent
                    color: "white"
                    font.pixelSize: parent.height * 0.4
                    font.bold: true
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "black"

            Text{
                text: "APPS: 100 100"
                anchors.centerIn: parent
                color: "white"
                font.pixelSize: parent.height * 0.4
                font.bold: true
            }
        }
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "black"

            Text{
                text: "BPS: 100 100"
                anchors.centerIn: parent
                color: "white"
                font.pixelSize: parent.height * 0.4
                font.bold: true
            }
        }
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "black"

            Text{
                text: "---------"
                anchors.centerIn: parent
                color: "white"
                font.pixelSize: parent.height * 0.4
                font.bold: true
            }
        }
    }


    ColumnLayout{
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.preferredWidth: 1

        Rectangle{
            Layout.fillHeight: true
            Layout.fillWidth: true

            color: "black"
        }
        Rectangle{
            Layout.fillHeight: true
            Layout.fillWidth: true

            color: "black"
        }
        Rectangle{
            Layout.fillHeight: true
            Layout.fillWidth: true

            color: "black"
        }
        Rectangle{
            Layout.fillHeight: true
            Layout.fillWidth: true

            color: "black"
        }
        Rectangle{
            Layout.fillHeight: true
            Layout.fillWidth: true

            color: "black"
        }

    }

}
