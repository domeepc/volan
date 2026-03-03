import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import volan

Window {
    id: window_ID
    width: 853
    height: 479
    visible: true

    Rectangle{
        anchors.fill: parent
        color: "white"
        StackView{
            id: stackView
            anchors.fill: parent
            initialItem: "errorView.qml"
        }
    }
}

