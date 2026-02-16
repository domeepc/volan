#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>


#include "caninterface.h"
#include "dbcmanager.h"
#include "canmessageprocessor.h"

int main(int argc, char *argv[]) {
  //Back *back = new Back;

  QGuiApplication app(argc, argv);
  QQmlApplicationEngine engine;

  CanInterface canInterface;
  canInterface.start("vcan0");

  engine.rootContext()->setContextProperty(QStringLiteral("canInterface"), &canInterface);

  QString path ="/home/pmales/Desktop/volan/volantest/dbcfile.dbc";
  DbcManager DBCparser;
  if(!DBCparser.load(path)){
      qDebug() << "Could not parse file!";
  }
  else DBCparser.printMessages();



  CanMessageProcessor processor;
  processor.setUniqueIDDescription(DBCparser.getIdDescription());
  processor.setMessages(DBCparser.getMessages());


  QObject::connect(&canInterface, &CanInterface::frameReceived, &processor, &CanMessageProcessor::processFrame);

  QObject::connect(
      &engine,
      &QQmlApplicationEngine::objectCreationFailed,
      &app,
      []() { QCoreApplication::exit(-1); },
      Qt::QueuedConnection);
  engine.loadFromModule("volan", "Main");

  return app.exec();
}
