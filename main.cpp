#include <QCursor>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "caninterface.h"

int main(int argc, char *argv[]) {
  //Back *back = new Back;

  QGuiApplication app(argc, argv);
  QQmlApplicationEngine engine;

  CanInterface canInterface;
  canInterface.start("vcan0");

  engine.rootContext()->setContextProperty(QStringLiteral("canInterface"), &canInterface);


  QObject::connect(
      &engine,
      &QQmlApplicationEngine::objectCreationFailed,
      &app,
      []() { QCoreApplication::exit(-1); },
      Qt::QueuedConnection);
  engine.loadFromModule("volan", "Main");

  return app.exec();
}
