#include "windz.h"
#include "QQuickWindow"
#include <windows.h>

WindZ* WindZ::object_=nullptr;


int WindZ::getZOrder(QQuickItem* o)
{
    QQuickWindow* w=o->window();

    if(w==nullptr)
        return -1;
    HWND targetHandle=reinterpret_cast<HWND>(w->winId());

    HWND wh=GetTopWindow(NULL);

    int i=0;
    do
    {
        if(wh==targetHandle)
            return 10000-i;
        wh=GetWindow(wh,GW_HWNDNEXT);
        i++;
    }while(wh!=NULL);
    return -1;



}

WindZ* WindZ::instance()
{
    if(object_==nullptr)
        object_ = new WindZ();

    return object_;
}
