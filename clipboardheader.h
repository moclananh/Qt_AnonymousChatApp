// ClipboardHelper.h
#include <QClipboard>
#include <QGuiApplication>
#include <QObject>

class ClipboardHelper : public QObject
{
    Q_OBJECT
public:
    explicit ClipboardHelper(QObject *parent = nullptr)
        : QObject(parent)
    {}

    Q_INVOKABLE void setText(const QString &text) { QGuiApplication::clipboard()->setText(text); }
};
