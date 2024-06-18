import QtQuick 2.12
//import QtQuick.Controls 2.15
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.15
import QtQuick.Controls.Styles 1.4

Item{
    width: 800
    height: 480
    Rectangle {
        color: "#212126"
        anchors.fill: parent
    }
    ColumnLayout{
        width: parent.width
        Layout.alignment: Qt.AlignTop
        Item{height: 100}
        RowLayout{
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: 55
            Rectangle {
                color: "#555555"
                anchors.fill: parent
            }
            Text{
                Layout.leftMargin: 130
                text: "用户名"
                color: "white"
                Layout.preferredHeight: 25
                Layout.preferredWidth: 110
                Layout.alignment: Qt.AlignHCenter

            }
            TextField {
                text: "10"
                id: id
                Layout.preferredHeight: 25
                Layout.preferredWidth: 360
                Layout.alignment: Qt.AlignLeft
            }
        }
        RowLayout{
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: 55
            Rectangle {
                color: "#555555"
                anchors.fill: parent
            }
            spacing: 10

            Text{
                Layout.leftMargin: 130
                text: "密码"
                color: "white"
                Layout.preferredHeight: 25
                Layout.preferredWidth: 110
                Layout.alignment: Qt.AlignHCenter
            }
            TextField {
                text: "10"
                id: password
                Layout.preferredHeight: 25
                Layout.preferredWidth: 360
                Layout.alignment: Qt.AlignLeft
            }
        }
        Item{height: 100}
        RowLayout {
            spacing: 10
            Layout.preferredHeight: 45
            Layout.alignment: Qt.AlignHCenter
            Button{
                Layout.leftMargin: 30
                text: "登陆"
                Layout.preferredHeight: 32
                Layout.preferredWidth: 120
                Layout.alignment: Qt.AlignHCenter
                style: ButtonStyle{
                    background: Rectangle{
                        implicitWidth: 100
                        implicitHeight: 40
                        radius: 9
                        color: control.pressed ? "#ffffff" : "#81d3f8"
                        border.color: "#797979"
                        border.width: 3
                    }
                }
            }
            Item {

                width: 100
            }
            Button {
                text: "注册"
                Layout.preferredHeight: 32
                Layout.preferredWidth: 120
                Layout.alignment: Qt.AlignHCenter
                style: ButtonStyle{
                    background: Rectangle{
                        implicitWidth: 100
                        implicitHeight: 40
                        radius: 9
                        color: control.pressed ? "#ffffff" : "#81d3f8"
                        border.color: "#797979"
                        border.width: 3
                    }
                }
            }
        }
    }
}
