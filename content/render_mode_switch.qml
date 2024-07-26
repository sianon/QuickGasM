import QtQuick 2.2
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Dialog{
    visible: true
    width: 800
    height: 36
    padding: 0
    x: 0
    y: 370
    Rectangle{
        anchors.fill: parent
        color: "#333333"
    }
    RowLayout{
        spacing: 80
        Button{
            Layout.preferredWidth: 36
            Layout.preferredHeight: 36
            Layout.leftMargin: 60

            Rectangle{
                implicitHeight: parent.height
                implicitWidth: parent.height
                color: "#333333"
                Image{
                    anchors.fill: parent
                    source: "../images/infrared_mode.png"
                }
            }
            onPressed:{
                switchRenderMode("infrared");
            }
        }
        Button{
            Layout.preferredWidth: 36
            Layout.preferredHeight: 36
            Layout.margins: 0
            Rectangle{
                implicitHeight: parent.height
                implicitWidth: parent.height
                color: "#333333"
                Image{
                    anchors.fill: parent
                    source: "../images/white_mode.png"
                }
            }
            onClicked:{
                switchRenderMode("white");
            }
        }

        Button{
            Layout.preferredWidth: 36
            Layout.preferredHeight: 36
            Layout.margins: 0
            Rectangle{
                implicitHeight: parent.height
                implicitWidth: parent.height
                color: "#333333"
                Image{
                    anchors.fill: parent
                    source: "../images/pip_mode.png"
                }
            }
        }
        Button{
            Layout.preferredWidth: 36
            Layout.preferredHeight: 36
            onClicked:{
                testbtn(123);
            }
            Rectangle{
                implicitHeight: parent.height
                implicitWidth: parent.height
                color: "#333333"
                Image{
                    anchors.fill: parent
                    source: "../images/detail_enhance_mode.png"
                }
            }
        }
    }
}
