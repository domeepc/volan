import QtQuick
import QtQuick.Layouts

ColumnLayout{
    anchors.fill: parent
    spacing: 10

    RowLayout{
        Layout.fillHeight: true
        Layout.fillWidth: true
        spacing: 10

        //struja invertera
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

        //temperature motora
        Rectangle{
            Layout.fillHeight: true
            Layout.fillWidth: true

            color: "black"


        }

        //temperature invertera
        Rectangle{
            Layout.fillHeight: true
            Layout.fillWidth: true

            color: "black"


        }
    }
    RowLayout{
        Layout.fillHeight: true
        Layout.fillWidth: true
        spacing: 10

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
        Rectangle{
            Layout.fillHeight: true
            Layout.fillWidth: true

            color: "black"
        }
        Rectangle{
            Layout.fillHeight: true
            Layout.fillWidth: true

            color: "black"
        }
    }
    RowLayout{
        Layout.fillHeight: true
        Layout.fillWidth: true
        spacing: 10

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
        Rectangle{
            Layout.fillHeight: true
            Layout.fillWidth: true

            color: "black"
        }
        Rectangle{
            Layout.fillHeight: true
            Layout.fillWidth: true

            color: "black"
        }
    }
    RowLayout{
        Layout.fillHeight: true
        Layout.fillWidth: true
        spacing: 10

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

            Column{
                anchors.centerIn: parent
                Text{
                    text: "DS1"
                    color: "white"
                    font.pixelSize: parent.parent.height * 0.4
                    font.bold: true
                }
                Text{
                    text: "DS2"
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

            Column{
                anchors.centerIn: parent
                Text{
                    text: "ES1"
                    color: "white"
                    font.pixelSize: parent.parent.height * 0.4
                    font.bold: true
                }
                Text{
                    text: "ES2"
                    color: "white"
                    font.pixelSize: parent.parent.height * 0.4
                    font.bold: true
                }
            }
        }
    }

    //faultovi
    RowLayout{
        Layout.fillHeight: true
        Layout.fillWidth: true
        spacing: 10
        Rectangle{
            Layout.fillHeight: true
            Layout.fillWidth: true

            color: "black"
            Column{
                anchors.centerIn: parent
                Text{
                    text: "fault1"
                    color: "white"
                    font.pixelSize: parent.parent.height * 0.4
                    font.bold: true
                }
                Text{
                    text: "fault1"
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
            Column{
                anchors.centerIn: parent
                Text{
                    text: "fault1"
                    color: "white"
                    font.pixelSize: parent.parent.height * 0.4
                    font.bold: true
                }
                Text{
                    text: "fault1"
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
            Column{
                anchors.centerIn: parent
                Text{
                    text: "fault1"
                    color: "white"
                    font.pixelSize: parent.parent.height * 0.4
                    font.bold: true
                }
                Text{
                    text: "fault1"
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
            Column{
                anchors.centerIn: parent
                Text{
                    text: "fault1"
                    color: "white"
                    font.pixelSize: parent.parent.height * 0.4
                    font.bold: true
                }
                Text{
                    text: "fault1"
                    color: "white"
                    font.pixelSize: parent.parent.height * 0.4
                    font.bold: true
                }
            }
        }

    }
}
