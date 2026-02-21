import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    anchors.fill: parent
    color: "black"

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        //ikone
        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height * 0.2
            Layout.alignment: Qt.AlignHCenter
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

        //bijela crta
        Rectangle {
            Layout.fillWidth: true
            height: 5
            color: "white"
        }

        //glavni dio
        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.margins: 20
            spacing: 0

            Item {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredWidth: 1

                Item {
                    id: batteryPercent
                    width: 120
                    height: 250
                    //property real value: signalHandler.soc

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
            }

            Rectangle {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredWidth: 2

                radius: 50
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

        // mode i preset
        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height * 0.1

            Rectangle {
                width: 200
                height: parent.height
                anchors.left: parent.left

                border.width: 5
                border.color: "white"
                color: "black"

                Text {
                    text: "MODE"
                    anchors.centerIn: parent
                    color: "white"
                    font.pixelSize: parent.height * 0.8
                    font.bold: true
                }
            }

            Rectangle {
                width: 200
                height: parent.height
                anchors.right: parent.right

                border.width: 5
                border.color: "white"
                color: "black"

                Text {
                    text: "PRESET"
                    anchors.centerIn: parent
                    color: "white"
                    font.pixelSize: parent.height * 0.8
                    font.bold: true
                }
            }
        }
    }
}
