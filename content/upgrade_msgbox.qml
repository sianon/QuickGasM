import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Popup {
    id: upgradeMsgBox

    property string title: "搜索到升级文件包\n" + "是否进行升级？"

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
                    upgradeMsgBox.close();

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
                text: "开始升级"
                width: 80
                onClicked: {
                    upgradeMsgBox.close();
                    var res_search = providers.mbSearchUpgradeFile();
                    if(res_search){
                        var component = Qt.createComponent("noticebox_succeed.qml");
                        var dlg = component.createObject(mainWindow);
                        dlg.title = "升级成功！";
                    }else{
                        var component = Qt.createComponent("noticebox.qml");
                        var dlg = component.createObject(mainWindow);
                        dlg.title = "升级失败，请重新升级！";
                    }
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
