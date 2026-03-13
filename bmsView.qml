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
                ["45", "45"],
                ["41", "43"],
                ["50", "47"],
                ["30", "33"],
                ["60", "62"]
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
                ["45","45","45"],
                ["41","42","43"],
                ["50","48","47"],
                ["30","32","33"],
                ["60","61","62"]
            ]
            ValueRow {
                Layout.fillWidth: true
                Layout.fillHeight: true
                values: modelData
            }
        }
    }
    // STATUS COLUMN
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
                signalHandler?.NTC_Temperature1,
                signalHandler?.NTC_Temperature2
            ]
            Layout.fillWidth: true
            Layout.fillHeight: true
            flowDirection: Qt.Horizontal
        }
    }
}
