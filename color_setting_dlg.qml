import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Dialog{
    id: dialog
    modal: true
    width: 280
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
        columns: 4
        width: dialog.width
        height: dialog.height
        RowLayout {
            Layout.columnSpan: 4
            anchors.left: parent.left
            Layout.fillWidth: true
            Layout.preferredHeight: 10
            Text {
                Layout.alignment: Qt.AlignHCenter
                text: "伪彩设置"
                color: "#ffffffff"
            }
            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
                // 此 Item 是占位布局，不显示内容
            }
            Button {
                Layout.preferredWidth: 30
                anchors.centerIn: dialog.right
                text: "X"
                onClicked: dialog.close()
            }
        }
        Button {
            text: "紫红"
            Layout.preferredHeight: 40
            Layout.preferredWidth: 60
            onClicked: {
                colorTempletChange("color_type_iron_red");
            }
        }
        Button {
            text: "白热"
            Layout.preferredHeight: 40
            Layout.preferredWidth: 60
            onClicked: {
                colorTempletChange("color_type_black_white");
            }
        }
        Button {
            text: "彩虹"
            Layout.preferredHeight: 40
            Layout.preferredWidth: 60
            onClicked: {
                colorTempletChange("color_type_rainbow");
            }
        }
        Button {
            text: "羽红"
            Layout.preferredHeight: 40
            Layout.preferredWidth: 60
            onClicked: {
                colorTempletChange("color_type_red");
            }
        }
        Button {
            text: "白热"
            Layout.preferredHeight: 40
            Layout.preferredWidth: 40
            onClicked: dialog.close()
        }
        Button {
            text: "黑热"
            Layout.preferredHeight: 40
            Layout.preferredWidth: 40
            onClicked: dialog.close()
        }
        Button {
            text: "反彩虹"
            Layout.preferredHeight: 40
            Layout.preferredWidth: 40
            onClicked: dialog.close()
        }
        Button {
            text: "白"
            Layout.preferredHeight: 40
            Layout.preferredWidth: 40
            onClicked: {
                colorTempletChange();
            }
        }
    }
}
