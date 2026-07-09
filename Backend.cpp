#include "Backend.h"

Backend::Backend(QObject *parent)
    : QObject(parent)
    , m_message("Hello from Backend")
    , m_counter(0)
{
}

QString Backend::message() const
{
    return m_message;
}

void Backend::setMessage(const QString &newMessage)
{
    if (m_message != newMessage) {
        m_message = newMessage;
        emit messageChanged();
    }
}

int Backend::counter() const
{
    return m_counter;
}

QString Backend::sayHello(const QString &name)
{
    QString greeting = QString("Hello, %1!").arg(name);
    emit helloSaid(greeting);
    return greeting;
}

void Backend::incrementCounter()
{
    m_counter++;
    emit counterChanged();
}

int Backend::addNumbers(int a, int b)
{
    return a + b;
}