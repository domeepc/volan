import QtQuick
import QtQuick.Layouts
import volan

ColumnLayout {
    anchors.fill: parent
    spacing: 10

    RowLayout {
        Layout.fillWidth: true
        Layout.preferredHeight: parent.height * 0.2
        spacing: 10

        DataTile {
            Layout.fillWidth: true
            Layout.fillHeight: true
            title: "SLIP"
            flowDirection: Qt.Horizontal
            values: [signalHandler?.vcu.slip]
        }

        DataTile {
            Layout.fillWidth: true
            Layout.fillHeight: true
            title: "SOC"
            flowDirection: Qt.Horizontal
            values: [signalHandler?.bms.soc + "%"]
        }

        DataTile {
            Layout.fillWidth: true
            Layout.fillHeight: true
            title: ""
            flowDirection: Qt.Horizontal
            values: [signalHandler?.vcu.preset]
        }
    }

    RowLayout {
        Layout.fillWidth: true
        Layout.preferredHeight: parent.height * 0.4
        spacing: 10

        DataTile {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 2
            title: "M-TEMP"
            flowDirection: Qt.Vertical
            values: [
                signalHandler?.inverter.motorTemperatureL,
                signalHandler?.inverter.motorTemperatureR
            ]
        }

        DataTile {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 2
            title: "M-RPM"
            flowDirection: Qt.Vertical
            values: [
                signalHandler?.vcu.rpmL,
                signalHandler?.vcu.rpmR
            ]
        }

        DataTile {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 2
            title: "BRAKE"
            flowDirection: Qt.Vertical
            values: [
                signalHandler?.vcu.brakePressureForward,
                signalHandler?.vcu.brakePressureRear
            ]
        }

        DataTile {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 2
            title: "I-TEMP"
            flowDirection: Qt.Vertical
            values: [
                signalHandler?.inverter.temperatureL,
                signalHandler?.inverter.temperatureR
            ]
        }
    }

    RowLayout {
        Layout.fillWidth: true
        Layout.preferredHeight: parent.height * 0.4
        spacing: 10

        DataTile {
            Layout.fillWidth: true
            Layout.fillHeight: true
            title: "TORQUE"
            flowDirection: Qt.Vertical
            values: [
                signalHandler?.vcu.torqueL,
                signalHandler?.vcu.torqueR
            ]
        }

        DataTile {
            Layout.fillWidth: true
            Layout.fillHeight: true
            title: "B-TEMP"
            flowDirection: Qt.Vertical
            values: [
                0,
                0
            ]
        }

        DataTile {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 2
            title: "C-FACTORS"
            flowDirection: Qt.Vertical
            values: [
                signalHandler?.vcu.cFactor1,
                signalHandler?.vcu.cFactor2,
                signalHandler?.vcu.cFactor3,
                signalHandler?.vcu.cFactor4
            ]
        }
    }
}
