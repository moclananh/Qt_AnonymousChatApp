#ifndef SETTINGSMANAGER_H
#define SETTINGSMANAGER_H

#include <QDateTime>
#include <QObject>
#include <QSettings>

class CookieService : public QObject
{
    Q_OBJECT

public:
    explicit CookieService(QObject *parent = nullptr);

    // Method to save data with expiration time
    Q_INVOKABLE void saveCookie(const QString &key, const QVariant &value, int expirationTimeMs);

    // Method to load data, checks expiration
    Q_INVOKABLE QVariant loadCookie(const QString &key);

    // Method to logout and clear cookies
    Q_INVOKABLE void removeCookie();

private:
    QSettings m_settings;
};

#endif // SETTINGSMANAGER_H
