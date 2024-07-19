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
    background: Rectangle{
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
                    source: "../images/snap.png"
                }
            }
            onPressed:{
                snapshot();
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
                    source: "../images/record.png"
                }
            }
            onClicked:{
                switchRenderMode(123);
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
                    source: "../images/preview_pic.png"
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
                    source: "../images/preview_video.png"
                }
            }
        }
    }
}
