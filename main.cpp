#include <QDebug>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "appstate.h"
#include "clipboardheader.h"
#include "cookieservice.h"
#include "groupmessagemanager.h"
#include "message.h"
#include "networkmanager.h"
#include "websocketclient.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    // App information
    app.setOrganizationName("AnonymousChat");
    app.setOrganizationDomain("learnqt.guide");
    app.setApplicationName("Project_AnonymousChat");

    QQmlApplicationEngine engine;
    AppState app_state(&app);

    // Register the services
    qmlRegisterType<CookieService>("cookie.service", 1, 0, "Cookie");
    qmlRegisterType<NetworkManager>("network.service", 1, 0, "NetworkManager");
    qmlRegisterType<ClipboardHelper>("Helpers", 1, 0, "ClipboardHelper");

    qmlRegisterType<GroupMessageManager>("group.message", 1, 0, "GroupMessageManager");
    qmlRegisterType<Message>("group.message", 1, 0, "Message");

    WebSocketClient socketClient(QUrl("ws://127.0.0.1:8080/ws"));
    engine.rootContext()->setContextProperty("app_state", &app_state);
    engine.rootContext()->setContextProperty("websocket", &socketClient);

    CookieService cookieService;
    QVariant user_id = cookieService.loadCookie("user_id");
    QVariant user_code = cookieService.loadCookie("user_code");

    if (user_id.isNull() || user_id.toString().isEmpty()) {
        qDebug() << "No user_id found. Loading HomeScreen...";
        engine.loadFromModule("Project_AnonymousChat", "HomeScreen");
    } else {
        socketClient.setUserCode(user_code.toString());
        socketClient.open();
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
