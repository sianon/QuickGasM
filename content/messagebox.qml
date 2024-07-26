import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Popup {
    id: messageBox
    visible: true
    width: 350
    height: 220
    anchors.centerIn: parent
    padding: 0
    Rectangle {
        anchors.fill: parent
        color: "#f2f2f2"
    }
    property string title: "确定删除？"
    ColumnLayout {
        anchors.centerIn: parent
        spacing: 10

        Text {
            text: title
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10

            RoundButton {
                text: "确定"
                width: 80
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 40
                    radius: 20
                    opacity: enabled ? 1 : 0.3
                    color: "red"
                }
                onClicked: messageBox.visible = false
            }
            Item {
                width: 40
                height: 20
            }
            RoundButton {
                text: "取消"
                width: 80
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 40
                    radius: 20
                    opacity: enabled ? 1 : 0.3
                    color: "#aaaaaa"
                }
                onClicked: messageBox.visible = false
            }
        }
    }
}
