import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Dialog{
    id: dialog
    modal: true
    width: 760
    height: 460
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    background: Rectangle{
        color: "#010101"
    }

    function colorTempletChange(val_arg){
        providers.mvSetColorType(val_arg);
        console.log("colorTempletChange", val_arg, "return ok");
        return "ok";
    }

    ColumnLayout{
        anchors.left: parent.left
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.alignment: Qt.AlignHCenter

//        Rectangle{
//            radius: 5 // 设置圆角大小
//            color: "#ff0000"
//            height: 300
//            width: 300
//            Layout.alignment: Qt.AlignHCenter
//        }

        GridLayout{
//            anchors.fill: parent
            columns: 4
            width: 736
            height: 400
            visible: true
            Layout.alignment: Qt.AlignHCenter
            Rectangle{
                radius: 5 // 设置圆角大小
                color: "#3c3f41"
                anchors.fill: parent
            }

        }
        RowLayout{
//            anchors.left: parent.left
            Layout.fillWidth: true
            Layout.preferredHeight: 20
            Layout.alignment: Qt.AlignHCenter
            visible: true
            Button{
                text: "删除"
                Layout.preferredHeight: 40
                Layout.preferredWidth: 60
                Layout.alignment: Qt.AlignHCenter
                onClicked:{
                    providers.mvCallBackMsg("save");
                    dialog.close();
                    return "save";
                }
            }
            Button{
                text: "查看"
                Layout.preferredHeight: 40
                Layout.preferredWidth: 60
                onClicked:{
                }
            }
            Button{
                text: "返回"
                Layout.preferredHeight: 40
                Layout.preferredWidth: 60
                onClicked:{
                    dialog.close();
                }
            }
        }
    }
}
