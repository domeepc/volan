import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root
    color: "black"
    border.color: "#333"

    property string title: ""
    property var values: []
    property int flowDirection: Qt.Horizontal
    //property double titleHeightPercent: value

    readonly property bool hasTitle: title !== ""

    Loader {
        anchors.fill: parent
        sourceComponent: flowDirection === Qt.Horizontal ? horizontalLayout : verticalLayout
    }

    // TITLE LEFT, VALUES RIGHT
    Component {
        id: horizontalLayout

        RowLayout {
            anchors.fill: parent
            spacing: 0
            anchors.margins: 10

            Text {
                visible: root.hasTitle
                text: root.title
                color: "white"
                font.bold: true

                Layout.alignment: Qt.AlignVCenter

                Layout.preferredWidth: root.hasTitle ? parent.width * 0.35 : 0

                font.pixelSize: Math.max(root.height * 0.45, 18)

                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
            }

            RowLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: 12

                Repeater {
                    model: root.values

                    Text {
                        text: modelData
                        color: "white"
                        font.bold: true

                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                        font.pixelSize: Math.max(root.height * 0.45, 26)
                    }
                }
            }
        }
    }

    // TITLE TOP, VALUES BELOW
    Component {
        id: verticalLayout

        ColumnLayout {
            anchors.fill: parent
            spacing: 6

            Text {
                visible: root.hasTitle
                text: root.title
                color: "white"
                font.bold: true

                Layout.fillWidth: true

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                font.pixelSize: Math.max(root.height * 0.25, 16)
            }

            RowLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: 12

                Repeater {
                    model: root.values

                    Text {
                        text: modelData
                        color: "white"
                        font.bold: true

                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                        font.pixelSize: Math.max(root.height * 0.42, 24)
                    }
                }
            }
        }
    }
}
