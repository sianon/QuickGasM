import QtQuick 2.2
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "content"

Dialog{
    id: dialog
    modal: true
    width: 800
    height: 480
    padding: 0
    Rectangle {
        color: "#212126"
        anchors.fill: parent
    }
    ColumnLayout{
        anchors.fill: parent
        BorderImage{
            border.bottom: 8
            source: "images/toolbar.png"
            width: parent.width
            height: 40
            Rectangle{
                id: backButton
                width: opacity ? 60 : 0
                anchors.left: parent.left
                anchors.leftMargin: 20
                opacity: stackView.depth > 1 ? 1 : 0
                anchors.verticalCenter: parent.verticalCenter
                antialiasing: true
                height: 40
                radius: 4
                color: backmouse.pressed ? "#222" : "transparent"
                Behavior on opacity{ NumberAnimation{} }
                Image{
                    anchors.verticalCenter: parent.verticalCenter
                    source: "images/navigation_previous_item.png"
                }
                MouseArea{
                    id: backmouse
                    anchors.fill: parent
                    anchors.margins: -10
                    onClicked: {
                        if(stackView.depth == 1){
                            dialog.close()
                        }
                        stackView.pop()
                        console.log("previous page")
                    }
                }
            }

            Text{
                font.pixelSize: 18
                Behavior on x{ NumberAnimation{ easing.type: Easing.OutCubic} }
                x: backButton.x + backButton.width + 20
                anchors.verticalCenter: parent.verticalCenter
                color: "white"
                text: "高级设置"
            }
        }

        ListModel{
            id: pageModel
            ListElement{
                title: "报警管理"
                //             page: "content/ButtonPage.qml"
            }
            ListElement{
                title: "拍照设置"
                //             page: "content/SliderPage.qml"
            }
            ListElement{
                title: "录像设置"
                //             page: "content/ProgressBarPage.qml"
            }
            ListElement{
                title: "云服务"
                //             page: "content/TabBarPage.qml"
            }
            ListElement{
                title: "网络设置"
                //             page: "content/TextInputPage.qml"
            }
            ListElement{
                title: "双光设置"
                //             page: "content/ListPage.qml"
            }
            ListElement{
                title: "测量单位设置"
                //             page: "content/TextInputPage.qml"
            }
            ListElement{
                title: "系统设置"
                page: "content/sys_setting_dlg.qml"
            }
        }

        StackView{
            id: stackView
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter
            // Implements back key navigation
            focus: true
            Keys.onReleased: if(event.key === Qt.Key_Back && stackView.depth > 1){
                stackView.pop();
                event.accepted = true;
            }

            initialItem: Item{
                width: parent.width
                height: parent.height
                ListView{
                    model: pageModel
                    anchors.fill: parent
                    delegate: AndroidDelegate{
                        text: title
                        onClicked: stackView.push(Qt.resolvedUrl(page))
                    }
                }
            }
        }
    }
}
