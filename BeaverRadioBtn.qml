import QtQuick 2.15
//import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

RadioButton{
    width: 80
    height: 10
    contentItem: Text{
        rightPadding: parent.indicator.width + parent.spacing
        text: parent.text
        font: parent.font
        opacity: enabled ? 1.0 : 0.3
        color: parent.down ? "#17a81a" : "#21be2b"
        elide: Text.ElideRight
        verticalAlignment: Text.AlignVCenter
    }

    indicator: Rectangle{
        implicitWidth: 26
        implicitHeight: 26
        x: parent.width - width - parent.rightPadding
        y: parent.height / 2 - height / 2
        radius: 13
        color: "transparent"
        border.color: parent.down ? "#17a81a" : "#21be2b"

        Rectangle{
            width: 14
            height: 14
            x: 6
            y: 6
            radius: 7
            color: parent.down ? "#17a81a" : "#21be2b"
            visible: parent.checked
        }
    }

    background: Rectangle{
        implicitWidth: 100
        implicitHeight: 40
        visible: parent.down || parent.highlighted
        color: parent.down ? "#bdbebf" : "#eeeeee"
    }
}
