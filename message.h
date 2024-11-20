// Message.h
#ifndef MESSAGE_H
#define MESSAGE_H

#include <QObject>
#include <QString>

class Message : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int ms_id READ ms_id WRITE setMsId NOTIFY msIdChanged)
    Q_PROPERTY(QString sender READ sender WRITE setSender NOTIFY senderChanged)
    Q_PROPERTY(QString message READ message WRITE setMessage NOTIFY messageChanged)
    Q_PROPERTY(QString time READ time WRITE setTime NOTIFY timeChanged)
    Q_PROPERTY(QString image READ image WRITE setImage NOTIFY imageChanged)
    Q_PROPERTY(QString message_type READ messageType WRITE setMessageType NOTIFY messageTypeChanged)
    Q_PROPERTY(int user_id READ userId WRITE setUserId NOTIFY userIdChanged)
    Q_PROPERTY(QString created_at READ createdAt WRITE setCreatedAt NOTIFY createdAtChanged)

public:
    explicit Message(QObject *parent = nullptr);

    int ms_id() const;
    void setMsId(int ms_id);

    QString sender() const;
    void setSender(const QString &sender);

    QString message() const;
    void setMessage(const QString &message);

    QString time() const;
    void setTime(const QString &time);

    QString image() const;
    void setImage(const QString &image);

    QString messageType() const;
    void setMessageType(const QString &messageType);

    int userId() const;
    void setUserId(int user_id);

    QString createdAt() const;
    void setCreatedAt(const QString &createdAt);

signals:
    void msIdChanged();
    void senderChanged();
    void messageChanged();
    void timeChanged();
    void imageChanged();
    void messageTypeChanged();
    void userIdChanged();
    void createdAtChanged();

private:
    int m_msId;
    QString m_sender;
    QString m_message;
    QString m_time;
    QString m_image;
    QString m_messageType;
    int m_userId;
    QString m_createdAt;
};

#endif // MESSAGE_H
