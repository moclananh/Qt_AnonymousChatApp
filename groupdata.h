// GroupData.h
#ifndef GROUPDATA_H
#define GROUPDATA_H

#include <QList>
#include <QObject>
#include "Message.h"

class GroupData : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QList<Message *> messages READ messages WRITE setMessages NOTIFY messagesChanged)
    Q_PROPERTY(int currentPage READ currentPage WRITE setCurrentPage NOTIFY currentPageChanged)
    Q_PROPERTY(int currentScrollIndex READ currentScrollIndex WRITE setCurrentScrollIndex NOTIFY
                   currentScrollIndexChanged FINAL)
public:
    GroupData(QObject *parent = nullptr);

    QList<Message *> &messages();
    void setMessages(const QList<Message *> &messages);

    int currentPage() const;
    void setCurrentPage(int page);

    int currentScrollIndex() const;
    void setCurrentScrollIndex(int newCurrentScrollIndex);

signals:
    void messagesChanged();
    void currentPageChanged();
    void currentScrollIndexChanged();

private:
    QList<Message *> m_messages;
    int m_currentPage;
    int m_currentScrollIndex;
};

#endif // GROUPDATA_H
