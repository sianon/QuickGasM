import Local 1.0
import QtQuick 2.2
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Dialog {
    visible: true
    width: 800
    height: 36
    padding: 0
    x: 0
    y: 370
    background: Rectangle {
        color: "#333333"
    }
    RowLayout {
        spacing: 80
        Component.onCompleted: {
            var siblings = children;
            var siz = siblings.length;
            for (var i = 0; i < siz; i++) {
                if (siblings[i] instanceof CheckBox)
                    siblings[i].enabled = tempmeasure_switch.checked;

            }
        }

        AppleStyleSwitch {
            id: tempmeasure_switch

            text: ""
            Layout.leftMargin: 30
            Layout.preferredHeight: 25
            onClicked: {
                var siblings = parent.children;
                var siz = siblings.length;
                tempreture_detect.mbSwitch(checked);
                for (var i = 0; i < siz; i++) {
                    if (siblings[i] !== parent && siblings[i] instanceof CheckBox)
                        siblings[i].enabled = checked;
                }
            }
        }

        CheckBox {
            id: center_pt

            Layout.preferredWidth: 36
            Layout.preferredHeight: 36
            Layout.margins: 0
            onClicked: {
                tempreture_detect.mbCenterPointCheck(checked)
            }

            indicator: Rectangle {
                implicitHeight: parent.height
                implicitWidth: parent.height
                color: parent.enabled ? "#333333" : "#444444"

                Image {
                    anchors.fill: parent
                    source: "../images/center_pt.png"
                }

            }

        }

        CheckBox {
            id: cold_pt

            Layout.preferredWidth: 36
            Layout.preferredHeight: 36
            Layout.margins: 0
            onClicked: {
                tempreture_detect.mbColdPointCheck(checked)
            }

            indicator: Rectangle {
                implicitHeight: parent.height
                implicitWidth: parent.height
                color: parent.enabled ? "#333333" : "#444444"

                Image {
                    anchors.fill: parent
                    source: "../images/cold_pt.png"
                }

            }

        }

        CheckBox {
            id: plume_enhance

            Layout.preferredWidth: 36
            Layout.preferredHeight: 36
            onClicked: {
                tempreture_detect.mbHotPointCheck(checked)
            }

            indicator: Rectangle {
                implicitHeight: parent.height
                implicitWidth: parent.height
                color: parent.enabled ? "#333333" : "#444444"

                Image {
                    anchors.fill: parent
                    source: "../images/hot_pt.png"
                }

            }

        }

        CheckBox {
            id: cust_pt

            Layout.preferredWidth: 36
            Layout.preferredHeight: 36
            onClicked: {
                tempreture_detect.mbCustomPointCheck(checked)
            }

            indicator: Rectangle {
                implicitHeight: parent.height
                implicitWidth: parent.height
                color: parent.enabled ? "#333333" : "#444444"

                Image {
                    anchors.fill: parent
                    source: "../images/cust_pt.png"
                }

            }

        }

        CheckBox {
            id: cust_line

            Layout.preferredWidth: 36
            Layout.preferredHeight: 36
            onClicked: {
                tempreture_detect.mbCustomLineCheck(checked)
            }

            indicator: Rectangle {
                implicitHeight: parent.height
                implicitWidth: parent.height
                color: parent.enabled ? "#333333" : "#444444"

                Image {
                    anchors.fill: parent
                    source: "../images/cust_line.png"
                }

            }

        }

        CheckBox {
            id: cust_rect

            Layout.preferredWidth: 36
            Layout.preferredHeight: 36
            onClicked: {
                tempreture_detect.mbCustomRectCheck(checked)
            }

            indicator: Rectangle {
                implicitHeight: parent.height
                implicitWidth: parent.height
                color: parent.enabled ? "#333333" : "#444444"

                Image {
                    anchors.fill: parent
                    source: "../images/cust_rect.png"
                }

            }

        }
    }
}
