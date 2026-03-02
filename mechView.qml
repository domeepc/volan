import QtQuick
import QtQuick.Layouts


ColumnLayout {
    anchors.fill: parent
    spacing: 10

    RowLayout {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredHeight: parent.height * 0.2
        spacing: 10

        //prosjecna temperatura svih modula tj. temperatura baterije
        Rectangle {
            id: batteryTemperature
            Layout.fillWidth: true
            Layout.fillHeight: true

            color: "black"

            Text {
                text: "BT:" + "100°C"
                anchors.centerIn: parent

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                color: "white"
                font.pixelSize: parent.height * 0.5
                font.bold: true
            }
        }

        //slip omjer
        Rectangle {
            id: slipRatio
            Layout.fillWidth: true
            Layout.fillHeight: true


            color: "black"

            Text {
                text: "SLIP " + "0.8"
                anchors.centerIn: parent

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                color: "white"
                font.pixelSize: parent.height * 0.5
                font.bold: true
            }
        }

        //SoC
        Rectangle {
            id: stateOfCharge
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 1   // equal stretch

            color: "black"

            Text {
                text: "SC:" + "100%"
                anchors.centerIn: parent

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignHCenter

                color: "white"
                font.pixelSize: parent.height * 0.5
                font.bold: true
            }
        }

        //Preset
        Rectangle {
            id: preset
            Layout.fillWidth: true
            Layout.fillHeight: true

            color: "black"

            Text {
                text: "PRESET"
                anchors.fill: parent

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                color: "white"
                font.pixelSize: parent.height * 0.5
                font.bold: true
            }
        }

    }

    RowLayout {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredHeight: parent.height * 0.4
        spacing: 10

        //Temperature motora
        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.preferredWidth: 2
            color: "black"

            ColumnLayout {
                anchors.fill: parent
                spacing: 10

                Text {
                    text: "M-TEMP"

                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    color: "white"
                    font.pixelSize: height * 0.5
                    font.bold: true
                }


                RowLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: 20

                    Text {
                        text: "45"

                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                        color: "white"
                        font.pixelSize: height * 0.5
                        font.bold: true
                    }
                    Text {
                        text: "45"

                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                        color: "white"
                        font.pixelSize: height * 0.5
                        font.bold: true
                    }
                }
            }
        }

        //rpm motora
        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.preferredWidth: 2
            color: "black"

            ColumnLayout {
                anchors.fill: parent
                spacing: 10

                Text {
                    text: "M-RPM"

                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    color: "white"
                    font.pixelSize: height * 0.5
                    font.bold: true
                }


                RowLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: 20

                    Text {
                        text: "45"

                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                        color: "white"
                        font.pixelSize: height * 0.5
                        font.bold: true
                    }
                    Text {
                        text: "45"

                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                        color: "white"
                        font.pixelSize: height * 0.5
                        font.bold: true
                    }
                }
            }
        }

        //Pritisak kocnica
        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.preferredWidth: 2
            color: "black"

            ColumnLayout {
                anchors.fill: parent
                spacing: 10

                Text {
                    text: "BRAKE"

                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    color: "white"
                    font.pixelSize: height * 0.5
                    font.bold: true
                }


                RowLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: 20

                    Text {
                        text: "45"

                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                        color: "white"
                        font.pixelSize: height * 0.5
                        font.bold: true
                    }
                    Text {
                        text: "45"

                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                        color: "white"
                        font.pixelSize: height * 0.5
                        font.bold: true
                    }
                }
            }
        }

        //Inverter temperature
        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.preferredWidth: 2
            color: "black"

            ColumnLayout {
                anchors.fill: parent
                spacing: 10

                Text {
                    text: "I-TEMP"

                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    color: "white"
                    font.pixelSize: height * 0.5
                    font.bold: true
                }


                RowLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: 20

                    Text {
                        text: "45"

                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                        color: "white"
                        font.pixelSize: height * 0.5
                        font.bold: true
                    }
                    Text {
                        text: "45"

                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                        color: "white"
                        font.pixelSize: height * 0.5
                        font.bold: true
                    }
                }
            }
        }
    }


    RowLayout {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredHeight: parent.height * 0.4
        spacing: 10

        //torque(moment?) vrijednosti
        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.preferredWidth: 1
            color: "black"

            ColumnLayout {
                anchors.fill: parent
                spacing: 10

                Text {
                    text: "TORQUE"

                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    color: "white"
                    font.pixelSize: height * 0.5
                    font.bold: true
                }


                RowLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: 20

                    Text {
                        text: "45"

                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                        color: "white"
                        font.pixelSize: height * 0.5
                        font.bold: true
                    }
                    Text {
                        text: "45"

                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                        color: "white"
                        font.pixelSize: height * 0.5
                        font.bold: true
                    }
                }
            }
        }

        //damper pozicija
        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.preferredWidth: 1
            color: "black"

            ColumnLayout {
                anchors.fill: parent
                spacing: 10

                Text {
                    text: "DAMPER"

                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    color: "white"
                    font.pixelSize: height * 0.5
                    font.bold: true
                }


                RowLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: 20

                    Text {
                        text: "45"

                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                        color: "white"
                        font.pixelSize: height * 0.5
                        font.bold: true
                    }
                    Text {
                        text: "45"

                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                        color: "white"
                        font.pixelSize: height * 0.5
                        font.bold: true
                    }
                }
            }
        }


        //korekcisjki faktori
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 2

            color: "black"

            ColumnLayout {
                anchors.fill: parent
                spacing: 10

                Text {
                    text: "C-FACTORS"

                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    color: "white"
                    font.pixelSize: height * 0.5
                    font.bold: true
                }

                RowLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: 20

                    Text {
                        text: "12"

                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        Layout.alignment: Qt.AlignHCenter

                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                        color: "white"

                        font.pixelSize: height * 0.5
                        font.bold: true
                    }
                    Text {
                        text: "12"

                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        Layout.alignment: Qt.AlignHCenter

                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                        color: "white"

                        font.pixelSize: height * 0.5
                        font.bold: true
                    }
                    Text {
                        text: "12"

                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        Layout.alignment: Qt.AlignHCenter

                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                        color: "white"

                        font.pixelSize: height * 0.5
                        font.bold: true
                    }
                    Text {
                        text: "12"

                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        Layout.alignment: Qt.AlignHCenter

                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                        color: "white"

                        font.pixelSize: height * 0.5
                        font.bold: true
                    }
                }
            }
        }
    }
}

