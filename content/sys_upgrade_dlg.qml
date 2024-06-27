import QtQuick 2.2
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item{
    width: 800
    height: 480
    id: sysUpgradeDlg
    Rectangle {
        color: "#212126"
        anchors.fill: parent
    }
    ColumnLayout{
        anchors.fill: parent

        ListModel{
            id: pageModelsys_up
            ListElement{type: "sysVersion"}
            ListElement{type: "screenLevelHigh"}
        }

        ListView{
            model: pageModelsys_up
            anchors.fill: parent
            delegate: AndroidDelegate{
                text: title
                onClicked: stackView.push(Qt.resolvedUrl(page))
                Loader {
                    width: parent.width
                    sourceComponent: {
                        if (model.type === "sysVersion") {
                            return sysVersion;
                        } else if (model.type === "screenLevelHigh") {
                            return screenLevelHigh;
                        } else {
                            return null;
                        }
                    }
                }
            }

            Component {
                id: sysVersion
                RowLayout {
                    Text {
                        text: "当前系统版本号"
                        color: "white"
                        Layout.preferredHeight: 25
                        Layout.preferredWidth: 110
                        Layout.leftMargin: 30
                        Layout.alignment: Qt.AlignLeft
                    }
                    Text {
                        text: "V01.20240805"
                        color: "white"
                        Layout.rightMargin: 30
                        Layout.alignment: Qt.AlignRight
                    }
                }
            }

            Component {
                id: screenLevelHigh
                RowLayout {
                    Text {
                        text: "搜索本地升级包"
                        color: "white"
                        Layout.preferredHeight: 25
                        Layout.preferredWidth: 110
                        Layout.leftMargin: 30
                        Layout.alignment: Qt.AlignLeft
                    }
                    RoundButton {
                        Layout.preferredHeight: 25
                        Layout.preferredWidth: 110
                        Layout.rightMargin: 30
                        Layout.alignment: Qt.AlignRight
                        text: "开始搜索"
                        onClicked: {
                            var component = Qt.createComponent("upgrade_msgbox.qml");
                            var dlg = component.createObject(sysUpgradeDlg);
                            if (dlg === null) {
                                console.log("Error creating object");
                                return;
                            }
                            dlg.title = "搜索到升级文件包\n" + "是否进行升级？"
                            dlg.show();
                        }
                        background: Rectangle {
                            implicitWidth: 100
                            implicitHeight: 40
                            radius: 20
                            opacity: enabled ? 1 : 0.3
                            color: "#169bd5"
                        }
                    }
                }
            }

        }
    }
}