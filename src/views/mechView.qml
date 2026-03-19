import QtQuick
import QtQuick.Layouts

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
            values: [signalHandler?.slip]
        }

        DataTile {
            Layout.fillWidth: true
            Layout.fillHeight: true
            title: "SOC"
            flowDirection: Qt.Horizontal
            values: [signalHandler?.soc + "%"]
        }

        DataTile {
            Layout.fillWidth: true
            Layout.fillHeight: true
            title: ""
            flowDirection: Qt.Horizontal
            values: [signalHandler?.preset]
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
                signalHandler?.motorTemperatureL,
                signalHandler?.motorTemperatureR
            ]
        }

        DataTile {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 2
            title: "M-RPM"
            flowDirection: Qt.Vertical
            values: [
                signalHandler?.rpmL,
                signalHandler?.rpmR
            ]
        }

        DataTile {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 2
            title: "BRAKE"
            flowDirection: Qt.Vertical
            values: [
                signalHandler?.brakePressureForward,
                signalHandler?.brakePressureRear
            ]
        }

        DataTile {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 2
            title: "I-TEMP"
            flowDirection: Qt.Vertical
            values: [
                signalHandler?.inverterTemperatureL,
                signalHandler?.inverterTemperatureR
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
                signalHandler?.torqueL,
                signalHandler?.torqueR
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
                signalHandler?.cFactor1,
                signalHandler?.cFactor2,
                signalHandler?.cFactor3,
                signalHandler?.cFactor4
            ]
        }
    }
}
