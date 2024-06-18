
import QtQuick 2.2
import QtQuick.Controls 2.15
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.15
import QtQuick.Controls.Styles 1.4

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
            id: pageModelsys_reset
            ListElement{type: "reset"}
        }

        ListView{
            model: pageModelsys_reset
            anchors.fill: parent
            delegate: AndroidDelegate{
                text: title
                Loader {
                    width: parent.width
                    sourceComponent: {
                        if (model.type === "reset") {
                            return reset;
                        } else {
                            return null;
                        }
                    }
                }
            }
            Component {
                id: reset
                Rectangle {
                    width: parent.width
                    height: parent.height
                    color: "lightgreen"
                    border.color: "gray"
                    border.width: 1

                    RowLayout {
                        spacing: 10
                        Text {
                            text: "恢复出厂设置"
                            color: "white"
                            Layout.preferredHeight: 25
                            Layout.preferredWidth: 110
                            Layout.leftMargin: 30
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Item {width: 100}
                        Button {
                            Layout.preferredHeight: 25
                            text: "恢复出厂设置"
                            style: ButtonStyle{
                                background: Rectangle{
                                    implicitWidth: 100
                                    implicitHeight: 40
                                    radius: 9
                                    color: control.pressed ? "#ffffff" : "#d9001b"
                                }
                                label: Text {
                                    text: control.text
                                    font.pixelSize: 16
                                    color: "white" // Set the desired font color here
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}