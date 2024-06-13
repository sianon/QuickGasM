import QtQuick 2.2
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item{
//    id: dialog
//    modal: true
//    width: 800
//    height: 480
//    padding: 0
    Rectangle {
        color: "#212126"
        anchors.fill: parent
    }
    ColumnLayout{
        anchors.fill: parent

        ListModel{
            id: pageModelsys
            ListElement{
                title: "时间设置"
                page: "time_setting_dlg.qml"
            }
            ListElement{
                title: "电量管理"
                page: "bat_manage_dlg.qml"
            }
            ListElement{
                title: "存储管理"
                page: "store_manage_dlg.qml"
            }
            ListElement{
                title: "系统升级"
                page: "sys_upgrade_dlg.qml"
            }
            ListElement{
                title: "恢复出厂设置"
                page: "reset_dlg.qml"
            }
            ListElement{
                title: "系统日志"
                page: "sys_log_dlg.qml"
            }
            ListElement{
                title: "关于设备"
                page: "about_dlg.qml"
            }
        }

//        StackView{
//            id: stackViews
//            Layout.fillWidth: true
//            Layout.fillHeight: true
//            Layout.alignment: Qt.AlignHCenter
//            // Implements back key navigation
//            focus: true
//            Keys.onReleased: if(event.key === Qt.Key_Back && stackView.depth > 1){
//                stackView.pop();
//                event.accepted = true;
//            }

//            initialItem: Item{
//                width: parent.width
//                height: parent.height
                ListView{
                    model: pageModelsys
                    anchors.fill: parent
                    delegate: AndroidDelegate{
                        text: title
                        onClicked: stackView.push(Qt.resolvedUrl(page))
                    }
                }
            }
//        }
//    }
}
