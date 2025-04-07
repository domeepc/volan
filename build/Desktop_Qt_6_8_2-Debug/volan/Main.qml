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
        color: "transparent"
        radius: 10
        border.color: "#ed333b"
        border.width: 13
    }

    Rectangle {
        id: baterry_perc
        x: 275
        y: 8
        width: 250
        color: "transparent"
        height: 230
        border.color: "#f0ff00"
        border.width: 13
        radius: 10

        Text {
            id: battery_p_text
            anchors.fill: parent
            color: "#ffffff"

            font.pixelSize: 65
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
        border.color: "#f0ff00"
        color: "transparent"
        border.width: 13
        radius: 10

        Text {
            id: battery_temp_text
            anchors.fill: parent;
            color: "#ffffff"

            font.pixelSize: 65
            horizontalAlignment: Text.AlignHCenter;
            verticalAlignment: Text.AlignVCenter;

            Connections{
                target: backend
                function onFrameBatTempReceived(bat_temp_val){ battery_temp_text.text = bat_temp_val + "°C"}
            }
        }

    }

    Rectangle {
        id: speed
        x: 542
        y: 8
        width: 250
        height: 152
        color: "transparent"
        border.color: "#3a54c0"
        border.width: 13
        radius: 10

        Text {
            id: speed_val_text
            anchors.fill: parent;
            color: "#ffffff"

            font.pixelSize: 65
            horizontalAlignment: Text.AlignHCenter;
            verticalAlignment: Text.AlignVCenter;

            Connections{
                target: backend
                function onFrameSpeedReceived(speed_val){ speed_val_text.text = speed_val + "kph"}
            }
        }
    }


    Rectangle {
        id: rec
        x: 544
        y: 173
        width: 250
        height: 299
        border.color: "#3a54c0"
        color: "transparent"
        border.width: 13
        radius: 10

    }
}


