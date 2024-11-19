#include "websocketclient.h"

WebSocketClient::WebSocketClient(const QUrl &url, QObject *parent)
    : QObject(parent)
    , socket(new QWebSocket)
    , url{url}
{
    connect(socket, &QWebSocket::connected, this, &WebSocketClient::onConnected);
    connect(socket, &QWebSocket::disconnected, this, &WebSocketClient::onDisconnected);
    connect(socket, &QWebSocket::textMessageReceived, this, &WebSocketClient::onTextMessageReceived);
}

bool WebSocketClient::sendMessage(const QString &body)
{
    qint32 sentBytes = socket->sendTextMessage(body);
    return sentBytes > 0 ? true : false;
}

void WebSocketClient::onConnected()
{
    QTextStream(stdout) << "WebSocket connected!" << Qt::endl;
    QJsonObject authenticateMessage;
    authenticateMessage.insert("Authenticate", QJsonValue::fromVariant(m_userCode));
    QString requestBody = QJsonDocument(authenticateMessage).toJson();
    qDebug() << "authenticate request: " << requestBody;
    sendMessage(requestBody);
}

void WebSocketClient::open()
{
    // Connect to the WebSocket server
    QNetworkRequest request(url);
    socket->open(request);
}

void WebSocketClient::setUserCode(const QString &user_code)
{
    this->m_userCode = user_code;
}

void WebSocketClient::onTextMessageReceived(const QString &message)
{
    QTextStream(stdout) << "Received message: " << message << Qt::endl;

    // Example of checking for a specific message or cookie
    if (message.contains("Set-Cookie")) {
        QTextStream(stdout) << "Received cookie in message: " << message << Qt::endl;
    }
    emit receivedMessage(message);
}

void WebSocketClient::onDisconnected()
{
    QTextStream(stdout) << "WebSocket disconnected." << Qt::endl;
    QCoreApplication::quit();
}
