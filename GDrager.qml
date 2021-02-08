import QtQuick 2.6
import QtQuick.Window 2.2
import GDrager 1.0

Item {

    id: root
    readonly property alias dragging: mouseArea.pressed
    // @disable-check M16
    default property alias data: draggable.data
    property int hotSpotX: 0
    property int hotSpotY: 0
    property int threshold: 0
    property var keys : []


    Item {
        id: draggable
        width:root.width
        height: root.height
    }


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

    Item {

        id: dymmy
        width:root.width
        height: root.height
    }

    MouseArea {
        id: mouseArea
        property Window window: null
        width:root.width
        height: root.height
        drag.target: dymmy
        drag.threshold: root.threshold
        property int startx:0
        property int starty:0
        z: 1

        onPressed:
        {
            startx=mouseX;
            starty=mouseY;
        }

        drag.onActiveChanged:
        {
            if(drag.active)
            {
                var pos=draggable.mapToGlobal(0,0);
                window = windowComponent.createObject(Window.window, {})
                window.x= pos.x;
                window.x=Qt.binding(function(){return root.mapToGlobal(mouseX-startx,0).x})
                window.y=Qt.binding(function(){return root.mapToGlobal(0,mouseY-starty).y})
                GDragerCenter.x=Qt.binding(function(){return window.x+hotSpotX})
                GDragerCenter.y=Qt.binding(function(){return window.y+hotSpotY})
                GDragerCenter.dragTraget=null;
                GDragerCenter.dragItem=root;
                GDragerCenter.keys=root.keys
                GDragerCenter.active=true;


            }
            else
            {
                if(GDragerCenter.dragTarget != null)
                {
                    root.parent = GDragerCenter.dragTarget;
                    root.x=root.parent.mapFromGlobal(mouseArea.window.x,0).x
                    root.y=root.parent.mapFromGlobal(0,mouseArea.window.y).y
                }

                draggable.parent = root;
                draggable.x=0;
                draggable.y=0;
                dymmy.x=0;
                dymmy.y=0;
                GDragerCenter.active=false;
                GDragerCenter.dragItem=null;
                GDragerCenter.x=0;//break bind
                GDragerCenter.y=0;//break bind
                window.destroy();
            }
        }




    }

}
