import QtQuick 2.11
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item{
    width: 800
    height: 480
    Rectangle {
        anchors.fill: parent
        color: "#212126"
    }
    ScrollView{
        anchors.fill: parent
        ColumnLayout{
            Row{
                Layout.leftMargin: 50
                height: 36
                Label{
                    width: 118
                    text: "热点开关"
                    color:"white"
                    font.pixelSize: fontSizeMedium
                    //                Layout.alignment: Qt.AlignVCenter
                }
                Item{
                    width: 500
                    height: 20
                }
                AppleStyleSwitch{
                    //                Layout.alignment: Qt.AlignVCenter
                    id: pot
                    width: 90
                    height: 40
                    text: qsTr("View")

                }
            }
            Row{
                Layout.leftMargin: 90
                visible: pot.checked
                Label{
                    width: 118
                    text: "设备名称"
                    color:"white"
                    font.pixelSize: fontSizeMedium
                    //                Layout.alignment: Qt.AlignVCenter
                }
                TextField{
                    text: "热点开关"
                    id:download

                    width: 120
                    height: 30
                    color:"white"
                    font.pixelSize: fontSizeMedium
                    Layout.alignment: Qt.AlignRight
                }
            }
            Row{
                Layout.leftMargin: 90
                visible: pot.checked
                Label{
                    width: 118
                    text: "密码"
                    color:"white"
                    font.pixelSize: fontSizeMedium
                    //                Layout.alignment: Qt.AlignVCenter
                }
                TextField{
                    text: "热点开关"

                    width: 120
                    height: 30
                    color:"white"
                    font.pixelSize: fontSizeMedium
                    Layout.alignment: Qt.AlignRight
                }
            }
            Row{
                Layout.leftMargin: 50
                height: 36
                Label{
                    width: 118
                    text: "4G网络"
                    color:"white"
                    font.pixelSize: fontSizeMedium
                    //                Layout.alignment: Qt.AlignVCenter
                }
                Item{
                    width: 500
                    height: 20
                }
                AppleStyleSwitch{
                    //                Layout.alignment: Qt.AlignVCenter
                    id: fourG
                    width: 90
                    height: 40
                    text: qsTr("View")

                }
            }
            Row{
                Layout.leftMargin: 90
                visible: fourG.checked
                Label{
                    width: 118
                    text: "运营商"
                    color:"white"
                    font.pixelSize: fontSizeMedium
                    //                Layout.alignment: Qt.AlignVCenter
                }
                Label{
                    text: "中国电信"
                    width: 120
                    height: 30
                    color:"white"
                    font.pixelSize: fontSizeMedium
                    Layout.alignment: Qt.AlignRight
                }
            }
            Row{
                Layout.leftMargin: 90
                visible: fourG.checked
                Label{
                    width: 118
                    text: "信号强度"
                    color:"white"
                    font.pixelSize: fontSizeMedium
                    //                Layout.alignment: Qt.AlignVCenter
                }
                Label{
                    text: "弱"

                    width: 120
                    height: 30
                    color:"white"
                    font.pixelSize: fontSizeMedium
                    Layout.alignment: Qt.AlignRight
                }
            }
            Row{
                Layout.leftMargin: 90
                visible: fourG.checked
                Label{
                    width: 118
                    text: "网络状态"
                    color:"white"
                    font.pixelSize: fontSizeMedium
                    //                Layout.alignment: Qt.AlignVCenter
                }
                Label{
                    text: "正常可用"

                    width: 120
                    height: 30
                    color:"white"
                    font.pixelSize: fontSizeMedium
                    Layout.alignment: Qt.AlignRight
                }
            }
            Row{
                Layout.leftMargin: 50
                height: 36
                Label{
                    width: 118
                    text: "WLAN"
                    color:"white"
                    font.pixelSize: fontSizeMedium
                    //                Layout.alignment: Qt.AlignVCenter
                }
                Item{
                    width: 500
                    height: 20
                }
                AppleStyleSwitch{
                    //                Layout.alignment: Qt.AlignVCenter
                    id: wlan
                    width: 90
                    height: 40
                    text: qsTr("View")

                }
            }
            ColumnLayout{
                Layout.leftMargin: 90
                height: 66
                width: parent.width - 480
                visible: wlan.checked
                Repeater{
                    model: 5
                    Row{
                        Layout.leftMargin: 90
                        Label{
                            width: 118
                            text: "CMCC-EDU"
                            color: "white"
                            font.pixelSize: fontSizeMedium
                            //                Layout.alignment: Qt.AlignVCenter
                        }
                        Label{
                            text: "NO Signal"

                            width: 120
                            height: 30
                            color: "white"
                            font.pixelSize: fontSizeMedium
                            Layout.alignment: Qt.AlignRight
                        }
                    }
                }
            }
            Row{
                Layout.leftMargin: 50
                height: 36
                Label{
                    width: 118
                    text: "蓝牙"
                    color:"white"
                    font.pixelSize: fontSizeMedium
                    //                Layout.alignment: Qt.AlignVCenter
                }
                Item{
                    width: 500
                    height: 20
                }
                AppleStyleSwitch{
                    //                Layout.alignment: Qt.AlignVCenter
                    id: bluetooth
                    width: 90
                    height: 40
                    text: qsTr("View")

                }
            }
            Row{
                Layout.leftMargin: 90
                height: 36
                visible: bluetooth.checked
                Label{
                    width: 118
                    text: "设备名称"
                    color:"white"
                    font.pixelSize: fontSizeMedium
                    //                Layout.alignment: Qt.AlignVCenter
                }
                Item{
                    width:300
                    height: 20
                }
                Label{
                    width: 90
                    height: 40
                    text: qsTr("R10")
                    color:"white"
                }
                Button{
                    width: 40
                    height: 40
                    text: qsTr(">")
                }
            }
            Row{
                Layout.leftMargin: 90
                height: 36
                visible: bluetooth.checked
                Label{
                    width: 118
                    text: "接收的文件"
                    color:"white"
                    font.pixelSize: fontSizeMedium
                    //                Layout.alignment: Qt.AlignVCenter
                }
                Item{
                    width: 390
                    height: 20
                }
                Button{
                    width: 40
                    height: 40
                    text: qsTr(">")
                    onClicked: {

                    }
                }
            }
            Row{
                Layout.leftMargin: 90
                height: 36
                visible: bluetooth.checked
                Label{
                    width: 118
                    text: "已配对设备"
                    color:"white"
                    font.pixelSize: fontSizeMedium
                    //                Layout.alignment: Qt.AlignVCenter
                }
            }
            Column{
                Layout.leftMargin: 130
                visible: bluetooth.checked
                Row{
//                    Layout.leftMargin: 90

                    Label{
                        width: 118
                        text: "OPPO R9"
                        color:"white"
                        font.pixelSize: fontSizeMedium
                        //                Layout.alignment: Qt.AlignVCenter
                    }
                    Item{
                        width: 290
                        height: 20
                    }
                    Label{
                        text: "已配对"
                        width: 120
                        height: 30
                        color:"white"
                        font.pixelSize: fontSizeMedium
                        Layout.alignment: Qt.AlignRight
                    }
                }
            }
            Row{
                Layout.leftMargin: 50
                height: 36
                Label{
                    width: 118
                    text: "北斗定位"
                    color:"white"
                    font.pixelSize: fontSizeMedium
                    //                Layout.alignment: Qt.AlignVCenter
                }
                Item{
                    width: 500
                    height: 20
                }
                AppleStyleSwitch{
                    //                Layout.alignment: Qt.AlignVCenter
                    id: gps
                    width: 90
                    height: 40
                    text: qsTr("View")
                }
            }
        }
    }
}