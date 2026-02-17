#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>


#include "caninterface.h"
#include "dbcmanager.h"
#include "canmessageprocessor.h"
#include "signalhandler.h"

int main(int argc, char *argv[]) {
  //Back *back = new Back;

  QGuiApplication app(argc, argv);
  QQmlApplicationEngine engine;




  CanInterface canInterface;
  canInterface.start("vcan0");

  QString path ="/home/pmales/Desktop/volan/volantest/dbcfile.dbc";
  DbcManager DBCparser;
  if(!DBCparser.load(path)){
      qDebug() << "Could not parse file!";
  }
  else DBCparser.printMessages();



  CanMessageProcessor processor;
  processor.setUniqueIDDescription(DBCparser.getIdDescription());
  processor.setMessages(DBCparser.getMessages());

  SignalHandler signalHandler;
  engine.rootContext()->setContextProperty("signalHandler", &signalHandler);


  QObject::connect(&canInterface, &CanInterface::frameReceived, &processor, &CanMessageProcessor::processFrame);

  QObject::connect(&processor, &CanMessageProcessor::frameDecoded, &signalHandler, &SignalHandler::handleDecodedFrame);
  QObject::connect(
      &engine,
      &QQmlApplicationEngine::objectCreationFailed,
      &app,
      []() { QCoreApplication::exit(-1); },
      Qt::QueuedConnection);
  engine.loadFromModule("volan", "Main");

  return app.exec();
}
