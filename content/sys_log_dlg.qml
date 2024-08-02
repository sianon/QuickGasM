import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item{
       width: 800
       height: 400
    Rectangle {
        color: "#333333"
        anchors.fill: parent
    }
    ColumnLayout{
        spacing: 0
        anchors.fill: parent
        RowLayout{
            height: 52
            Layout.preferredWidth: parent.width
            Rectangle {
                color: "#555555"
                anchors.fill: parent
            }
            Text{
                text: "时间"
                color: "white"
            }
            TextField{
                text: "2020-01-01"
                Layout.preferredWidth: 93
            }
            Text{
                text: "操作"
                color: "white"
            }
            ComboBox{
                model: ["开机", "关机", "恢复出厂", "删除报警记录", "升级", "格式化TF卡"]
                Layout.preferredWidth: 145
            }
            Text{
                text: "地点"
                color: "white"
            }
            TextField{
                text: "请输入地点"
                Layout.preferredWidth: 93
            }
            RoundButton {
                text: "查询"
                width: 80
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 25
                    radius: 20
                    opacity: enabled ? 1 : 0.3
                    color: "#02a7f0"
                }
            }
            RoundButton {
                text: "导出"
                width: 80
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 25
                    radius: 20
                    opacity: enabled ? 1 : 0.3
                    color: "red"
                }
            }
        }
        TableView {
            Layout.preferredWidth: parent.width - 40
            Layout.preferredHeight: 290
            Layout.alignment: Qt.AlignTop
            Layout.leftMargin: 20
            Layout.topMargin: 20
            Layout.bottomMargin: 0
            model: tableModel
            TableViewColumn {
                horizontalAlignment: Text.AlignHCenter
                role: "column1"
                title: "序号"
                width: 60
            }
            TableViewColumn {
                horizontalAlignment: Text.AlignHCenter
                role: "column2"
                title: "时间"
                width: 100
            }
            TableViewColumn {
                horizontalAlignment: Text.AlignHCenter
                role: "column3"
                title: "操作"
                width: 100
            }
            TableViewColumn {
                horizontalAlignment: Text.AlignHCenter
                role: "column3"
                title: "地点"
                width: 497
            }
        }
        Text{
            Layout.preferredHeight: 20
            Layout.preferredWidth: 100
            Layout.alignment: Qt.AlignRight
            Layout.bottomMargin: 10
            text: "共50条"
            color: "white"
        }
    }
}