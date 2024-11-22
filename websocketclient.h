#ifndef WEBSOCKETCLIENT_H
#define WEBSOCKETCLIENT_H

#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QCoreApplication>
#include <QTextStream>
#include <QTimer>
#include <QtWebSockets/QtWebSockets>

class WebSocketClient : public QObject
{
    Q_OBJECT
public:
    WebSocketClient(const QUrl &url, QObject *parent = nullptr);
    Q_INVOKABLE bool sendMessage(const QString &body);
    Q_INVOKABLE bool deleteMessage(int groupId, const QList<int> &messageIds);
    Q_INVOKABLE void open();
    Q_INVOKABLE void setUserCode(const QString &user_code);
private slots:
    void onConnected();
    void onTextMessageReceived(const QString &message);
    void onDisconnected();
signals:
    void receivedMessage(const QString &message);

private:
    QWebSocket *socket;
    QUrl url;
    QString m_userCode;
};
#endif // WEBSOCKETCLIENT_H
