#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    //App information
    app.setOrganizationName("AnonymousChat");
    app.setOrganizationDomain("learnqt.guide");
    app.setApplicationName("Project_AnonymousChat");
    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("Project_AnonymousChat", "Main");

    return app.exec();
}
