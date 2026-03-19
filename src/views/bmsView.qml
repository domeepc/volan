import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

RowLayout {
    anchors.fill: parent
    spacing: 6
    // VOLTAGE COLUMN
    ColumnLayout {
        Layout.fillWidth: true
        Layout.preferredWidth: 2
        spacing: 6

        TitleTile {
            title: "VOLTAGE[V]"
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        Repeater {
            model: [
                [signalHandler?.voltageMin[0].toFixed(1), signalHandler?.voltageMax[0].toFixed(1)],
                [signalHandler?.voltageMin[1].toFixed(1), signalHandler?.voltageMax[1].toFixed(1)],
                [signalHandler?.voltageMin[2].toFixed(1), signalHandler?.voltageMax[2].toFixed(1)],
                [signalHandler?.voltageMin[3].toFixed(1), signalHandler?.voltageMax[3].toFixed(1)],
                [signalHandler?.voltageMin[4].toFixed(1), signalHandler?.voltageMax[4].toFixed(1)]
            ]
            ValueRow {
                Layout.fillWidth: true
                Layout.fillHeight: true
                values: modelData
            }
        }
    }
    // TEMPERATURE COLUMN
    ColumnLayout {
        Layout.fillWidth: true
        Layout.preferredWidth: 3
        spacing: 6

        TitleTile {
            title: "TEMPERATURE[°C]"
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        Repeater {
            model: [
                [signalHandler?.temperatureMin[0].toFixed(1), signalHandler?.temperatureAvg[0].toFixed(1), signalHandler?.temperatureMax[0].toFixed(1)],
                [signalHandler?.temperatureMin[1].toFixed(1), signalHandler?.temperatureAvg[1].toFixed(1), signalHandler?.temperatureMax[1].toFixed(1)],
                [signalHandler?.temperatureMin[2].toFixed(1), signalHandler?.temperatureAvg[2].toFixed(1), signalHandler?.temperatureMax[2].toFixed(1)],
                [signalHandler?.temperatureMin[3].toFixed(1), signalHandler?.temperatureAvg[3].toFixed(1), signalHandler?.temperatureMax[3].toFixed(1)],
                [signalHandler?.temperatureMin[4].toFixed(1), signalHandler?.temperatureAvg[4].toFixed(1), signalHandler?.temperatureMax[4].toFixed(1)]
            ]
            ValueRow {
                Layout.fillWidth: true
                Layout.fillHeight: true
                values: modelData
            }
        }
    }

    ColumnLayout {
        Layout.fillWidth: true
        Layout.preferredWidth: 3
        spacing: 6
        RowLayout{
            Layout.fillWidth: true
            Layout.fillHeight: true

            DataTile{
                values: [signalHandler?.bmsState]
                Layout.fillWidth: true
                Layout.fillHeight: true
                flowDirection: Qt.Horizontal
            }
            DataTile{
                title: "IMD"
                values: [signalHandler?.IMD_ok? "ON" : "OFF"]
                Layout.fillWidth: true
                Layout.fillHeight: true
                flowDirection: Qt.Horizontal
            }
        }

        DataTile {
            title: "AIR+"
            values: [signalHandler?.airPlus? "ON" : "OFF"]
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        DataTile {
            title: "AIR-"
            values: [signalHandler?.airMinus? "ON" : "OFF"]
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        DataTile {
            title: "PRECHARGE"
            values: [signalHandler?.precharge? "ON" : "OFF"]
            Layout.fillWidth: true
            Layout.fillHeight: true
            flowDirection: Qt.Horizontal
        }

        RowLayout{
            Layout.fillWidth: true
            Layout.fillHeight: true

            DataTile{
                title: "TC"
                values: [signalHandler?.bmsTotalCurrent + "A"]
                Layout.fillWidth: true
                Layout.fillHeight: true
                flowDirection: Qt.Horizontal
            }
            DataTile{
                title: "TV"
                values: [signalHandler?.bmsTotalVoltage + "V"]
                Layout.fillWidth: true
                Layout.fillHeight: true
                flowDirection: Qt.Horizontal
            }
        }

        RowLayout{
            Layout.fillWidth: true
            Layout.fillHeight: true

            DataTile{
                title: "SC"
                values: [signalHandler?.soc + "%"]
                Layout.fillWidth: true
                Layout.fillHeight: true
                flowDirection: Qt.Horizontal
            }
            DataTile{
                title: "SP"
                values: [signalHandler?.sop]
                Layout.fillWidth: true
                Layout.fillHeight: true
                flowDirection: Qt.Horizontal
            }
        }
        DataTile{
            title: "NTC[°C]"
            values: [
                signalHandler?.ntcTemperature[0],
                signalHandler?.ntcTemperature[1]
            ]
            Layout.fillWidth: true
            Layout.fillHeight: true
            flowDirection: Qt.Horizontal
        }
    }
}
