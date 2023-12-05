import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    property alias backgroundImage: image.source
    property alias customOnClick: onClicked

    MouseArea {
        anchors.fill: parent
        onClicked: {
            // 每次按钮被点击时，执行不同的操作
            customOnClick();
        }
    }

    contentItem: Image {
        id: image
        anchors.fill: parent
        source: "qrc:/path/to/default/image.png"
    }
}
