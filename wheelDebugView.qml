import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root
    anchors.fill: parent

    readonly property int indicatorCount: 17
    readonly property int buttonCount: 6
    readonly property int segmentCount: 6
    property int leftSelectedIndex: -1
    property int rightSelectedIndex: -1

    readonly property color bgColor: "#2b2b2b"
    readonly property color fillColor: "#000000"
    readonly property color strokeColor: "#ffffff"
    readonly property color accentStrokeColor: "#2da6ff"
    readonly property color iconFillColor: "#d9d9d9"

    Rectangle {
        anchors.fill: parent
        color: root.bgColor
    }

    ColumnLayout {
        id: content
        anchors.fill: parent
        anchors.margins: 24
        spacing: 18

        Text {
            text: "Debug View"
            color: "#7a7a7a"
            font.pixelSize: 18
            Layout.fillWidth: true
        }

        // Top indicator boxes
        RowLayout {
            id: indicatorRow
            Layout.fillWidth: true
            Layout.preferredHeight: Math.max(root.height * 0.16, 70)
            spacing: 12

            Repeater {
                model: root.indicatorCount

                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: root.fillColor
                    border.color: root.strokeColor
                    border.width: 4
                    radius: 10
                }
            }
        }

        // Button states (2x3)
        GridLayout {
            id: buttonGrid
            Layout.fillWidth: true
            Layout.preferredHeight: Math.max(root.height * 0.26, 150)
            columns: 3

            readonly property int borderW: 4

            columnSpacing: -borderW
            rowSpacing: -borderW

            Repeater {
                model: root.buttonCount

                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: root.fillColor
                    border.color: root.strokeColor
                    border.width: buttonGrid.borderW
                    radius: 10

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 18
                        spacing: Math.max(parent.width * 0.05, 10)

                        Text {
                            text: "BTN" + (index + 1)
                            color: root.strokeColor
                            font.bold: true
                            fontSizeMode: Text.Fit
                            minimumPixelSize: 12
                            font.pixelSize: 80
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            wrapMode: Text.NoWrap
                        }

                        Text {
                            text: "HIGH"
                            color: root.strokeColor
                            font.bold: true
                            fontSizeMode: Text.Fit
                            minimumPixelSize: 12
                            font.pixelSize: 80
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            wrapMode: Text.NoWrap
                        }
                    }
                }
            }
        }

        // Wheel + arrows box (with blue highlight + white outline)
        Rectangle {
            id: wheelBoxOuter
            Layout.fillWidth: true
            Layout.preferredHeight: Math.min(Math.max(root.height * 0.45, 125), 450)
            color: "transparent"
            border.width: 4
            radius: 10

            Rectangle {
                id: wheelBoxInner
                anchors.fill: parent
                anchors.margins: 2
                color: root.fillColor
                border.color: root.strokeColor
                border.width: 4
                radius: 8

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 30
                    spacing: 30

                    // Left wheel
                    Item {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.horizontalStretchFactor: 3

                        Item {
                            id: leftWheel
                            anchors.centerIn: parent
                            width: Math.min(parent.width, parent.height)
                            height: width

                            property int selectedIndex: root.leftSelectedIndex

                            Canvas {
                                id: leftCanvas
                                anchors.fill: parent
                                antialiasing: true

                                onWidthChanged: requestPaint()
                                onHeightChanged: requestPaint()

                                onPaint: root.drawWheel(getContext("2d"), width, height, root.segmentCount, leftWheel.selectedIndex)
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: function(mouse) {
                                    var dx = mouse.x - width / 2
                                    var dy = mouse.y - height / 2
                                    var angle = Math.atan2(dy, dx) + Math.PI / 2
                                    if (angle < 0)
                                        angle += 2 * Math.PI

                                    var idx = Math.floor(angle / (2 * Math.PI / root.segmentCount))
                                    root.leftSelectedIndex = idx
                                    leftCanvas.requestPaint()
                                    rightCanvas.requestPaint()
                                }
                            }
                        }
                    }

                    // Center arrows / bar
                    Item {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.horizontalStretchFactor: 4
                        Canvas {
                            anchors.fill: parent
                            antialiasing: true
                            onWidthChanged: requestPaint()
                            onHeightChanged: requestPaint()

                            onPaint: {
                                var ctx = getContext("2d")
                                ctx.reset()

	                                var h = Math.min(height * 0.32, 120)
	                                var rectW = Math.min(width * 0.56, width - 40)
	                                var triW = Math.min(width * 0.12, 60)
	                                var gap = Math.min(width * 0.035, 18)

                                var centerX = width / 2
                                var centerY = height / 2

                                var rectX = centerX - rectW / 2
                                var rectY = centerY - h / 2

                                ctx.fillStyle = root.iconFillColor

                                // center rectangle
                                ctx.beginPath()
                                ctx.rect(rectX, rectY, rectW, h)
                                ctx.closePath()
                                ctx.fill()

	                                // left triangle
	                                ctx.beginPath()
	                                ctx.moveTo(rectX - gap - triW, centerY)
	                                ctx.lineTo(rectX - gap, rectY)
	                                ctx.lineTo(rectX - gap, rectY + h)
	                                ctx.closePath()
	                                ctx.fill()

	                                // right triangle
	                                ctx.beginPath()
	                                ctx.moveTo(rectX + rectW + gap + triW, centerY)
	                                ctx.lineTo(rectX + rectW + gap, rectY)
	                                ctx.lineTo(rectX + rectW + gap, rectY + h)
	                                ctx.closePath()
	                                ctx.fill()
                            }
                        }
                    }

                    // Right wheel
                    Item {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.horizontalStretchFactor: 3

                        Item {
                            id: rightWheel
                            anchors.centerIn: parent
                            width: Math.min(parent.width, parent.height)
                            height: width

                            property int selectedIndex: root.rightSelectedIndex

                            Canvas {
                                id: rightCanvas
                                anchors.fill: parent
                                antialiasing: true

                                onWidthChanged: requestPaint()
                                onHeightChanged: requestPaint()

                                onPaint: root.drawWheel(getContext("2d"), width, height, root.segmentCount, rightWheel.selectedIndex)
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: function(mouse) {
                                    var dx = mouse.x - width / 2
                                    var dy = mouse.y - height / 2
                                    var angle = Math.atan2(dy, dx) + Math.PI / 2
                                    if (angle < 0)
                                        angle += 2 * Math.PI

                                    var idx = Math.floor(angle / (2 * Math.PI / root.segmentCount))
                                    root.rightSelectedIndex = idx
                                    rightCanvas.requestPaint()
                                    leftCanvas.requestPaint()
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    function drawWheel(ctx, w, h, segmentCount, selectedIndex) {
        ctx.reset()

        var size = Math.min(w, h)
        var cx = w / 2
        var cy = h / 2

        segmentCount = Math.max(1, segmentCount | 0)
        selectedIndex = selectedIndex | 0
        if (selectedIndex < 0 || selectedIndex >= segmentCount)
            selectedIndex = -1

        var outerRadius = size * 0.46
        var innerRadius = size * 0.26
        var hubRadius = size * 0.18

        var angleStep = 2 * Math.PI / segmentCount

        // segments
        for (var i = 0; i < segmentCount; i++) {
            var start = i * angleStep - Math.PI / 2
            var end = start + angleStep

            ctx.beginPath()
            ctx.arc(cx, cy, outerRadius, start, end, false)
            ctx.arc(cx, cy, innerRadius, end, start, true)
            ctx.closePath()
            ctx.fillStyle = i === selectedIndex ? "#f90404" : root.iconFillColor
            ctx.fill()
        }

        // separators
        ctx.strokeStyle = "#000000"
        ctx.lineWidth = Math.max(size * 0.035, 6)
        for (var j = 0; j < segmentCount; j++) {
            var a = j * angleStep - Math.PI / 2
            ctx.beginPath()
            ctx.moveTo(cx + innerRadius * Math.cos(a), cy + innerRadius * Math.sin(a))
            ctx.lineTo(cx + outerRadius * Math.cos(a), cy + outerRadius * Math.sin(a))
            ctx.stroke()
        }

        // outer rim
        ctx.beginPath()
        ctx.arc(cx, cy, outerRadius, 0, 2 * Math.PI)
        ctx.strokeStyle = "#000000"
        ctx.lineWidth = Math.max(size * 0.03, 6)
        ctx.stroke()

        // thick inner ring
        ctx.beginPath()
        ctx.arc(cx, cy, innerRadius, 0, 2 * Math.PI)
        ctx.strokeStyle = "#000000"
        ctx.lineWidth = Math.max(size * 0.08, 14)
        ctx.stroke()

        // hub
        ctx.beginPath()
        ctx.arc(cx, cy, hubRadius, 0, 2 * Math.PI)
        ctx.fillStyle = root.iconFillColor
        ctx.fill()
    }
}
