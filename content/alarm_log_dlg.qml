import QtQuick 2.2
import QtQuick.Controls 2.15
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.2
import QtQuick.Controls.Styles 1.4

Item{
        id: alarmLogDlg
    //    modal: true
    width: 800
    //        marginLeft: 10
    Rectangle {
        color: "#212126"
        anchors.fill: parent
    }
    ColumnLayout{
        anchors.fill: parent

        RowLayout{
            height: 52
            Layout.preferredWidth: parent.width
            Rectangle {
                color: "#555555"
                anchors.fill: parent
            }
            TabBar{
                TabButton{
                    text: "最近1天"
                }
                TabButton{
                    text: "最近3天"
                }
                TabButton{
                    text: "最近5天"
                }
                TabButton{
                    text: "最近7天"
                }
            }
            TextField{
                text: "2020-01-01"
                Layout.preferredWidth: 93
            }
            TextField{
                text: "2020-01-01"
                Layout.preferredWidth: 93
            }
            RoundButton{
                text: "查询"
                Layout.preferredWidth: 80
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 30
                    radius: 20
                    opacity: enabled ? 1 : 0.3
                    color: "#02a7f0"
                }

                onClicked: {
                    var component = Qt.createComponent("noticebox.qml");
                    var dlg = component.createObject(alarmLogDlg);
                    if(dlg == null) {
                        console.log("Failed to create component");
                        return;
                    }
                    dlg.title = "结束时间应大于开始时间"
                    dlg.show();
                }
            }
            RoundButton{
                text: "重置"
                Layout.preferredWidth: 80
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 30
                    radius: 20
                    opacity: enabled ? 1 : 0.3
                    color: "#aaaaaa"
                }

                onClicked: {
                }
            }
        }
        StackView {
            Layout.preferredWidth: parent.width - 40
            Layout.preferredHeight: 310
            Layout.leftMargin: 20
            ListView{
                Rectangle {
                    color: "#414141"
                    anchors.fill: parent
                }
                model: pageModelsys
                anchors.fill: parent
                delegate: AndroidDelegate{
                    text: title
                }
            }
        }
        RowLayout{
            Layout.leftMargin: 10
            CheckBox{
                text: "全选"
                checked: true
                style: CheckBoxStyle {
                    label: Text {
                        text: control.text
                        color: "#ffffff"
                        font.bold: true
                    }
                }
            }
            Button{
                Layout.alignment: Qt.AlignRight
                text: "删除"
                onClicked:{
                    var component = Qt.createComponent("messagebox.qml");
                    var dlg = component.createObject(alarmLogDlg);
                    dlg.title = "确定删除报警记录？"
                    dlg.show();
                }
            }
            Button{
                Layout.alignment: Qt.AlignRight
                text: "上传"
                onClicked:{
                    var component = Qt.createComponent("noticebox.qml");
                    var dlg = component.createObject(alarmLogDlg);
                    dlg.title = "上传成功"
                    dlg.isvisible = false
                    dlg.show();
                }
            }
            Button{
                Layout.alignment: Qt.AlignRight
                text: "蓝牙传输"
                onClicked:{
                    var component = Qt.createComponent("messagebox.qml");
                    var dlg = component.createObject(alarmLogDlg);
                    dlg.title = "检测到已配对设备："+ "xxxx" + "\n是否将文件传输到该设备"
                    dlg.show();
                }
            }
            Item{
                width: 320
            }
            Label{
                Layout.alignment: Qt.AlignRight
                color: "#ffffff"
                font.bold: true
                text: "共50条"
            }
        }
    }
}
