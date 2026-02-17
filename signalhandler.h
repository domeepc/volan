#ifndef SIGNALHANDLER_H
#define SIGNALHANDLER_H

#include <QObject>
#include <QVariantMap>


#include <QCanFrameProcessor>
#include <QCanBusFrame>
#include <QCanBus>


class SignalHandler : public QObject
{
    Q_OBJECT

    Q_PROPERTY(double speed READ speed NOTIFY speedChanged)
    Q_PROPERTY(double soc READ soc NOTIFY socChanged)

public:
    explicit SignalHandler(QObject *parent = nullptr);
    double speed() const { return m_speed; }
    double soc() const { return m_soc; }
public slots:
    void handleDecodedFrame(QtCanBus::UniqueId id, const QMap<QString, QVariant> &sigs);

signals:
    void speedChanged();
    void socChanged();

private:
    double m_speed = 0.0;
    double m_soc = 0.0;
};

#endif // SIGNALHANDLER_H
