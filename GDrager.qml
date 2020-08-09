import QtQuick 2.6
import QtQuick.Window 2.2
import GDrager 1.0

Rectangle {

    id: root
    readonly property alias dragging: mouseArea.pressed
    default property alias data: draggable.data
    property int hotSpotX: 0
    property int hotSpotY: 0



    color: "black"
    Item {
        id: draggable
        width:root.width
        height: root.height
    }


    Rectangle {

        id: tow
        property int px
        property int py
        width:root.width
        height: root.height
        color: "transparent"
        border.color: "black"

        onXChanged: {
            mouseArea.window.x+=x-px;
            GDragerCenter.x=mouseArea.window.x + hotSpotX;
            px=x;
        }
        onYChanged: {
            mouseArea.window.y+=y-py;
            GDragerCenter.y=mouseArea.window.y + hotSpotY;
            py=y;
        }

    }
    MouseArea {
        id: mouseArea
        property Window window: null
        width:root.width
        height: root.height
        drag.target: tow

        Rectangle
        {
            width: 10
            height: 10
            color: "red"
        }

        z: 1
        Component {
            id: windowComponent
            Window {
                visible: true
                color: "transparent"
                flags: Qt.Tool | Qt.FramelessWindowHint | Qt.WindowDoesNotAcceptFocus
                width: root.width
                height: root.height
                data: draggable
            }
        }
        onPressed: {

            var pos=draggable.mapToGlobal(draggable.x-mouseX,draggable.y-mouseY);
            window = windowComponent.createObject(Window.window, {})
            window.x=mouseArea.mouseX + pos.x;
            window.y=mouseArea.mouseY + pos.y;
            GDragerCenter.x=window.x + hotSpotX;
            GDragerCenter.y=window.y + hotSpotY;
            GDragerCenter.dragTraget=null;
            GDragerCenter.dragItem=root;
            GDragerCenter.active=true;
            tow.px=0
            tow.py=0

        }
        onReleased: {
            if(GDragerCenter.dragTarget != null)
            {
                root.parent = GDragerCenter.dragTarget;
                root.x=root.parent.mapFromGlobal(mouseArea.window.x,0).x
                root.y=root.parent.mapFromGlobal(0,mouseArea.window.y).y
            }

            draggable.parent = root;
            draggable.x=0;
            draggable.y=0;
            GDragerCenter.active=false;
            GDragerCenter.dragItem=null;
            tow.x=0;
            tow.y=0;
            window.destroy();
        }
    }

}
