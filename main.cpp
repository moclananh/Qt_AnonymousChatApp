#include <QDebug>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "cookieservice.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    // App information
    app.setOrganizationName("AnonymousChat");
    app.setOrganizationDomain("learnqt.guide");
    app.setApplicationName("Project_AnonymousChat");

    QQmlApplicationEngine engine;

    // Register the CookieService type
    qmlRegisterType<CookieService>("cookie.service", 1, 0, "Cookie");

    // Create an instance of CookieService
    CookieService cookieService;

    // Load the user_id using the loadData method
    QVariant user_id = cookieService.loadCookie("user_id");

    // Check if user_id is available
    if (user_id.isNull() || user_id.toString().isEmpty()) {
        qDebug() << "No user_id found. Loading HomeScreen...";
        engine.loadFromModule("Project_AnonymousChat", "HomeScreen");
    } else {
        qDebug() << "user_id found:" << user_id.toString() << ". Loading Main...";
        engine.loadFromModule("Project_AnonymousChat", "Main");
    }

    // Handle object creation failures
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    return app.exec();
}
