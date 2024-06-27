import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: upgradeMsgBox
    visible: true
    width: 350
    height: 220
//    padding: 0
    anchors.centerIn: parent
    Rectangle {
        anchors.fill: parent
        color: "#f2f2f2"
    }
    property string title: "搜索到升级文件包\n" + "是否进行升级？"
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
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 40
                    radius: 20
                    border.width: 4
                    border.color: "#797979"
                    opacity: enabled ? 1 : 0.3
                    color: "#ffffff"
                }
                onClicked: upgradeMsgBox.visible = false
            }
            Item {
                width: 40
                height: 20
            }
            RoundButton {
                text: "开始升级"
                width: 80
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 40
                    radius: 20
                    opacity: enabled ? 1 : 0.3
                    color: "#169bd5"
                }
                onClicked: {
                    var component = Qt.createComponent("noticebox.qml");
                    var dlg = component.createObject(sysUpgradeDlg);
                    dlg.title = "升级失败，请重新升级！"
                    dlg.show();
                    messageBox.close();
                }
            }
        }
    }
}
