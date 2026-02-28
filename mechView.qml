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


            Rectangle {
                id: batteryTemperature
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
                    text: "BT " + "100 C"
                }
            }

            Rectangle {
                id: inverterTemperature
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
                    text: "IT " + "100 C"
                }
            }

            Rectangle {
                id: stateOfCharge
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
                    text: "SOC " + "100%"
                }
            }

            Rectangle {
                id: preset
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
                    text: "PRESET"
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

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 10

                    Text {
                        text: "Motor temp"
                        color: "white"
                        font.pixelSize: parent.height * 0.2

                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignHCenter
                    }


                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 20

                        Text {
                            text: "45"
                            color: "white"
                            font.pixelSize: 50

                            Layout.fillWidth: true
                            horizontalAlignment: Text.AlignHCenter
                        }
                        Text {
                            text: "45"
                            color: "white"
                            font.pixelSize: 50

                            Layout.fillWidth: true
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                }
            }

            Rectangle {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredWidth: 3
                color: "black"
                border.width: 5
                border.color: "white"

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 10

                    Text {
                        text: "Motor rpm"
                        color: "white"
                        font.pixelSize: parent.height * 0.2

                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignHCenter
                    }


                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 20

                        Text {
                            text: "45"
                            color: "white"
                            font.pixelSize: 50

                            Layout.fillWidth: true
                            horizontalAlignment: Text.AlignHCenter
                        }
                        Text {
                            text: "45"
                            color: "white"
                            font.pixelSize: 50

                            Layout.fillWidth: true
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                }
            }

            Rectangle {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredWidth: 3
                color: "black"
                border.width: 5
                border.color: "white"

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 10

                    Text {
                        text: "Brake"
                        color: "white"
                        font.pixelSize: parent.height * 0.2

                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignHCenter
                    }


                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 20

                        Text {
                            text: "45"
                            color: "white"
                            font.pixelSize: 50

                            Layout.fillWidth: true
                            horizontalAlignment: Text.AlignHCenter
                        }
                        Text {
                            text: "45"
                            color: "white"
                            font.pixelSize: 50

                            Layout.fillWidth: true
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                }
            }

            Rectangle {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredWidth: 2
                color: "black"
                border.width: 5
                border.color: "white"

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 10

                    Text {
                        text: "Slip"
                        color: "white"
                        font.pixelSize: parent.height * 0.2

                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignHCenter
                    }


                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 20

                        Text {
                            text: "45"
                            color: "white"
                            font.pixelSize: 50

                            Layout.fillWidth: true
                            horizontalAlignment: Text.AlignHCenter
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
                Layout.preferredWidth: 2
                color: "black"
                border.width: 5
                border.color: "white"

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 10

                    Text {
                        text: "Torque"
                        color: "white"
                        font.pixelSize: parent.height * 0.2

                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignHCenter
                    }


                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 20

                        Text {
                            text: "45"
                            color: "white"
                            font.pixelSize: 50

                            Layout.fillWidth: true
                            horizontalAlignment: Text.AlignHCenter
                        }
                        Text {
                            text: "45"
                            color: "white"
                            font.pixelSize: 50

                            Layout.fillWidth: true
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                }
            }

            Rectangle {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredWidth: 2
                color: "black"
                border.width: 5
                border.color: "white"

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 10

                    Text {
                        text: "Damper"
                        color: "white"
                        font.pixelSize: parent.height * 0.2

                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignHCenter
                    }


                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 20

                        Text {
                            text: "45"
                            color: "white"
                            font.pixelSize: 50

                            Layout.fillWidth: true
                            horizontalAlignment: Text.AlignHCenter
                        }
                        Text {
                            text: "45"
                            color: "white"
                            font.pixelSize: 50

                            Layout.fillWidth: true
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                }
            }



            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredWidth: 3
                color: "black"
                border.width: 5
                border.color: "white"


                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 10

                    // Title
                    Text {
                        Layout.fillWidth: true
                        text: "Correct factors"
                        color: "white"
                        font.pixelSize: 35
                        horizontalAlignment: Text.AlignHCenter
                    }

                    // Spacer (push numbers to bottom)
                    Item {
                        Layout.fillHeight: true
                    }

                    // Bottom row of numbers
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 20

                        Text {
                            text: "12"
                            color: "white"
                            font.pixelSize: 50

                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Text {
                            text: "12"
                            color: "white"
                            font.pixelSize: 50

                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Text {
                            text: "12"
                            color: "white"
                            font.pixelSize: 50

                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Text {
                            text: "12"
                            color: "white"
                            font.pixelSize: 50

                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignHCenter
                        }

                    }
                }
            }
        }
    }
}
