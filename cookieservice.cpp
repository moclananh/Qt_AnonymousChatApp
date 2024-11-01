#include "cookieservice.h"

CookieService::CookieService(QObject *parent)
    : QObject(parent)
    , m_settings("AnonymousChat", "AnonymousChatApp")
{}

void CookieService::saveCookie(const QString &key, const QVariant &value, int expirationTimeMs)
{
    m_settings.setValue(key, value);
    m_settings.setValue(key + "_expiration",
                        QDateTime::currentDateTime().addMSecs(expirationTimeMs));
}

QVariant CookieService::loadCookie(const QString &key)
{
    QDateTime expirationTime = m_settings.value(key + "_expiration").toDateTime();
    if (QDateTime::currentDateTime() > expirationTime) {
        m_settings.remove(key);
        m_settings.remove(key + "_expiration");
        return QVariant(); // Data is expired
    }
    return m_settings.value(key);
}

void CookieService::removeCookie()
{
    // Remove user_id and its expiration
    m_settings.remove("user_id");
    m_settings.remove("user_id_expiration");
    qDebug() << "User logged out. Cookie cleared.";
}
