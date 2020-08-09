import QtQuick 2.6
import QtQuick.Window 2.2

Window {
    id: window1
    visible: true
    x:0
    y:0
    width: 640
    height: 480
    GDragAgent{}

    GDrager
    {
        id: draggable
        width:100
        height:width
        x:20
        y:50

        hotSpotX:10
        hotSpotY:10

        Rectangle
        {
            anchors.fill: parent
            radius:width/2
            color: draggable.dragging ? "pink" : "orange"
        }


    }




    Window {
        id: win3
        width: 640
        height: 480
        x: 900
        y: 100
        visible: true

        GDragAgent{}


        GDropArea
        {
            anchors.fill: parent
        }


    }


    Window {
        id: win4
        width: 640
        height: 480
        x: 700
        y: 400
        visible: true
        GDragAgent{}

        GDropArea
        {
            anchors.fill: parent
        }

    }



}
