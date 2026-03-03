import QtQuick
import QtQuick.Layouts

GridLayout{
    anchors.fill: parent
    columnSpacing: 10
    rowSpacing: 10

    flow:  GridLayout.TopToBottom

    rows: 5

    //Struja invertera
    Rectangle{
        Layout.fillHeight: true
        Layout.fillWidth: true
        color: "black"

        Row{
            anchors.centerIn: parent
            spacing: 10
            Text {
                text: "AC[A]"
                color: "white"

                font.pixelSize: parent.parent.height * 0.4
                font.bold: true
            }
            Text {
                text: "100"
                color: "white"

                font.pixelSize: parent.parent.height * 0.4
                font.bold: true
            }
            Text {
                text: "100"
                color: "white"

                font.pixelSize: parent.parent.height * 0.4
                font.bold: true
            }
        }
    }

    //Temperature motora
    Rectangle{
        Layout.fillHeight: true
        Layout.fillWidth: true

        color: "black"

        Row{
            anchors.centerIn: parent
            spacing: 10
            Text {
                text: "TM[°C]"
                color: "white"

                font.pixelSize: parent.parent.height * 0.4
                font.bold: true
            }
            Text {
                text: "100"
                color: "white"

                font.pixelSize: parent.parent.height * 0.4
                font.bold: true
            }
            Text {
                text: "100"
                color: "white"

                font.pixelSize: parent.parent.height * 0.4
                font.bold: true
            }
        }
    }

    //Temperature invertera
    Rectangle{
        Layout.fillHeight: true
        Layout.fillWidth: true

        color: "black"

        Row{
            anchors.centerIn: parent
            spacing: 10
            Text {
                text: "TI[°C]"
                color: "white"

                font.pixelSize: parent.parent.height * 0.4
                font.bold: true
            }
            Text {
                text: "100"
                color: "white"

                font.pixelSize: parent.parent.height * 0.4
                font.bold: true
            }
            Text {
                text: "100"
                color: "white"

                font.pixelSize: parent.parent.height * 0.4
                font.bold: true
            }
        }
    }

    //ERPMs
    Rectangle{
        Layout.fillHeight: true
        Layout.fillWidth: true

        color: "black"

        Row{
            anchors.centerIn: parent
            spacing: 10
            Text {
                text: "ERPM"
                color: "white"

                font.pixelSize: parent.parent.height * 0.4
                font.bold: true
            }
            Text {
                text: "100"
                color: "white"

                font.pixelSize: parent.parent.height * 0.4
                font.bold: true
            }
            Text {
                text: "100"
                color: "white"

                font.pixelSize: parent.parent.height * 0.4
                font.bold: true
            }
        }
    }

    Rectangle{
        Layout.fillHeight: true
        Layout.fillWidth: true
        color: "black"

        Text{
            text: "0 faults"
            color: "white"
            anchors.centerIn: parent
            font.pixelSize: parent.height * 0.5
            font.bold: true
        }
    }


    //Srednji stupac stanja lijevog invertera
    Rectangle{
        Layout.fillHeight: true
        Layout.fillWidth: true
        color: "black"

        Text{
            text: "LES"
            color: "white"
            anchors.centerIn: parent
            font.pixelSize: parent.height * 0.5
            font.bold: true
        }
    }
    Rectangle{
        Layout.fillHeight: true
        Layout.fillWidth: true
        color: "black"

        Text{
            text: "DS1"
            color: "white"
            anchors.centerIn: parent
            font.pixelSize: parent.height * 0.5
            font.bold: true
        }
    }
    Rectangle{
        Layout.fillHeight: true
        Layout.fillWidth: true
        color: "black"

        Text{
            text: "DS1"
            color: "white"
            anchors.centerIn: parent
            font.pixelSize: parent.height * 0.5
            font.bold: true
        }
    }
    Rectangle{
        Layout.fillHeight: true
        Layout.fillWidth: true
        color: "black"

        Text{
            text: "DS1"
            color: "white"
            anchors.centerIn: parent
            font.pixelSize: parent.height * 0.5
            font.bold: true
        }
    }
    Rectangle{
        Layout.fillHeight: true
        Layout.fillWidth: true
        color: "black"

        Text{
            text: "DS1"
            color: "white"
            anchors.centerIn: parent
            font.pixelSize: parent.height * 0.5
            font.bold: true
        }
    }




    //Desni stupac stanja desnog invertera
    Rectangle{
        Layout.fillHeight: true
        Layout.fillWidth: true
        color: "black"

        Text{
            text: "RES"
            color: "white"
            anchors.centerIn: parent
            font.pixelSize: parent.height * 0.5
            font.bold: true
        }
    }
    Rectangle{
        Layout.fillHeight: true
        Layout.fillWidth: true
        color: "black"

        Text{
            text: "DS1"
            color: "white"
            anchors.centerIn: parent
            font.pixelSize: parent.height * 0.5
            font.bold: true
        }
    }
    Rectangle{
        Layout.fillHeight: true
        Layout.fillWidth: true
        color: "black"

        Text{
            text: "DS1"
            color: "white"
            anchors.centerIn: parent
            font.pixelSize: parent.height * 0.5
            font.bold: true
        }
    }
    Rectangle{
        Layout.fillHeight: true
        Layout.fillWidth: true
        color: "black"

        Text{
            text: "DS1"
            color: "white"
            anchors.centerIn: parent
            font.pixelSize: parent.height * 0.5
            font.bold: true
        }
    }
    Rectangle{
        Layout.fillHeight: true
        Layout.fillWidth: true
        color: "black"

        Text{
            text: "DS1"
            color: "white"
            anchors.centerIn: parent
            font.pixelSize: parent.height * 0.5
            font.bold: true
        }
    }







}
