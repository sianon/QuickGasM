import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Popup {
    id: messageBox
    visible: true
    width: 350
    height: 220
    padding: 0
    anchors.centerIn: parent
    Rectangle {
        anchors.fill: parent
        color: "#f2f2f2"
    }
    property string title: "提示！"
    property bool isvisible: true
    ColumnLayout {
        anchors.centerIn: parent
        spacing: 10

        Text {
            text: title
            wrapMode: Text.Wrap
            Layout.alignment: Qt.AlignHCenter
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10
            visible: isvisible
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
        }
    }
}
