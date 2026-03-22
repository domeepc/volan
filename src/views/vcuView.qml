import QtQuick
import QtQuick.Layouts

RowLayout{
    anchors.fill: parent
    spacing: 5

    ColumnLayout{
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.preferredWidth: 3
        spacing: 5

        //struja za bms i vcu
        Rectangle{
            id: root4
            Layout.fillWidth: true
            Layout.fillHeight: true

            color: "black"
            Row{
                anchors.centerIn: parent
                spacing: 10

                Text {
                    text: "BC " + signalHandler?.bms.totalCurrent + "A"
                    color: "white"
                    font.pixelSize: root1.height * 0.7
                    font.bold: true
                }
                Text {
                    text: "VC " + signalHandler?.vcu.current + "A"
                    color: "white"
                    font.pixelSize: root1.height * 0.7
                    font.bold: true
                }
            }
        }

        //tlak pedala za gas
        Rectangle{
            id: root1
            Layout.fillWidth: true
            Layout.fillHeight: true

            color: "black"
            Row{
                anchors.centerIn: parent
                spacing: 10

                Text {
                    text: "APPS[%]"
                    color: "white"
                    font.pixelSize: root1.height * 0.7
                    font.bold: true
                }
                Text {
                    text: signalHandler?.vcu.brakePressureForward
                    color: "white"
                    font.pixelSize: root1.height * 0.7
                    font.bold: true
                }
                Text {
                    text: signalHandler?.vcu.brakePressureRear
                    color: "white"
                    font.pixelSize: root1.height * 0.7
                    font.bold: true
                }
            }
        }

        //tlak kocnica
        Rectangle{
            id: root2
            Layout.fillWidth: true
            Layout.fillHeight: true

            color: "black"
            Row{
                anchors.centerIn: parent
                spacing: 10

                Text {
                    text: "BPS[%]"
                    color: "white"
                    font.pixelSize: root2.height * 0.7
                    font.bold: true
                }
                Text {
                    text: signalHandler?.vcu.brakePressureForward
                    color: "white"
                    font.pixelSize: root2.height * 0.7
                    font.bold: true
                }
                Text {
                    text: signalHandler?.vcu.brakePressureRear
                    color: "white"
                    font.pixelSize: root2.height * 0.7
                    font.bold: true
                }
            }
        }

        //steering angle
        Rectangle{
            id: root3
            Layout.fillWidth: true
            Layout.fillHeight: true

            color: "black"
            Row{
                anchors.centerIn: parent
                Text {
                    text: "SW "
                    color: "white"
                    font.pixelSize: root3.height * 0.7
                    font.bold: true
                }
                Text {
                    text: signalHandler?.vcu.swAngle1 + "°"
                    color: "white"
                    font.pixelSize: root3.height * 0.7
                    font.bold: true
                }
                Text {
                    text: signalHandler?.vcu.swAngle2 + "°"
                    color: "white"
                    font.pixelSize: root3.height * 0.7
                    font.bold: true
                }
            }
        }

        //podaci s IMU-a
        Rectangle{
            id: root5
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: 4

            color: "black"
            ColumnLayout {
                anchors.fill: parent
                spacing: 5

                Text {
                    text: "ACLx: " + signalHandler?.vcu.accelerationX
                    color: "white"
                    font.bold: true
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    font.pixelSize: height * 0.7
                    horizontalAlignment: Text.AlignHCenter
                }

                Text {
                    text: "ACLy: " + signalHandler?.vcu.accelerationY
                    color: "white"
                    font.bold: true
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    font.pixelSize: height * 0.7
                    horizontalAlignment: Text.AlignHCenter
                }

                Text {
                    text: "ACLz: " + signalHandler?.vcu.accelerationZ
                    color: "white"
                    font.bold: true
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    font.pixelSize: height * 0.7
                    horizontalAlignment: Text.AlignHCenter
                }

                Text {
                    text: "GYROz: " + signalHandler?.vcu.gyroZ
                    color: "white"
                    font.bold: true
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    font.pixelSize: height * 0.7
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }

    }
    ColumnLayout{
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.preferredWidth: 2
        spacing: 5

        Rectangle{
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.preferredHeight: 1
            color: "black"

            Text{
                text: signalHandler?.vcu.mode
                color: "white"
                anchors.centerIn: parent
                font.pixelSize: parent.height * 0.7
                font.bold: true
            }
        }

        Repeater{
            model: 8
            Rectangle{
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredHeight: 1
                color: "black"

                Text {
                    text: "dig_stanje"
                    color: "white"
                    anchors.centerIn: parent
                    font.pixelSize: parent.height * 0.7
                    font.bold: true
                }
            }
        }
    }

    ColumnLayout{
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.preferredWidth: 2
        spacing: 5

        Rectangle{
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.preferredHeight: 1
            color: "black"

            Text{
                text: "LV-BAT"
                color: "white"
                anchors.centerIn: parent
                font.pixelSize: parent.height * 0.7
                font.bold: true
            }
        }
        Repeater{
            model: 4

            Rectangle{
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredHeight: 2
                color: "black"

                Text {
                    text: "kanal"
                    color: "white"
                    anchors.centerIn: parent
                    font.pixelSize: parent.height * 0.7
                    font.bold: true
                }
            }
        }

    }
}
