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

bool WebSocketClient::deleteMessage(int groupId, const QList<int> &messageIds)
{
    QJsonObject deleteMessage;
    QJsonArray jsonMessageIds;
    for (int id : messageIds) {
        jsonMessageIds.append(id);
    }

    deleteMessage["DeleteMessage"] = QJsonObject{{"group_id", groupId},
                                                 {"message_ids", jsonMessageIds}};

    QString requestBody = QJsonDocument(deleteMessage).toJson(QJsonDocument::Compact);
    return sendMessage(requestBody);
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

    // Parse the message
    QJsonDocument jsonDoc = QJsonDocument::fromJson(message.toUtf8());
    if (!jsonDoc.isObject()) {
        qWarning() << "Invalid JSON received:" << message;
        return;
    }
    QJsonObject messageObj = jsonDoc.object();

    // Emit signals based on the type of message
    if (messageObj.contains("DeleteMessageResponse")) {
        emit receivedMessage(message); // Pass to QML for error handling or logging
    } else if (messageObj.contains("DeleteMessageEvent")) {
        emit receivedMessage(message); // Pass to QML to update the UI
    } else {
        emit receivedMessage(message); // Handle other messages (like Receive)
    }
}

void WebSocketClient::onDisconnected()
{
    QTextStream(stdout) << "WebSocket disconnected." << Qt::endl;
    QCoreApplication::quit();
}
