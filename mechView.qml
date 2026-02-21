import QtQuick
import QtQuick.Layouts

Rectangle{
    anchors.fill: parent
    color: "black"
    ColumnLayout {
        anchors.fill: parent
        spacing: 10

        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height * 0.2
            spacing: 10

            Repeater {
                model: 4
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.preferredWidth: 1   // equal stretch

                    color: "black"
                    border.width: 5
                    border.color: "white"

                    Text {
                        anchors.centerIn: parent
                        color: "white"
                        font.pixelSize: parent.height * 0.5
                        text: {
                            switch(index) {
                            case 0: return "BT: 100 C"
                            case 1: return "INV: 100 C"
                            case 2: return "SOC: 96%"
                            case 3: return "PRESET"
                            }
                        }
                    }
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height * 0.4
            spacing: 10

            Rectangle {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredWidth: 3
                color: "black"
                border.width: 5
                border.color: "white"

                Text {
                    anchors.centerIn: parent
                    text: "Motor Temp"
                    color: "white"
                    font.pixelSize: parent.height * 0.5
                }
            }

            Rectangle {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredWidth: 3
                color: "black"
                border.width: 5
                border.color: "white"

                Text {
                    anchors.centerIn: parent
                    text: "Motor RPM"
                    color: "white"
                    font.pixelSize: parent.height * 0.5
                }
            }

            Rectangle {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredWidth: 2
                color: "black"
                border.width: 5
                border.color: "white"

                Text {
                    anchors.centerIn: parent
                    text: "Slip"
                    color: "white"
                    font.pixelSize: parent.height * 0.5
                }
            }

            Rectangle {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredWidth: 3
                color: "black"
                border.width: 5
                border.color: "white"

                Text {
                    anchors.centerIn: parent
                    text: "Torque"
                    color: "white"
                    font.pixelSize: parent.height * 0.5
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height * 0.4
            spacing: 10

            Rectangle {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredWidth: 2
                color: "black"
                border.width: 5
                border.color: "white"

                Text {
                    anchors.centerIn: parent
                    text: "Motor Temp"
                    color: "white"
                    font.pixelSize: parent.height * 0.5
                }
            }

            Rectangle {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredWidth: 2
                color: "black"
                border.width: 5
                border.color: "white"

                Text {
                    anchors.centerIn: parent
                    text: "Damper"
                    color: "white"
                    font.pixelSize: parent.height * 0.5
                }
            }

            Rectangle {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredWidth: 3
                color: "black"
                border.width: 5
                border.color: "white"

                Text {
                    anchors.centerIn: parent
                    text: "COR.FAC"
                    color: "white"
                    font.pixelSize: parent.height * 0.5
                }
            }


        }
    }
}
