import QtQuick
import QtQuick.Layouts
import volan

Window {
    id: window_ID
    width: Screen.width
    height: Screen.height
    visibility: Window.FullScreen
    visible: true
    title: qsTr("Volan prototype")
    color: "#000000"

    transform: Rotation {
            origin.x: parent.width/2
            origin.y: parent.height/2
            angle: 90   // clockwise
        }

    Back {
        id: backend
    }

    RowLayout {
        id: row
        anchors.fill: parent
        spacing: 3

        //left column
        ColumnLayout {
            spacing: 3
            Layout.fillWidth: true

            Rectangle {
                id: error_box
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "transparent"
                radius: 10
                border.color: "#ed333b"
                border.width: 13


                Item {
                    anchors.fill: parent
                    anchors.margins: 16

                    ListView {
                        id: listView
                        anchors.fill: parent
                        spacing: 10
                        onCountChanged: {
                            listView.positionViewAtEnd()
                        }

                        model: ListModel {id: list_model}
                           delegate: Row {
                            width: parent.width
                                Text {
                                    width: parent.width
                                    text: name
                                    color: "#ffffff"
                                    wrapMode: Text.Wrap
                                    padding: 10
                                }

                            }

                           Connections{
                            target: backend
                            function onFrameError(err_msg){
                                list_model.append({name: err_msg})
                            }
                           }
                    }
                }
            }

        }

        //middle column
        ColumnLayout {
            spacing: 3
            Layout.fillWidth: true

            Rectangle {
                id: battery_perc
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "transparent"
                border.color: "#f0ff00"
                border.width: 13
                radius: 10

                Text {
                    id: battery_p_text
                    anchors.fill: parent
                    color: "#ffffff"
                    font.pixelSize: 65
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    Connections {
                        target: backend
                        function onFrameBatPercReceived(val) {
                            battery_p_text.text = val + "%"
                        }
                    }
                }
            }

            Rectangle {
                id: rectangle5
                Layout.fillWidth: true
                Layout.fillHeight: true
                border.color: "#f0ff00"
                color: "transparent"
                border.width: 13
                radius: 10

                Text {
                    id: battery_temp_text
                    anchors.fill: parent
                    color: "#ffffff"
                    font.pixelSize: 65
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    Connections {
                        target: backend
                        function onFrameBatTempReceived(val) {
                            battery_temp_text.text = val + "°C"
                        }
                    }
                }
            }
        }

        //right column
        ColumnLayout {
            spacing: 3
            Layout.fillWidth: true

            Rectangle {
                id: speed
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "transparent"
                border.color: "#3a54c0"
                border.width: 13
                radius: 10

                Text {
                    id: speed_val_text
                    anchors.fill: parent
                    color: "#ffffff"
                    font.pixelSize: 65
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    Connections {
                        target: backend
                        function onFrameSpeedReceived(val) {
                            speed_val_text.text = val + "kph"
                        }
                    }
                }
            }

            Rectangle {
                id: rec
                Layout.fillWidth: true
                Layout.fillHeight: true
                border.color: "#3a54c0"
                color: "transparent"
                border.width: 13
                radius: 10
            }
        }
    }


}

