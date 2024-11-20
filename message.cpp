// Message.cpp
#include "Message.h"

Message::Message(QObject *parent)
    : QObject(parent)
    , m_msId(0)
    , m_userId(0)
{}

int Message::ms_id() const
{
    return m_msId;
}

void Message::setMsId(int ms_id)
{
    if (m_msId != ms_id) {
        m_msId = ms_id;
        emit msIdChanged();
    }
}

QString Message::sender() const
{
    return m_sender;
}

void Message::setSender(const QString &sender)
{
    if (m_sender != sender) {
        m_sender = sender;
        emit senderChanged();
    }
}

QString Message::message() const
{
    return m_message;
}

void Message::setMessage(const QString &message)
{
    if (m_message != message) {
        m_message = message;
        emit messageChanged();
    }
}

QString Message::time() const
{
    return m_time;
}

void Message::setTime(const QString &time)
{
    if (m_time != time) {
        m_time = time;
        emit timeChanged();
    }
}

QString Message::image() const
{
    return m_image;
}

void Message::setImage(const QString &image)
{
    if (m_image != image) {
        m_image = image;
        emit imageChanged();
    }
}

QString Message::messageType() const
{
    return m_messageType;
}

void Message::setMessageType(const QString &messageType)
{
    if (m_messageType != messageType) {
        m_messageType = messageType;
        emit messageTypeChanged();
    }
}

int Message::userId() const
{
    return m_userId;
}

void Message::setUserId(int user_id)
{
    if (m_userId != user_id) {
        m_userId = user_id;
        emit userIdChanged();
    }
}

QString Message::createdAt() const
{
    return m_createdAt;
}

void Message::setCreatedAt(const QString &createdAt)
{
    if (m_createdAt != createdAt) {
        m_createdAt = createdAt;
        emit createdAtChanged();
    }
}
