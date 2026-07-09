#include "Plugin.h"
#include "Backend.h"
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QCoreApplication>

Plugin::Plugin()
{
}

Plugin::~Plugin()
{
}

void Plugin::registerQmlTypes(QQmlApplicationEngine *engine)
{
    Q_UNUSED(engine);
    qmlRegisterType<Backend>("org.uq.pluginexample", 1, 0, "Backend");
}


void Plugin::initialize()
{
    qDebug() << "Plugin initialized";
}

