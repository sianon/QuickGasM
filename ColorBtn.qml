import QtQuick 2.15
//import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15


Button {
    id: customerBtn
    //    text: "紫红"
    Layout.preferredHeight: 40
    Layout.preferredWidth: 60
    background: Rectangle {
        implicitWidth: 60
        implicitHeight: 40
        opacity: enabled ? 1 : 0.3
        color: parent.down ? "#7f7f7f" : "#333333"
    }
    contentItem: Text {
        text: parent.text
        opacity: enabled ? 1.0 : 0.3
        color: "white"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }
    //    onClicked: {
    //        colorTempletChange("color_type_iron_red");
    //    }
}