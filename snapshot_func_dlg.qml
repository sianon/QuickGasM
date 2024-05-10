import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Dialog{
    id: dialog
    modal: true
    width: 239
    height: 150
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

    GridLayout {
        anchors.fill: parent
        columns: 3
        width: dialog.width
        height: dialog.height
        RowLayout {
            Layout.columnSpan: 3
            anchors.left: parent.left
            Layout.fillWidth: true
            Layout.preferredHeight: 10
            Text {
                Layout.alignment: Qt.AlignHCenter
                text: "拍照"
                color: "#ffffffff"
            }
            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
                // 此 Item 是占位布局，不显示内容
            }
//            Button {
//                Layout.preferredWidth: 30
//                anchors.centerIn: dialog.right
//                text: "X"
//                onClicked: dialog.close()
//            }
        }
        Button {
            text: "保存"
            Layout.preferredHeight: 40
            Layout.preferredWidth: 60
            onClicked: {
                providers.mvCallBackMsg("save");
                dialog.close();
                return "save";
            }
        }
        Button {
            text: "语音"
            Layout.preferredHeight: 40
            Layout.preferredWidth: 60
            onClicked: {
                dialog.close();
                return "start_voice";
            }
        }
        Button {
            text: "取消"
            Layout.preferredHeight: 40
            Layout.preferredWidth: 60
            onClicked: {
                providers.mvCallBackMsg("cancel");
                dialog.close();
            }
        }
    }
}
