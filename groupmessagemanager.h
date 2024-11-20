// GroupMessageManager.h
#ifndef GROUPMESSAGEMANAGER_H
#define GROUPMESSAGEMANAGER_H

#include <QHash>
#include <QObject>
#include "GroupData.h"
#include "Message.h"

class GroupMessageManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QHash<int, GroupData *> groupMessages READ groupMessages NOTIFY groupMessagesChanged)

public:
    explicit GroupMessageManager(QObject *parent = nullptr);
    Q_INVOKABLE void addMessage(int groupId,
                                int ms_id,
                                const QString &sender,
                                const QString &message,
                                const QString &time,
                                const QString &messageType,
                                int userId,
                                const QString &createdAt);
    Q_INVOKABLE void pushFrontMessage(int groupId,
                                      int ms_id,
                                      const QString &sender,
                                      const QString &message,
                                      const QString &time,
                                      const QString &messageType,
                                      int userId,
                                      const QString &createdAt);
    Q_INVOKABLE QList<Message *> getMessages(int groupId) const;
    Q_INVOKABLE void removeMessage(int groupId, int ms_id);
    Q_INVOKABLE void setCurrentPage(int groupId, int page);
    Q_INVOKABLE int getCurrentPage(int groupId) const;
    Q_INVOKABLE int getSize(int groupId) const;

    Q_INVOKABLE void setCurrentScrollIndex(int groupId, int currentIndex);
    Q_INVOKABLE int getCurrentScrollIndex(int groupId) const;

    QHash<int, GroupData *> groupMessages() const;

signals:
    void groupMessagesChanged();

private:
    QHash<int, GroupData *> m_groupMessages;
};

#endif // GROUPMESSAGEMANAGER_H
