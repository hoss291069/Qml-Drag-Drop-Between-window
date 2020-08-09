import QtQuick 2.12
import GDrager 1.0

Rectangle {
    width:10
    height:10

    x:parent.mapFromGlobal(GDragerCenter.x,0).x
    y:parent.mapFromGlobal(0,GDragerCenter.y).y
    z:1

    color:"red"

    Drag.active:GDragerCenter.active



}
