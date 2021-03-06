#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <windz.h>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    qmlRegisterSingletonType(QUrl("qrc:/GDragerCenter.qml"), "GDrager", 1, 0, "GDragerCenter" );
    qmlRegisterSingletonType<WindZ>("GDrager",1,0,"WindZ",[](QQmlEngine *,QJSEngine *)-> QObject *{return  WindZ::instance();});

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);



    engine.load(url);

    return app.exec();
}
