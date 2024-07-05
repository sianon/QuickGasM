import QtQuick 2.2
import QtQuick.Controls 2.15
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.2
import QtQuick.Controls.Styles 1.4

Item{
    id: alarmLogDlg
    width: 800
    Rectangle {
        color: "#212126"
        anchors.fill: parent
    }
    ColumnLayout{
        width: 800
        RowLayout{
            height: 52
            Layout.preferredWidth: parent.width
            Rectangle {
                color: "#555555"
                anchors.fill: parent
            }
            TabBar{
                id: tabBar
                currentIndex: 0
                contentHeight: 26
                background: Rectangle {
                    color: "#555555"
                }
                TabButton{
                    text: "最近1天"
                    background: Rectangle {
                        color: tabBar.currentIndex === 0 ? "#d9001b" : "#353637"
                    }
                }
                TabButton{
                    text: "最近3天"
                    background: Rectangle {
                        color: tabBar.currentIndex === 1 ? "#d9001b" : "#353637"
                    }
                }
                TabButton{
                    text: "最近5天"
                    background: Rectangle {
                        color: tabBar.currentIndex === 2 ? "#d9001b" : "#353637"
                    }
                }
                TabButton{
                    text: "最近7天"
                    background: Rectangle {
                        color: tabBar.currentIndex === 3 ? "#d9001b" : "#353637"
                    }
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
                Layout.preferredHeight: 26
                background: Rectangle {
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
                Layout.preferredHeight: 26
                background: Rectangle {
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
            Layout.preferredHeight: 320
            Layout.leftMargin: 15
            Layout.alignment: Qt.AlignTop
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
        Item{
            width: 20
            height: 20
        }
        RowLayout{
            Layout.leftMargin: 10
            Layout.bottomMargin: 5
            Layout.alignment: Qt.AlignTop
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
            Item{
                width: 30
                height: 20
            }
            Button{
                Layout.alignment: Qt.AlignRight
                Layout.preferredHeight: 22
                Layout.preferredWidth: 22
                style: ButtonStyle{
                    background: Image{
                        anchors.fill: parent
                        source: "../images/delete.png"
                    }
                }
                onClicked:{
                    var component = Qt.createComponent("messagebox.qml");
                    var dlg = component.createObject(alarmLogDlg);
                    dlg.title = "确定删除报警记录？"
                    dlg.show();
                }
            }
            Text{
                text: "删除"
                color: "white"
            }
            Item{
                width: 30
                height: 20
            }
            Button{
                Layout.alignment: Qt.AlignRight
                Layout.preferredHeight: 22
                Layout.preferredWidth: 22
                style: ButtonStyle{
                    background: Image{
                        anchors.fill: parent
                        source: "../images/upload.png"
                    }
                }
                onClicked:{
                    var component = Qt.createComponent("noticebox.qml");
                    var dlg = component.createObject(alarmLogDlg);
                    dlg.title = "上传成功"
                    dlg.isvisible = false
                    dlg.show();
                }
            }
            Text{
                text: "上传"
                color: "white"
            }
            Item{
                width: 30
                height: 20
            }
            Button{
                Layout.alignment: Qt.AlignRight
                Layout.preferredHeight: 22
                Layout.preferredWidth: 22
                style: ButtonStyle{
                    background: Image{
                        anchors.fill: parent
                        source: "../images/bluetooth.png"
                    }
                }
                onClicked:{
                    var component = Qt.createComponent("messagebox.qml");
                    var dlg = component.createObject(alarmLogDlg);
                    dlg.title = "检测到已配对设备："+ "xxxx" + "\n是否将文件传输到该设备"
                    dlg.show();
                }
            }
            Text{
                text: "蓝牙传输"
                color: "white"
            }
            Item{
                width: 330
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
