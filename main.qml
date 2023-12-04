import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15


ApplicationWindow {
    visible: true
    width: 400
    height: 300
    title: "Floating Subcontrol Example"
    color: "#185abd"
    flags: Qt.FramelessWindowHint

    Frame {
        id: floating_subcontrol_left
        visible: true
        width: 65
        height: parent.height
        background: Rectangle{
            color: "#010101"
            border.color: "#21be2b"
        }
        ColumnLayout{
            id:grid
            Layout.fillWidth: true
            Layout.fillHeight: true
            anchors.centerIn: parent
            Button {
                Rectangle {
                    implicitHeight:parent.height
                    implicitWidth:parent.height
                    color: "transparent"  // 将 Rectangle 颜色设置为透明，使得背景图片显示
                    Image {
                        anchors.fill: parent  // 图片充满整个 Rectangle 区域
                        source: "./images/back.png"  // 图片路径，这里使用资源路径，也可以使用绝对或相对路径
                    }
                }
            }
            Button {
                Rectangle {
                    implicitHeight:parent.height
                    implicitWidth:parent.height
                    color: "transparent"  // 将 Rectangle 颜色设置为透明，使得背景图片显示
                    Image {
                        anchors.fill: parent  // 图片充满整个 Rectangle 区域
                        source: "./images/iso.png"  // 图片路径，这里使用资源路径，也可以使用绝对或相对路径
                    }
                }
            }
            Button {

                Rectangle {
                    implicitHeight:parent.height
                    implicitWidth:parent.height
                    color: "transparent"  // 将 Rectangle 颜色设置为透明，使得背景图片显示
                    Image {
                        anchors.fill: parent  // 图片充满整个 Rectangle 区域
                        source: "./images/ls.png"  // 图片路径，这里使用资源路径，也可以使用绝对或相对路径
                    }
                }
            }
            Button {
                Rectangle {
                    implicitHeight:parent.height
                    implicitWidth:parent.height
                    color: "transparent"  // 将 Rectangle 颜色设置为透明，使得背景图片显示
                    Image {
                        anchors.fill: parent  // 图片充满整个 Rectangle 区域
                        source: "./images/color.png"  // 图片路径，这里使用资源路径，也可以使用绝对或相对路径
                    }
                }
            }
            Button {
                Rectangle {
                    implicitHeight:parent.height
                    implicitWidth:parent.height
                    color: "transparent"  // 将 Rectangle 颜色设置为透明，使得背景图片显示
                    Image {
                        anchors.fill: parent  // 图片充满整个 Rectangle 区域
                        source: "./images/param.png"  // 图片路径，这里使用资源路径，也可以使用绝对或相对路径
                    }
                }
            }
            Button {
                Rectangle {
                    implicitHeight:parent.height
                    implicitWidth:parent.height
                    color: "transparent"  // 将 Rectangle 颜色设置为透明，使得背景图片显示
                    Image {
                        anchors.fill: parent  // 图片充满整个 Rectangle 区域
                        source: "./images/settings.png"  // 图片路径，这里使用资源路径，也可以使用绝对或相对路径
                    }
                }
            }
        }
    }
    Pane {
        id: floating_subcontrol_right
        visible: true
        width: 65
        height: parent.height
        anchors.right: parent.right
        background: Rectangle{
            color: "#20232c"
            border.color: "#21be2b"
        }
        ColumnLayout{
            id:grid_right
            Layout.fillWidth: true
            Layout.fillHeight: true
            anchors.horizontalCenter: parent.horizontalCenter
            Button {
                text: "模式切换"
            }
            Button {
                Rectangle {
                    implicitHeight:parent.height
                    implicitWidth:parent.height
                    color: "transparent"  // 将 Rectangle 颜色设置为透明，使得背景图片显示
                    Image {
                        anchors.fill: parent  // 图片充满整个 Rectangle 区域
                        source: "./images/take_shot.png"  // 图片路径，这里使用资源路径，也可以使用绝对或相对路径
                    }
                }
            }
            Button {
                Rectangle {
                    implicitHeight:parent.height
                    implicitWidth:parent.height
                    color: "transparent"  // 将 Rectangle 颜色设置为透明，使得背景图片显示
                    Image {
                        anchors.fill: parent  // 图片充满整个 Rectangle 区域
                        source: "./images/record.png"  // 图片路径，这里使用资源路径，也可以使用绝对或相对路径
                    }
                }
            }
            Button {
                Rectangle {
                    implicitHeight:parent.height
                    implicitWidth:parent.height
                    color: "transparent"  // 将 Rectangle 颜色设置为透明，使得背景图片显示
                    Image {
                        anchors.fill: parent  // 图片充满整个 Rectangle 区域
                        source: "./images/playback.png"  // 图片路径，这里使用资源路径，也可以使用绝对或相对路径
                    }
                }
            }
        }
    }
}
