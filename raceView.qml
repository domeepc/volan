import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ColumnLayout {
    anchors.fill: parent
    spacing: 10

    Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredHeight: 2
        color: "black"

        RowLayout {
            anchors.centerIn: parent
            spacing: 50

            Repeater {
                model: 5
                Rectangle {
                    width: 50
                    height: 50
                    color: "red"
                }
            }
        }
    }

    Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true

        Layout.preferredHeight: 7
        color: "black"

        RowLayout {
            anchors.fill: parent
            spacing: 0

            Item {
                id: batteryPercent

                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredWidth: 1

                Layout.topMargin: 50
                Layout.bottomMargin: 50

                Row {
                    anchors.fill: parent
                    spacing: 10

                    Item {
                        width: 75
                        height: parent.height

                        Rectangle {
                            anchors.fill: parent
                            color: "#222"
                            radius: 8
                        }
                        Rectangle {
                            width: parent.width
                            height: parent.height * (signalHandler.soc - 50)/50
                            anchors.bottom: parent.bottom
                            color: "green"
                            radius: 8
                        }
                    }

                    // --- SCALE ---
                    Item {
                        width: 60
                        height: parent.height

                        Repeater {
                            model: 6

                            Text {
                                text: 50 + (index * 10)
                                color: "white"
                                font.pixelSize: 32
                                font.bold: true
                                y: parent.height - (index / 5) * parent.height - height/2
                            }
                        }
                    }
                }

            }

            //brzina
            Rectangle {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredWidth: 2

                Layout.topMargin: 20
                Layout.bottomMargin: 20



                radius: height / 4
                border.width: 10
                border.color: "white"
                color: "black"

                Text {
                    id: speedID
                    text: signalHandler.speed
                    anchors.centerIn: parent
                    color: "white"
                    font.pixelSize: parent.height * 0.5
                    font.bold: true
                }
            }

            //SoP
            Item {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredWidth: 1

                RowLayout{
                    spacing: 30
                    Item {
                        id: aPercent
                        width: 120
                        height: 250
                        property real value: 0.65

                        Row {
                            anchors.fill: parent
                            spacing: 10

                            // --- SCALE ---
                            Item {
                                width: 60
                                height: parent.height

                                Repeater {
                                    model: 6

                                    Text {
                                        text: 50 + (index * 10)
                                        color: "white"
                                        font.pixelSize: 32
                                        font.bold: true
                                        width : 60
                                        horizontalAlignment: Text.AlignRight
                                        y: parent.height - (index / 5) * parent.height - height/2
                                    }
                                }
                            }
                            Item {
                                width: 50
                                height: parent.height

                                Rectangle {
                                    anchors.fill: parent
                                    color: "#222"
                                    radius: 8
                                }
                                Rectangle {
                                    width: parent.width
                                    height: parent.height * (signalHandler - 50)/50//dodat vrijednost
                                    anchors.bottom: parent.bottom
                                    color: "green"
                                    radius: 8
                                }
                            }


                        }
                    }
                    Item {
                        id: bPercent
                        width: 120
                        height: 250
                        property real value: 0.65

                        Row {
                            anchors.fill: parent
                            spacing: 10

                            Item {
                                width: 50
                                height: parent.height

                                Rectangle {
                                    anchors.fill: parent
                                    color: "#222"
                                    radius: 8
                                }
                                Rectangle {
                                    width: parent.width
                                    height: parent.height * bPercent.value
                                    anchors.bottom: parent.bottom
                                    color: "green"
                                    radius: 8
                                }
                            }


                        }
                    }
                }
            }
        }
    }

    Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true

        Layout.preferredHeight: 1
        color: "black"
    }
}
