import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


ColumnLayout {
    anchors.fill: parent
    spacing: 10

    Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredHeight: 1
        color: "black"

        RowLayout {
            anchors.fill: parent

            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Text {
                    anchors.fill: parent
                    text: "ECU<xxx>"
                    color: "white"
                    font.bold: true
                    font.pixelSize: parent.height * 0.4
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Text {
                    anchors.fill: parent
                    text: "TYPE<xxx>"
                    color: "white"
                    font.bold: true
                    font.pixelSize: parent.height * 0.4
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Text {
                    anchors.fill: parent
                    text: "LVL<xxx>"
                    color: "white"
                    font.bold: true
                    font.pixelSize: parent.height * 0.4
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }
    }


    RowLayout {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredHeight: 5
        spacing: 10

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 2
            color: "black"
            ListModel{
                id: errorModel
                ListElement {
                    errorname: "overcharge"
                    errornumber: "555"
                }
                ListElement {
                    errorname: "fire"
                    errornumber: "26"
                }
                ListElement {
                    errorname: "Sam Wise the goat"
                    errornumber: "1"
                }
            }
            Component{
                id: errorDelegate
                Item{
                    id:myItem
                    required property int errornumber
                    required property string errorname
                    Row{
                        spacing: 5
                        Text {
                            text: myItem.errornumber
                            color: "white"
                        }
                        Text {
                            text: myItem.errorname
                            color: "white"
                        }
                    }
                }
            }
            ListView{
                anchors.fill: parent

                model: errorModel
                delegate: errorDelegate
                highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
                focus: true
            }

        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 1
            color: "black"
        }
    }
}
