#include <QDebug>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "cookieservice.h"
#include "networkmanager.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    // App information
    app.setOrganizationName("AnonymousChat");
    app.setOrganizationDomain("learnqt.guide");
    app.setApplicationName("Project_AnonymousChat");

    QQmlApplicationEngine engine;

    // Register the services
    qmlRegisterType<CookieService>("cookie.service", 1, 0, "Cookie");
    qmlRegisterType<NetworkManager>("network.service", 1, 0, "NetworkManager");

    CookieService cookieService;
    QVariant user_id = cookieService.loadCookie("user_id");

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
