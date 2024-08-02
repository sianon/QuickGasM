import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Popup {
    id: restoreMsgBox

    property string title: "是否确定格式化TF卡？"

    visible: true
    width: 350
    height: 220
    //    padding: 0
    anchors.centerIn: parent

    Rectangle {
        anchors.fill: parent
        color: "#f2f2f2"
    }

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
                text: "取消"
                width: 80
                onClicked: {
                    restoreMsgBox.close();
                    var component = Qt.createComponent("noticebox.qml");
                    var dlg = component.createObject(mainWindow);
                    dlg.title = "TF格式化失败！\n请重试";
                    dlg.show();
                }

                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 40
                    radius: 20
                    border.width: 4
                    border.color: "#797979"
                    opacity: enabled ? 1 : 0.3
                    color: "#ffffff"
                }

            }

            Item {
                width: 40
                height: 20
            }

            RoundButton {
                text: "确定"
                width: 80
                onClicked: {
                    restoreMsgBox.close();
                    var component = Qt.createComponent("noticebox_succeed.qml");
                    var dlg = component.createObject(mainWindow);
                    dlg.title = "TF格式化成功！";
                    dlg.show();
                }

                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 40
                    radius: 20
                    opacity: enabled ? 1 : 0.3
                    color: "#169bd5"
                }

            }

        }

    }

}
