import QtQuick 2.2
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item{
    width: 800
    height: 480
    Rectangle {
        color: "#212126"
        anchors.fill: parent
    }
    ColumnLayout{
        anchors.fill: parent

        ListModel{
            id: pageModelsys
            ListElement{
                title: "气体泄漏报警设置"
                page: "gas_leak_setting_dlg.qml"
            }
            ListElement{
                title: "高低温报警设置"
                page: "low_high_tempreture_setting_dlg.qml"
            }
            ListElement{
                title: "报警记录"
                page: "alarm_log_dlg.qml"
            }
        }
        ListView{
            model: pageModelsys
            anchors.fill: parent
            delegate: AndroidDelegate{
                text: title
                onClicked: stackView.push(Qt.resolvedUrl(page))
            }
        }
    }
}
