#include "NetworkManager.h"
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>

NetworkManager::NetworkManager(QObject *parent)
    : QObject(parent)
{
    networkManager = new QNetworkAccessManager(this);
    connect(networkManager, &QNetworkAccessManager::finished, this, &NetworkManager::onResult);
}

void NetworkManager::fetchData(const QString &url,
                               const QString &method,
                               const QVariant &headers,
                               const QByteArray &data)
{
    QUrl requestUrl(url);
    QNetworkRequest request(requestUrl);

    QVariantMap headersMap = headers.toMap();
    qDebug() << "headerObject: " << headersMap;
    // Set headers
    for (auto it = headersMap.begin(); it != headersMap.end(); ++it) {
        qDebug() << "Header: " << it.key() << ", value: " << it.value();
        request.setRawHeader(it.key().toUtf8(), it.value().toString().toUtf8());
    }

    // Determine the HTTP method and send the request
    if (method.toUpper() == "GET") {
        networkManager->get(request);
    } else if (method.toUpper() == "POST") {
        request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
        networkManager->post(request, data);
    } else if (method.toUpper() == "PUT") {
        request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
        networkManager->put(request, data);
    } else if (method.toUpper() == "DELETE") {
        networkManager->deleteResource(request);
    } else {
        emit requestError("Unsupported HTTP method: " + method);
    }
}

void NetworkManager::onResult(QNetworkReply *reply)
{
    if (reply->error() == QNetworkReply::NoError) {
        QByteArray responseData = reply->readAll();
        QJsonDocument jsonDoc = QJsonDocument::fromJson(responseData);
        if (jsonDoc.isObject()) {
            QJsonObject jsonObj = jsonDoc.object();
            emit dataReceived(QString::fromUtf8(responseData)); // Emit raw data for parsing in QML
        }
    } else {
        emit requestError("Error: " + reply->errorString());
    }
    reply->deleteLater();
}