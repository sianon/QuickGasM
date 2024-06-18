import QtQuick 2.2
import QtQuick.Controls 2.15

Switch {
//    id: appleStyleSwitch
    text: "开关"
//    Layout.preferredHeight: 25
//    onClicked: {
//
//    }

    indicator: Rectangle {
        implicitWidth: 48
        implicitHeight: 22
        x: parent.leftPadding
        y: parent.height / 2 - height / 2
        radius: 13
        color: parent.checked ? "#0079fe" : "#ffffff"
        border.color: parent.checked ? "#0079fe" : "#cccccc"

        Rectangle {
            x: parent.parent.checked ? parent.width - width : 0
            width: 26
            height: 22
            radius: 13
            color: parent.parent.down ? "#cccccc" : "#ffffff"
            border.color: parent.parent.checked ? (parent.parent.down ? "#0079fe" : "#0079fe") : "#999999"
        }
    }

//    contentItem: Text {
//        visible: false
//        text: control.text
//        font: control.font
//        opacity: enabled ? 1.0 : 0.3
//        color: control.down ? "#17a81a" : "#21be2b"
//        verticalAlignment: Text.AlignVCenter
//        leftPadding: control.indicator.width + control.spacing
//    }
}