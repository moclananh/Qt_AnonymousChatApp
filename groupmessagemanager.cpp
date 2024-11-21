// GroupMessageManager.cpp
#include "GroupMessageManager.h"
#include <QDebug>

GroupMessageManager::GroupMessageManager(QObject *parent)
    : QObject(parent)
{}

void GroupMessageManager::addMessage(int groupId,
                                     int ms_id,
                                     const QString &sender,
                                     const QString &message,
                                     const QString &time,
                                     const QString &messageType,
                                     int userId,
                                     const QString &createdAt)
{
    if (!m_groupMessages.contains(groupId)) {
        m_groupMessages.insert(groupId, new GroupData(this));
    }

    Message *newMessage = new Message(this);
    newMessage->setMsId(ms_id);
    newMessage->setSender(sender);
    newMessage->setMessage(message);
    newMessage->setTime(time);
    newMessage->setImage("https://placehold.co/50x50");
    newMessage->setMessageType(messageType);
    newMessage->setUserId(userId);
    newMessage->setCreatedAt(createdAt);

    m_groupMessages[groupId]->messages().append(newMessage);
    // qDebug() << "void GroupMessageManager::addMessage: groupId: " << groupId;
    // qDebug() << "void GroupMessageManager::addMessage: group messages: "
    //          << m_groupMessages[groupId]->messages().size();
    emit groupMessagesChanged();
}

void GroupMessageManager::pushFrontMessage(int groupId,
                                           int ms_id,
                                           const QString &sender,
                                           const QString &message,
                                           const QString &time,
                                           const QString &messageType,
                                           int userId,
                                           const QString &createdAt)
{
    if (!m_groupMessages.contains(groupId)) {
        m_groupMessages.insert(groupId, new GroupData(this));
    }

    Message *newMessage = new Message(this);
    newMessage->setMsId(ms_id);
    newMessage->setSender(sender);
    newMessage->setMessage(message);
    newMessage->setTime(time);
    newMessage->setImage("https://placehold.co/50x50");
    newMessage->setMessageType(messageType);
    newMessage->setUserId(userId);
    newMessage->setCreatedAt(createdAt);

    m_groupMessages[groupId]->messages().push_front(newMessage);
    qDebug() << "void GroupMessageManager::addMessage: groupId: " << groupId;
    qDebug() << "void GroupMessageManager::addMessage: group messages: "
             << m_groupMessages[groupId]->messages().size();
    emit groupMessagesChanged();
}

QList<Message *> GroupMessageManager::getMessages(int groupId) const
{
    if (m_groupMessages.contains(groupId)) {
        return m_groupMessages[groupId]->messages();
    }
    return QList<Message *>();
}

void GroupMessageManager::removeMessage(int groupId, int ms_id)
{
    if (m_groupMessages.contains(groupId)) {
        QList<Message *> messages = m_groupMessages[groupId]->messages();
        for (int i = 0; i < messages.size(); ++i) {
            if (messages[i]->ms_id() == ms_id) {
                m_groupMessages[groupId]->messages().removeAt(i);
                break;
            }
        }
        emit groupMessagesChanged();
    }
}

void GroupMessageManager::setCurrentPage(int groupId, int page)
{
    if (m_groupMessages.contains(groupId)) {
        m_groupMessages[groupId]->setCurrentPage(page);
    }
}

int GroupMessageManager::getCurrentPage(int groupId) const
{
    if (m_groupMessages.contains(groupId)) {
        return m_groupMessages[groupId]->currentPage();
    }
    return 1; // Or another value to indicate non-existent group
}

void GroupMessageManager::setCurrentScrollIndex(int groupId, int currentIndex)
{
    if (m_groupMessages.contains(groupId)) {
        m_groupMessages[groupId]->setCurrentScrollIndex(currentIndex);
    }
}

int GroupMessageManager::getCurrentScrollIndex(int groupId) const
{
    if (m_groupMessages.contains(groupId)) {
        return m_groupMessages[groupId]->currentScrollIndex();
    }
    return 1; // Or another value to indicate non-existent group
}

int GroupMessageManager::getSize(int groupId) const
{
    return m_groupMessages[groupId]->messages().size();
}

QHash<int, GroupData *> GroupMessageManager::groupMessages() const
{
    return m_groupMessages;
}
