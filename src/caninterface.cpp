#include "caninterface.h"

CanInterface::CanInterface(QObject* parent)
    : QObject{parent},
      m_device(nullptr)

{}

bool CanInterface::start(const QString& interfaceName) {
  if (m_device) stop();

  m_interfaceName = interfaceName;

  m_device = QCanBus::instance()->createDevice("socketcan", interfaceName);

  if (!m_device) {
    emit errorOccurred("SocketCAN plugin missing");
    return false;
  }

  // kad primi okvir šalji signal
  connect(m_device, &QCanBusDevice::framesReceived, this,
          &CanInterface::onFramesReceived);

  // ako se greska dogodi posalji error signal
  connect(m_device, &QCanBusDevice::errorOccurred, this,
          &CanInterface::onErrorOccurred);

  // ako se CAN device iskljuci salji signal
  connect(m_device, &QCanBusDevice::stateChanged, this,
          &CanInterface::onStateChanged);

  if (!m_device->connectDevice()) {
    emit errorOccurred("Cannot connect CAN device!");
    delete m_device;
    m_device = nullptr;

    return false;
  }

  // QCanBusFrame frame;
  // frame.setFrameId(123);
  // QByteArray data = QByteArray::fromHex("55");
  // frame.setPayload(data);
  // sendFrame(frame);

  return true;
}

void CanInterface::stop() {
  if (!m_device) return;

  m_device->disconnectDevice();
  delete m_device;
  m_device = nullptr;
}

void CanInterface::sendFrame(const QCanBusFrame& frame) {
  if (!m_device->writeFrame(frame)) {
    qWarning() << "Failed to send frame with ID: " << frame.frameId() << " "
               << frame.payload();
  }
}

void CanInterface::onFramesReceived() {
  while (m_device->framesAvailable()) {
    emit frameReceived(m_device->readFrame());
  }
}

void CanInterface::onErrorOccurred(QCanBusDevice::CanBusError error) {
  if (error == QCanBusDevice::NoError) return;

  qDebug() << "CAN Error:" << error << m_device->errorString();

  stop();
}

void CanInterface::onStateChanged(QCanBusDevice::CanBusDeviceState state) {
  if (state == QCanBusDevice::UnconnectedState) {
    emit errorOccurred("CAN interface is disconnected");

  } else if (state == QCanBusDevice::ConnectedState) {
    emit connected();
  }
}
