import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Popup {
    id: messageBox
    visible: true
    width: 350
    height: 220
    padding: 0
    anchors.centerIn: parent
    Rectangle {
        anchors.fill: parent
        color: "#f2f2f2"
    }
    Timer{
        id: myTimer
        interval: 3000
        running: true
        repeat: false

        onTriggered:{
            //TODO:视频刷新函数调用处
            messageBox.close();
        }
    }
    property string title: "提示！"
    property bool isvisible: true
    RowLayout {
        anchors.centerIn: parent
        spacing: 10

        Rectangle{
            implicitHeight: 36
            implicitWidth: 36
            color: "transparent"
            Image{
                anchors.fill: parent
                source: "../images/succeed.png"
            }
        }
        Text {
            text: title
            wrapMode: Text.Wrap
            Layout.alignment: Qt.AlignHCenter
        }
    }
}
