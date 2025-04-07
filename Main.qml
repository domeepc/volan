import QtQuick
import volan


Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Volan prototype")
    color: "#000000"

    Back{
        id: backend
    }



    Rectangle {
        id: rectangle1
        x: 8
        y: 8
        width: 250
        height: 464
        color: "#ed333b"
        radius: 10
    }

    Rectangle {
        id: rectangle2
        x: 18
        y: 20
        width: 227
        height: 442
        color: "#000000"
        radius: 10
    }

    Rectangle {
        id: rectangle3
        x: 275
        y: 8
        width: 250
        height: 230
        color: "#f0ff00"
        radius: 10
    }

    Rectangle {
        id: battery_percent
        x: 285
        y: 20
        width: 227
        height: 207
        color: "#000000"
        radius: 10
        Text {
            id: battery_p_text
            x: 15
            y: 57
            width: 204
            height: 93
            color: "#ffffff"

            font.pixelSize: 75
            horizontalAlignment: Text.AlignHCenter;
            verticalAlignment: Text.AlignVCenter;

            Connections{
                target: backend
                function onFrameBatPercReceived(bat_perc_val){ battery_p_text.text = bat_perc_val + "%"}
            }
        }
    }

    Rectangle {
        id: rectangle5
        x: 275
        y: 243
        width: 250
        height: 230
        color: "#f0ff00"
        radius: 10
    }

    Rectangle {
        id: rectangle6
        x: 285
        y: 255
        width: 227
        height: 207
        color: "#000000"
        radius: 10
    }

    Rectangle {
        id: rectangle7
        x: 542
        y: 8
        width: 250
        height: 152
        color: "#3a54c0"
        radius: 10
    }

    Rectangle {
        id: rectangle8
        x: 552
        y: 20
        width: 227
        height: 130
        color: "#000000"
        radius: 10
    }

    Rectangle {
        id: rectangle9
        x: 544
        y: 173
        width: 250
        height: 299
        color: "#3a54c0"
        radius: 10
    }

    Rectangle {
        id: rectangle10
        x: 554
        y: 185
        width: 227
        height: 277
        color: "#000000"
        radius: 10
    }

    Text {
        id: bat_temp
        x: 346
        y: 312
        width: 134
        height: 93
        Text {
            id: battery_temp_text
            x: 15
            y: 57
            width: 204
            height: 93
            color: "#ffffff"

            font.pixelSize: 75
            horizontalAlignment: Text.AlignHCenter;
            verticalAlignment: Text.AlignVCenter;

            Connections{
                target: backend
                function onFrameBatTempReceived(bat_temp_val){ battery_temp_text.text = bat_temp_val + "°C"}
            }
        }
    }

    Text {
        id: speed
        x: 623
        y: 42
        width: 215
        height: 84
        color: "#ffffff"

        Text {
            id: speed_val_text
            x: 15
            y: 57
            width: 204
            height: 93
            color: "#ffffff"

            font.pixelSize: 75
            horizontalAlignment: Text.AlignHCenter;
            verticalAlignment: Text.AlignVCenter;

            Connections{
                target: backend
                function onFrameSpeedReceived(speed_val){ speed_val_text.text = speed_val + "kph"}
            }
        }
    }
}


