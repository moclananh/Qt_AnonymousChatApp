// GroupData.cpp
#include "groupdata.h"

GroupData::GroupData(QObject *parent)
    : QObject(parent)
    , m_currentPage(1)
    , m_currentScrollIndex{0}
{}

QList<Message *> &GroupData::messages()
{
    return m_messages;
}

void GroupData::setMessages(const QList<Message *> &messages)
{
    if (m_messages != messages) {
        m_messages = messages;
        emit messagesChanged();
    }
}

int GroupData::currentPage() const
{
    return m_currentPage;
}

void GroupData::setCurrentPage(int page)
{
    if (m_currentPage != page) {
        m_currentPage = page;
        emit currentPageChanged();
    }
}

int GroupData::currentScrollIndex() const
{
    return m_currentScrollIndex;
}

void GroupData::setCurrentScrollIndex(int newCurrentScrollIndex)
{
    if (m_currentScrollIndex == newCurrentScrollIndex)
        return;
    m_currentScrollIndex = newCurrentScrollIndex;
    emit currentScrollIndexChanged();
}
