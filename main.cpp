#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "back.h"

int main(int argc, char *argv[]) {
  Back *back = new Back;

  QGuiApplication app(argc, argv);

  QQmlApplicationEngine engine;
  engine.rootContext()->setContextProperty("back", back);
  QObject::connect(
      &engine,

      &QQmlApplicationEngine::objectCreationFailed, &app,
      []() { QCoreApplication::exit(-1); }, Qt::QueuedConnection);
  engine.loadFromModule("volan", "Main");

  return app.exec();
}
