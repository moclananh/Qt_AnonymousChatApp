#ifndef NETWORKMANAGER_H
#define NETWORKMANAGER_H

#include <QMap>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QObject>

class NetworkManager : public QObject
{
    Q_OBJECT
public:
    explicit NetworkManager(QObject *parent = nullptr);

    Q_INVOKABLE void fetchData(const QString &url,
                               const QString &method,
                               const QVariant &headers = {},
                               const QByteArray &data = QByteArray());

signals:
    void dataReceived(const QString &response);
    void statusCodeReceived(const QString &statusCode);
    void requestError(const QString &error);

private slots:
    void onResult(QNetworkReply *reply);

private:
    QNetworkAccessManager *networkManager;
};

#endif // NETWORKMANAGER_H
