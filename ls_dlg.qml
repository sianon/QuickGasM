import QtQuick 2.15
//import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Dialog{
    id: dialog
    modal: true
    width: 200
    height: 150
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    background:Rectangle {
        color: "#1e2129"
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
            text: "铁红"
            Layout.preferredHeight: 40
            Layout.preferredWidth: 40
            onClicked: dialog.close()
        }
        Button {
            text: "白热"
            Layout.preferredHeight: 40
            Layout.preferredWidth: 40
            onClicked: dialog.close()
        }
        Button {
            text: "彩虹"
            Layout.preferredHeight: 40
            Layout.preferredWidth: 40
            onClicked: dialog.close()
        }
        Button {
            text: "羽红"
            Layout.preferredHeight: 40
            Layout.preferredWidth: 40
            onClicked: dialog.close()
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
            text: "反羽红"
            Layout.preferredHeight: 40
            Layout.preferredWidth: 40
            onClicked: dialog.close()
        }
    }
}
