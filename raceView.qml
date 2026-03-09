import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ColumnLayout {
    anchors.fill: parent
    spacing: 5

    //svjetla za upozorenja
    Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredHeight: 2
        color: "black"

        RowLayout {
            anchors.centerIn: parent
            spacing: 50

            Repeater {
                model: 5
                Rectangle {
                    width: 50
                    height: 50
                    color: "red"
                }
            }
        }
    }

    Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true

        Layout.preferredHeight: 7
        color: "black"

        RowLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 50

            BatteryBar{
                value: signalHandler.soc
                label: "SOC"
                Layout.horizontalStretchFactor: 1

            }


            SpeedGauge{
                speed: signalHandler.speed
            }


            BatteryBar{
                value: signalHandler.soc2    // example second battery
                label: "AUX"
                Layout.horizontalStretchFactor: 1
            }


        }
    }

    Rectangle {
        id: bottomBar
        Layout.fillWidth: true
        Layout.preferredHeight: 60
        color: "black"

        RowLayout {
            anchors.fill: parent
            //anchors.margins: 20
            anchors.leftMargin: 20
            anchors.rightMargin: 20

            Text {
                text: "MODE"
                color: "white"
                font.bold: true
                verticalAlignment: Text.AlignVCenter

                font.pixelSize: bottomBar.height * 0.6
            }

            Item {
                Layout.fillWidth: true
            }

            Text {
                text: "PRESET"
                color: "white"
                font.bold: true
                verticalAlignment: Text.AlignVCenter

                font.pixelSize: bottomBar.height * 0.6
            }
        }
    }
}
