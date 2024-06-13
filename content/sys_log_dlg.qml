import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.15

Item{
    //    id: dialog
    //    modal: true
    //    width: 800
    //    height: 480
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
            Text{
                text: "开机时间"
                color: "white"
            }
            TextField{
                text: "2020-01-01"
                Layout.preferredWidth: 93
            }
            Text{
                text: "关机时间"
                color: "white"
            }
            TextField{
                text: "2020-01-01"
                Layout.preferredWidth: 93
            }
            Text{
                text: "开机地点"
                color: "white"
            }
            TextField{
                text: "请选择地点"
                Layout.preferredWidth: 93
            }
            Text{
                text: "关机地点"
                color: "white"
            }
            TextField{
                text: "请选择地点"
                Layout.preferredWidth: 93
            }
            Button{
                text: "查询"
                Layout.preferredWidth: 80
                onClicked: {
                }
            }
        }
        TableView {
            Layout.preferredWidth: parent.width - 40
            Layout.preferredHeight: 290
            Layout.margins: 20
            //            Layout.alignment: Qt.AlignHCenter
            model: tableModel
            TableViewColumn {
                role: "column1"
                title: "序号"
                width: 100
            }
            TableViewColumn {
                role: "column2"
                title: "开机时间"
                width: 100
            }
            TableViewColumn {
                role: "column3"
                title: "关机时间"
                width: 100
            }
            TableViewColumn {
                role: "column3"
                title: "使用时长"
                width: 100
            }
            TableViewColumn {
                role: "column3"
                title: "开机地点"
                width: 100
            }
            TableViewColumn {
                role: "column3"
                title: "关机地点"
                width: 100
            }
        }

        Button{
            Layout.alignment: Qt.AlignRight
            text: "导出"
            onClicked: {
            }
        }

    }
}
