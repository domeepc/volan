import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import volan

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
                [signalHandler?.bms.voltageMin[0].toFixed(1), signalHandler?.bms.voltageMax[0].toFixed(1)],
                [signalHandler?.bms.voltageMin[1].toFixed(1), signalHandler?.bms.voltageMax[1].toFixed(1)],
                [signalHandler?.bms.voltageMin[2].toFixed(1), signalHandler?.bms.voltageMax[2].toFixed(1)],
                [signalHandler?.bms.voltageMin[3].toFixed(1), signalHandler?.bms.voltageMax[3].toFixed(1)],
                [signalHandler?.bms.voltageMin[4].toFixed(1), signalHandler?.bms.voltageMax[4].toFixed(1)]
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
                [signalHandler?.bms.temperatureMin[0].toFixed(1), signalHandler?.bms.temperatureAvg[0].toFixed(1), signalHandler?.bms.temperatureMax[0].toFixed(1)],
                [signalHandler?.bms.temperatureMin[1].toFixed(1), signalHandler?.bms.temperatureAvg[1].toFixed(1), signalHandler?.bms.temperatureMax[1].toFixed(1)],
                [signalHandler?.bms.temperatureMin[2].toFixed(1), signalHandler?.bms.temperatureAvg[2].toFixed(1), signalHandler?.bms.temperatureMax[2].toFixed(1)],
                [signalHandler?.bms.temperatureMin[3].toFixed(1), signalHandler?.bms.temperatureAvg[3].toFixed(1), signalHandler?.bms.temperatureMax[3].toFixed(1)],
                [signalHandler?.bms.temperatureMin[4].toFixed(1), signalHandler?.bms.temperatureAvg[4].toFixed(1), signalHandler?.bms.temperatureMax[4].toFixed(1)]
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
                values: [signalHandler?.bms.state]
                Layout.fillWidth: true
                Layout.fillHeight: true
                flowDirection: Qt.Horizontal
            }
            DataTile{
                title: "IMD"
                values: [signalHandler?.bms.IMD_ok? "ON" : "OFF"]
                Layout.fillWidth: true
                Layout.fillHeight: true
                flowDirection: Qt.Horizontal
            }
        }

        DataTile {
            title: "AIR+"
            values: [signalHandler?.bms.airPlus? "ON" : "OFF"]
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        DataTile {
            title: "AIR-"
            values: [signalHandler?.bms.airMinus? "ON" : "OFF"]
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        DataTile {
            title: "PRECHARGE"
            values: [signalHandler?.bms.precharge? "ON" : "OFF"]
            Layout.fillWidth: true
            Layout.fillHeight: true
            flowDirection: Qt.Horizontal
        }

        RowLayout{
            Layout.fillWidth: true
            Layout.fillHeight: true

            DataTile{
                title: "TC"
                values: [signalHandler?.bms.totalCurrent + "A"]
                Layout.fillWidth: true
                Layout.fillHeight: true
                flowDirection: Qt.Horizontal
            }
            DataTile{
                title: "TV"
                values: [signalHandler?.bms.totalVoltage + "V"]
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
                values: [signalHandler?.bms.soc + "%"]
                Layout.fillWidth: true
                Layout.fillHeight: true
                flowDirection: Qt.Horizontal
            }
            DataTile{
                title: "SP"
                values: [signalHandler?.bms.sop]
                Layout.fillWidth: true
                Layout.fillHeight: true
                flowDirection: Qt.Horizontal
            }
        }
        DataTile{
            title: "NTC[°C]"
            values: [
                signalHandler?.bms.ntcTemperature[0],
                signalHandler?.bms.ntcTemperature[1]
            ]
            Layout.fillWidth: true
            Layout.fillHeight: true
            flowDirection: Qt.Horizontal
        }
    }
}
