#ifndef APPSTATE_H
#define APPSTATE_H
#include <QObject>
class AppState : public QObject
{
    Q_OBJECT
public:
    AppState();
    AppState(QObject *parent = nullptr);
signals:
    void successSignal();
    void groupIdSignal(int groupId);
};

#endif // APPSTATE_H
