import QtQuick
import QtQuick.Layouts

RowLayout {
    anchors.fill: parent
    spacing: 10

    // LEFT COLUMN (telemetry)
    ColumnLayout {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredWidth: 4
        spacing: 10

        Repeater {
            model: [
                {title: "AC[A]", values: [signalHandler?.AC_L, signalHandler?.AC_R], dir: Qt.Horizontal},
                {title: "TM[°C]", values: [signalHandler?.motorTemperatureL, signalHandler?.motorTemperatureR], dir: Qt.Horizontal},
                {title: "TI[°C]", values: [signalHandler?.inverterTemperatureL, signalHandler?.inverterTemperatureR], dir: Qt.Horizontal},
                {title: "ERPM", values: [signalHandler?.ERPM_L, signalHandler?.ERPM_R], dir: Qt.Vertical},
                {title: "Faults:", values: [signalHandler?.faultCount], dir: Qt.Horizontal}
            ]

            DataTile {
                Layout.fillWidth: true
                Layout.fillHeight: true
                flowDirection: modelData.dir
                title: modelData.title
                values: modelData.values
            }
        }
    }

    // MIDDLE COLUMN (left inverter states)
    ColumnLayout {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredWidth: 3
        spacing: 10

        Repeater {
            model:[
                {title: "LDE", values: [signalHandler?.LDriveEnableState? "ON" : "OFF"], dir: Qt.Horizontal},
                {title: "LDO1", values: [signalHandler?.LdigitalOutput1? "ON" : "OFF"], dir: Qt.Horizontal},
                {title: "LDO2", values: [signalHandler?.LdigitalOutput2? "ON" : "OFF"], dir: Qt.Horizontal},
                {title: "LDO3", values: [signalHandler?.LdigitalOutput3? "ON" : "OFF"], dir: Qt.Horizontal},
                {title: "LDO4", values: [signalHandler?.LdigitalOutput4? "ON" : "OFF"], dir: Qt.Horizontal},
            ]
            DataTile {
                Layout.fillWidth: true
                Layout.fillHeight: true
                title: modelData.title
                values: modelData.values
                flowDirection: modelData.dir
            }
        }
    }

    // RIGHT COLUMN (right inverter states)
    ColumnLayout {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredWidth: 3
        spacing: 10

        Repeater {
            model:[
                {title: "RDE", values: [signalHandler?.RDriveEnableState? "ON" : "OFF"], dir: Qt.Horizontal},
                {title: "RDO1", values: [signalHandler?.RdigitalOutput1? "ON" : "OFF"], dir: Qt.Horizontal},
                {title: "RDO2", values: [signalHandler?.RdigitalOutput2? "ON" : "OFF"], dir: Qt.Horizontal},
                {title: "RDO3", values: [signalHandler?.RdigitalOutput3? "ON" : "OFF"], dir: Qt.Horizontal},
                {title: "RDO4", values: [signalHandler?.RdigitalOutput4? "ON" : "OFF"], dir: Qt.Horizontal}
            ]
            DataTile {
                Layout.fillWidth: true
                Layout.fillHeight: true
                title: modelData.title
                values: modelData.values
                flowDirection: modelData.dir
            }
        }
    }
}
