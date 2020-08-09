import QtQuick 2.0
import QtQuick.Window 2.2

Item {
    id: root
    readonly property alias dragging: mouseArea.pressed
    property bool lol: true
    property Window targetWindow: lol ? win2 : window1
    implicitWidth: draggable.childrenRect.width
    implicitHeight: draggable.childrenRect.height
    default property alias data: draggable.data
    Item {
        id: draggable
        implicitWidth: childrenRect.width
        implicitHeight: childrenRect.height
    }
    MouseArea {
        id: mouseArea
        anchors.fill: draggable
        property Window window: null
        z: 1
        Component {
            id: windowComponent
            Window {
                visible: true
                color: "transparent"
                flags: Qt.Tool | Qt.FramelessWindowHint | Qt.WindowDoesNotAcceptFocus
                width: draggable.width
                height: draggable.height
                data: draggable
                property real offsetX
                property real offsetY
                x: root.Window.window.x + root.x + mouseArea.mouseX - offsetX
                y: root.Window.window.y + root.y + mouseArea.mouseY - offsetY
            }
        }
        onPressed: {
            draggable.x = 0;
            draggable.y = 0;
            window = windowComponent.createObject(Window.window, {offsetX: mouseX, offsetY: mouseY})
        }
        onReleased: {
            window.x = window.x;
            window.y = window.y;
            root.x = window.x - targetWindow.x
            root.y = window.y - targetWindow.y
            root.parent = targetWindow.contentItem;
            draggable.parent = root;
            window.destroy();
            window = null;
            lol = !lol;
        }
    }
}
