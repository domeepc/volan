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

    //race prikaz
    Q_PROPERTY(double speed READ speed NOTIFY speedChanged)
    Q_PROPERTY(double soc READ soc NOTIFY socChanged)
    Q_PROPERTY(double temporary READ temporary NOTIFY temporaryChanged)
    Q_PROPERTY(QString mode READ mode NOTIFY modeChanged)
    Q_PROPERTY(QString preset READ preset NOTIFY presetChanged)

    //Strojarski prikaz
    Q_PROPERTY(double slip READ slip NOTIFY slipChanged)
    Q_PROPERTY(double motorTemperatureL READ motorTemperatureL NOTIFY motorTemperatureChanged)
    Q_PROPERTY(double motorTemperatureR READ motorTemperatureR NOTIFY motorTemperatureChanged)

    Q_PROPERTY(double rpmL READ rpmL NOTIFY rpmChanged)
    Q_PROPERTY(double rpmR READ rpmR NOTIFY rpmChanged)

    Q_PROPERTY(double brakePressureForward READ brakePressureForward NOTIFY brakePressureChanged)
    Q_PROPERTY(double brakePressureRear READ brakePressureRear NOTIFY brakePressureChanged)

    Q_PROPERTY(double inverterTemperatureL READ inverterTemperatureL NOTIFY inverterTemperatureChanged)
    Q_PROPERTY(double inverterTemperatureR READ inverterTemperatureR NOTIFY inverterTemperatureChanged)

    Q_PROPERTY(double torqueL READ torqueL NOTIFY torqueChanged)
    Q_PROPERTY(double torqueR READ torqueR NOTIFY torqueChanged)

    Q_PROPERTY(double cFactor1 READ cFactor1 NOTIFY cFactorsChanged)
    Q_PROPERTY(double cFactor2 READ cFactor2 NOTIFY cFactorsChanged)
    Q_PROPERTY(double cFactor3 READ cFactor3 NOTIFY cFactorsChanged)
    Q_PROPERTY(double cFactor4 READ cFactor4 NOTIFY cFactorsChanged)

public:
    explicit SignalHandler(QObject *parent = nullptr);
    double speed() const { return m_speed; }
    double soc() const { return m_soc; }
    double temporary() const{ return m_temporary;}

    double slip() const {return m_slip;};

    double motorTemperatureL() const {return m_motor_temperature_L;}
    double motorTemperatureR() const {return m_motor_temperature_R;}

    double rpmL() const {return m_rpm_L;};
    double rpmR() const {return m_rpm_R;};

    double brakePressureForward() const {return m_brake_forward;};
    double brakePressureRear() const {return m_brake_rear;};

    double inverterTemperatureL() const{return m_inverter_temperature_L;};
    double inverterTemperatureR() const{return m_inverter_temperature_R;};

    double torqueL() const{return m_torque_L;};
    double torqueR() const{return m_torque_R;};

    double cFactor1() const {return m_cFactor1;};
    double cFactor2() const {return m_cFactor2;};
    double cFactor3() const {return m_cFactor3;};
    double cFactor4() const {return m_cFactor4;};



    QString mode() const {return m_mode;}
    QString preset() const {return m_preset;}

public slots:
    void handleDecodedFrame(QtCanBus::UniqueId id, const QMap<QString, QVariant> &sigs);

signals:
    void speedChanged();
    void socChanged();
    void modeChanged();
    void presetChanged();
    void temporaryChanged();

    void slipChanged();
    void motorTemperatureChanged();
    void rpmChanged();
    void brakePressureChanged();
    void inverterTemperatureChanged();
    void torqueChanged();
    void cFactorsChanged();

private:
    double m_speed = 100.0;
    double m_soc = 75.0;
    double m_temporary = 75.0;

    QString m_mode = "default";
    QString m_preset = "default";

    double m_slip = 0.0;

    double m_motor_temperature_L = 0.0;
    double m_motor_temperature_R = 0.0;

    double m_rpm_L = 0.0;
    double m_rpm_R = 0.0;

    double m_brake_forward = 0.0;
    double m_brake_rear = 0.0;

    double m_inverter_temperature_L = 0.0;
    double m_inverter_temperature_R = 0.0;

    double m_torque_L = 0.0;
    double m_torque_R = 0.0;

    double m_cFactor1 = 0.0;
    double m_cFactor2 = 0.0;
    double m_cFactor3 = 0.0;
    double m_cFactor4 = 0.0;

    //treba dodat max i avg temperature za strojarski prikaz
    //treba definirat warning signale







};

#endif // SIGNALHANDLER_H
