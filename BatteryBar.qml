import QtQuick
import QtQuick.Layouts

Item {
    id: root

    property real value: 50
    property real minimumValue: 50
    property real maximumValue: 100
    property string label: ""

    Layout.fillHeight: true
    Layout.preferredWidth: 120
    Layout.topMargin: 30
    Layout.bottomMargin: 30

    Row {
        anchors.fill: parent
        spacing: 5
        Rectangle {
            id: barBackground
            width: 60
            height: parent.height
            radius: 10
            color: "#1a1a1a"
            border.color: "#ffffff"
            border.width: 5

            Rectangle {
                width: parent.width

                property real normalized:
                    Math.max(0, Math.min(1,
                        (root.value - root.minimumValue) /
                        (root.maximumValue - root.minimumValue)
                    ))

                height: parent.height * normalized
                anchors.bottom: parent.bottom
                radius: 10
                color: value > 60 ? "limegreen" : "red"

                Behavior on height {
                    NumberAnimation { duration: 300 }
                }
            }
        }

        // 📏 Scale
        Item {
            width: 50
            height: parent.height

            Repeater {
                model: 6   // 50,60,70,80,90,100

                delegate: Item {
                    width: parent.width
                    height: 1

                    property int stepValue:
                        root.minimumValue +
                        (index * (root.maximumValue - root.minimumValue) / 5)

                    y: parent.height
                       - (index / 5) * parent.height

                    // Show text only for 50 and 100
                    Text {
                        visible: stepValue === 50 || stepValue === 100
                        text: stepValue
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        color: "white"
                        font.pixelSize: 25
                        font.bold: true
                    }

                    // Show tick line for middle values
                    Rectangle {
                        visible: stepValue !== 50 && stepValue !== 100
                        width: 20
                        height: 10
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        color: "#ffffff"
                    }
                }
            }
        }
    }
}
