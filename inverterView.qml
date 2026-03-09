import QtQuick
import QtQuick.Layouts

GridLayout {
    anchors.fill: parent
    columnSpacing: 10
    rowSpacing: 10

    flow: GridLayout.TopToBottom
    rows: 5


    Repeater {
        model: [
            {label: "AC[A]", values: ["100","100"]},
            {label: "TM[°C]", values: ["100","100"]},
            {label: "TI[°C]", values: ["100","100"]},
            {label: "ERPM", values: ["100","100"]}
        ]

        delegate: Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "black"

            Row {
                anchors.centerIn: parent
                spacing: 15

                Text {
                    text: modelData.label
                    color: "white"
                    font.bold: true
                    font.pixelSize: parent.parent.height * 0.35
                }

                Repeater {
                    model: modelData.values

                    Text {
                        text: modelData
                        color: "white"
                        font.bold: true
                        font.pixelSize: parent.parent.height * 0.35
                    }
                }
            }
        }
    }

    // brojac faultova
    Rectangle {
        Layout.fillHeight: true
        Layout.fillWidth: true
        color: "black"

        Text {
            text: "0 faults"
            color: "white"
            anchors.centerIn: parent
            font.pixelSize: parent.height * 0.45
            font.bold: true
        }
    }

    //stanja lijevog stanja
    Repeater {
        model: ["LES", "DS1", "DS1", "DS1", "DS1"]

        delegate: Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: "black"
            radius: 6

            Text {
                text: modelData
                color: "white"
                anchors.centerIn: parent
                font.pixelSize: parent.height * 0.45
                font.bold: true
            }
        }
    }

    //stanja desnog invertera
    Repeater {
        model: ["RES", "DS1", "DS1", "DS1", "DS1"]

        delegate: Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: "black"
            radius: 6

            Text {
                text: modelData
                color: "white"
                anchors.centerIn: parent
                font.pixelSize: parent.height * 0.45
                font.bold: true
            }
        }
    }
}
