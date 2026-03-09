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

        DataTile{
            values: ["default"]
            Layout.fillWidth: true
            Layout.fillHeight: true
            flowDirection: Qt.horizontal
        }


        ValueRow {
            values: ["TC:45A","TV:100V"]
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
        ValueRow {
            values: ["SC:100%","SP:80"]
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
        DataTile{
            title: "NTC"
            values: ["100","100"]
            Layout.fillWidth: true
            Layout.fillHeight: true
            flowDirection: Qt.Horizontal
        }

        DataTile {
            title: "AIR+"
            values: ["off"]
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
        DataTile {
            title: "AIR-"
            values: ["off"]
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        DataTile {
            title: "PRECHARGE"
            values: ["off"]
            Layout.fillWidth: true
            Layout.fillHeight: true
            flowDirection: Qt.Horizontal
        }
    }
}
