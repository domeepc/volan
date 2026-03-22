#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>


#include "caninterface.h"
#include "dbcmanager.h"
#include "canmessageprocessor.h"
#include "signalhandler.h"
#include "bmssignalhandler.h"
#include "vcusignalhandler.h"
#include "invertersignalhandler.h"

int main(int argc, char *argv[]) {

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    CanInterface canInterface;
    canInterface.start("vcan0");

    QString path ="/home/pmales/Desktop/Projects/Fesb Racing/can1_vehicle.dbc";
    DbcManager DBCparser;
    if(!DBCparser.load(path)){
        qDebug() << "Could not parse file!";
    }
    else {
        qDebug() << "DBC parsed succesfully.";
        //DBCparser.printMessages();
    }

    CanMessageProcessor processor;
    processor.setUniqueIDDescription(DBCparser.getIdDescription());
    processor.setMessages(DBCparser.getMessages());

    SignalHandler *signalHandler = new SignalHandler(&engine);


    engine.rootContext()->setContextProperty("signalHandler", signalHandler);


    QObject::connect(&canInterface, &CanInterface::frameReceived, &processor, &CanMessageProcessor::processFrame);

    QObject::connect(&processor, &CanMessageProcessor::frameDecoded, signalHandler, &SignalHandler::handleDecodedFrame);
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("volan", "Main");

    return app.exec();
}
