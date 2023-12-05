import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15


Dialog{
    id: dialog
    modal: true
    width: 200
    height: 150
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    background:Rectangle {
        color: "#1e2129"
    }

    ColumnLayout {
        anchors.fill: parent
        Switch {
            id:control
            checked: true
            text:control.checked ? "WiFI已打开" : "WiFI已关闭"
            onCheckedChanged: {
            }
//            indicator: Rectangle {
//                implicitWidth: 48
//                implicitHeight: 26
//                x: control.leftPadding
//                y: parent.height / 2 - height / 2

//                radius: 13
//                color: control.checked ? "green" : "#ffffff"
//                border.color: control.checked ? "green" : "#cccccc"

//                //小圆点
//                Rectangle {
//                    id : smallRect
//                    width: 26
//                    height: 26
//                    radius: 13
//                    color: control.down ? "#cccccc" : "#ffffff"
//                    border.color: control.checked ? (control.down ? "#17a81a" : "#21be2b") : "#999999"

//                    //改变小圆点的位置
//                    NumberAnimation on x{
//                        to: smallRect.width
//                        running: control.checked ? true : false
//                        duration: 200
//                    }

//                    //改变小圆点的位置
//                    NumberAnimation on x{
//                        to: 0
//                        running: control.checked ? false : true
//                        duration: 200
//                    }
//                }
//            }

//            contentItem: Text {
//                text: control.checked ? "打开" : "关闭"
//                font.pixelSize: 20
//                color: control.checked ? "green" : "red"
//                verticalAlignment: Text.AlignVCenter
//                anchors.left: control.right
//            }
        }
        Switch {
            text: qsTr("Bluetooth")
        }
        Switch {
            checked: true
            text: qsTr("Bluetooth")
        }
        Switch {
            text: qsTr("Bluetooth")
        }
    }
}
