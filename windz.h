#ifndef WINDZ_H
#define WINDZ_H

#include <QObject>
#include <QQuickItem>
#include <qqml.h>

class WindZ : public QObject
{
    Q_OBJECT
    static WindZ* object_;
public:

    Q_INVOKABLE int getZOrder(QQuickItem* w);
    static WindZ* instance();
signals:

};

#endif // WINDZ_H
