import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ColumnLayout{
    anchors.fill: parent
    spacing: 5
    RowLayout{
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.preferredHeight: 1

        spacing: 5
        Repeater {
            model: 17
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "black"

                Text {
                    text: index + 1
                    anchors.centerIn: parent
                    color: "white"
                    font.pixelSize: parent.height * 0.5
                    font.bold: true
                }
            }
        }
    }
    GridLayout{
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.preferredHeight: 3

        columnSpacing: 5
        rowSpacing: 5
        columns: 3
        Repeater{
            model: 6
            Rectangle{
                Layout.fillHeight: true
                Layout.fillWidth: true
                color: "black"

                Text {
                    anchors.centerIn: parent
                    text:"button" + (index + 1)
                    color: "white"
                    font.pixelSize: parent.height * 0.5
                    font.bold: true
                }
            }
        }
    }
    RowLayout{
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.preferredHeight: 4
        spacing: 0

        Rectangle{
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.preferredWidth: 1
            color: "black"
        }
        Rectangle{
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.preferredWidth: 1
            color: "purple"
        }
        Rectangle{
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.preferredWidth: 1
            color: "black"

            //kolo
            Item {
                id: root
                anchors.fill: parent
                anchors.margins: 10

                property int segmentCount: 8
                property int selectedIndex: dial.value

                Dial {
                    id: dial
                    anchors.fill: parent
                    from: 0
                    to: root.segmentCount - 1
                    stepSize: 1
                    snapMode: Dial.SnapAlways
                    wrap: true
                    visible: false

                    onValueChanged: canvas.requestPaint()
                }

                Canvas {
                    id: canvas
                    anchors.fill: parent

                    onPaint: {
                        var ctx = getContext("2d")
                        ctx.reset()

                        var center = height / 2
                        var outerRadius = height / 2.5
                        var innerRadius = height / 4
                        var angleStep = 2 * Math.PI / root.segmentCount

                        for (var i = 0; i < root.segmentCount; i++) {
                            var start = i * angleStep - Math.PI/2
                            var end = start + angleStep

                            ctx.beginPath()
                            ctx.arc(center, center, outerRadius, start, end)
                            ctx.arc(center, center, innerRadius, end, start, true)
                            ctx.closePath()

                            ctx.fillStyle = (i === root.selectedIndex)
                                            ? "#f90404"
                                            : "#ffffff"

                            ctx.fill()
                        }

                        // inner hub
                        ctx.beginPath()
                        ctx.arc(center, center, innerRadius - 10, 0, 2*Math.PI)
                        ctx.fillStyle = "#000000"
                        ctx.fill()
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        var dx = mouse.x - width/2
                        var dy = mouse.y - height/2
                        var angle = Math.atan2(dy, dx) + Math.PI/2
                        if (angle < 0) angle += 2*Math.PI

                        var index = Math.floor(angle / (2*Math.PI / root.segmentCount))
                        dial.value = index
                    }
                }
            }
        }
    }
}
