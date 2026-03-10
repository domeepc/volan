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

    Q_PROPERTY(double ERPM_L READ ERPM_L NOTIFY ERPMsChanged)
    Q_PROPERTY(double ERPM_R READ ERPM_R NOTIFY ERPMsChanged)

    Q_PROPERTY(double AC_L READ AC_L NOTIFY ACsChanged)
    Q_PROPERTY(double AC_R READ AC_R NOTIFY ACsChanged)

    Q_PROPERTY(bool LdigitalOutput1 READ LdigitalOutput1 NOTIFY DigitalOutputsChanged)
    Q_PROPERTY(bool LdigitalOutput2 READ LdigitalOutput2 NOTIFY DigitalOutputsChanged)
    Q_PROPERTY(bool LdigitalOutput3 READ LdigitalOutput3 NOTIFY DigitalOutputsChanged)
    Q_PROPERTY(bool LdigitalOutput4 READ LdigitalOutput4 NOTIFY DigitalOutputsChanged)

    Q_PROPERTY(bool RdigitalOutput1 READ RdigitalOutput1 NOTIFY DigitalOutputsChanged)
    Q_PROPERTY(bool RdigitalOutput2 READ RdigitalOutput2 NOTIFY DigitalOutputsChanged)
    Q_PROPERTY(bool RdigitalOutput3 READ RdigitalOutput3 NOTIFY DigitalOutputsChanged)
    Q_PROPERTY(bool RdigitalOutput4 READ RdigitalOutput4 NOTIFY DigitalOutputsChanged)

    Q_PROPERTY(bool LDriveEnableState READ LDriveEnableState NOTIFY DriveEnableStatesChanged)
    Q_PROPERTY(bool RDriveEnableState READ RDriveEnableState NOTIFY DriveEnableStatesChanged)

    //
    Q_PROPERTY(double faultCount READ faultCount NOTIFY faultCountChanged)

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

    double ERPM_L() const {return m_ERPM_L;};
    double ERPM_R() const {return m_ERPM_R;};

    double AC_L() const {return m_AC_L;};
    double AC_R() const {return m_AC_R;};


    bool LdigitalOutput1() const {return m_digitalOutputsL[0];};
    bool LdigitalOutput2() const {return m_digitalOutputsL[1];};
    bool LdigitalOutput3() const {return m_digitalOutputsL[2];};
    bool LdigitalOutput4() const {return m_digitalOutputsL[3];};

    bool RdigitalOutput1() const {return m_digitalOutputsR[0];};
    bool RdigitalOutput2() const {return m_digitalOutputsR[1];};
    bool RdigitalOutput3() const {return m_digitalOutputsR[2];};
    bool RdigitalOutput4() const {return m_digitalOutputsR[3];};

    bool LDriveEnableState() const {return m_DriveEnableStateL;};
    bool RDriveEnableState() const {return m_DriveEnableStateR;};


    QString mode() const {return m_mode;}
    QString preset() const {return m_preset;}


    //
    int faultCount() const {return m_faultCount;};

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

    void ERPMsChanged();
    void ACsChanged();

    void DriveEnableStatesChanged();
    void DigitalOutputsChanged();

    //
    void faultCountChanged();

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

    double m_ERPM_L = -32768;
    double m_ERPM_R = -32768;

    double m_AC_L = -300.0;
    double m_AC_R = -300.0;


    bool m_DriveEnableStateL = false;
    bool m_DriveEnableStateR = false;
    bool m_digitalOutputsL[4] = {false, false, false, false};
    bool m_digitalOutputsR[4] = {false, false, false, false};



    //mijenjat ce se ovo je za testiranje prikaza
    int m_faultCount = 3;
    







};

#endif // SIGNALHANDLER_H
