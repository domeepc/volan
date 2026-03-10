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
    Q_PROPERTY(double soc READ soc NOTIFY stateOfBatteryValuesChanged)
    Q_PROPERTY(double sop READ sop NOTIFY stateOfBatteryValuesChanged)
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

    Q_PROPERTY(QString bmsState READ bmsState NOTIFY bmsStatesChanged)
    Q_PROPERTY(bool airPlus READ airPlus NOTIFY bmsStatesChanged)
    Q_PROPERTY(bool airMinus READ airMinus NOTIFY bmsStatesChanged)
    Q_PROPERTY(bool precharge READ precharge NOTIFY bmsStatesChanged)
    Q_PROPERTY(bool IMD_ok READ IMD_ok NOTIFY bmsStatesChanged)

    Q_PROPERTY(double bmsTotalCurrent READ bmsTotalCurrent NOTIFY bmsValuesChanged)
    Q_PROPERTY(double bmsTotalVoltage READ bmsTotalVoltage NOTIFY bmsValuesChanged)

    Q_PROPERTY(double NTC_Temperature1 READ NTC_Temperature1 NOTIFY NTC_TemperaturesChanged)
    Q_PROPERTY(double NTC_Temperature2 READ NTC_Temperature2 NOTIFY NTC_TemperaturesChanged)

    //
    Q_PROPERTY(double faultCount READ faultCount NOTIFY faultCountChanged)

public:
    explicit SignalHandler(QObject *parent = nullptr);

    //vcu
    double speed() const { return m_speed; }
    double temporary() const{ return m_temporary;}
    double slip() const {return m_slip;};
    double rpmL() const {return m_rpm_L;};
    double rpmR() const {return m_rpm_R;};
    double brakePressureForward() const {return m_brake_forward;};
    double brakePressureRear() const {return m_brake_rear;};
    double torqueL() const{return m_torque_L;};
    double torqueR() const{return m_torque_R;};
    double cFactor1() const {return m_cFactor1;};
    double cFactor2() const {return m_cFactor2;};
    double cFactor3() const {return m_cFactor3;};
    double cFactor4() const {return m_cFactor4;};
    QString mode() const {return m_mode;}
    QString preset() const {return m_preset;}

    //bms
    bool airPlus() const{return m_airPlus;};
    bool airMinus() const{return m_airMinus;};
    bool precharge() const{return m_precharge;};
    bool IMD_ok() const {return m_imd_ok;};
    QString bmsState() const {return m_bmsState;};

    double bmsTotalCurrent() const {return m_totalCurrent;};
    double bmsTotalVoltage() const {return m_totalVoltage;};

    double NTC_Temperature1() const {return m_ntcTemperatures[0];};
    double NTC_Temperature2() const {return m_ntcTemperatures[1];};

    double sop() const {return m_sop;};
    double soc() const { return m_soc; }



    //inverteri
    double motorTemperatureL() const {return m_motor_temperature_L;}
    double motorTemperatureR() const {return m_motor_temperature_R;}
    double inverterTemperatureL() const{return m_inverter_temperature_L;};
    double inverterTemperatureR() const{return m_inverter_temperature_R;};
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

    






    //
    int faultCount() const {return m_faultCount;};

public slots:
    void handleDecodedFrame(QtCanBus::UniqueId id, const QMap<QString, QVariant> &sigs);

signals:
    //vcu
    void speedChanged();
    void modeChanged();
    void presetChanged();
    void temporaryChanged();
    void slipChanged();
    void rpmChanged();
    void brakePressureChanged();
    void torqueChanged();
    void cFactorsChanged();

    //bms
    void stateOfBatteryValuesChanged();
    void bmsStatesChanged();
    void bmsValuesChanged();
    void NTC_TemperaturesChanged();

    //inverter
    void motorTemperatureChanged();
    void inverterTemperatureChanged();
    void ERPMsChanged();
    void ACsChanged();
    void DriveEnableStatesChanged();
    void DigitalOutputsChanged();

    void faultCountChanged();


    //


private:
    //treba dodat max i avg temperature za strojarski prikaz
    //treba definirat warning signale

    //inverteri
    double m_ERPM_L = -32768;
    double m_ERPM_R = -32768;
    double m_AC_L = -300.0;
    double m_AC_R = -300.0;
    double m_inverter_temperature_L = 0.0;
    double m_inverter_temperature_R = 0.0;
    double m_motor_temperature_L = 0.0;
    double m_motor_temperature_R = 0.0;

    bool m_DriveEnableStateL = false;
    bool m_DriveEnableStateR = false;
    bool m_digitalOutputsL[4] = {false, false, false, false};
    bool m_digitalOutputsR[4] = {false, false, false, false};

    //bms
    bool m_airPlus = false;
    bool m_airMinus = false;
    bool m_precharge = false;
    bool m_imd_ok = true;
    QString m_bmsState = "default";


    double m_totalCurrent = 0.0;// double m_batteryCurrent = 0.0;
    double m_totalVoltage = 0.0;

    double m_sop = 0.0;
    double m_soc = 75.0;
    double m_ntcTemperatures[2] = {0.0, 0.0};

    static constexpr int m_moduleCount = 6;
    static constexpr int m_sensorCount = 32;
    static constexpr int m_totalSensors = m_moduleCount * m_sensorCount;
    std::array<std::array<double, m_sensorCount>, m_moduleCount> m_moduleTemperatures = {};

    std::array<std::array<double, 6>, m_moduleCount> m_moduleVoltages = {};


    //vcu
    double m_speed = 100.0;
    double m_temporary = 75.0;
    double m_slip = 0.0;
    double m_rpm_L = 0.0;
    double m_rpm_R = 0.0;
    double m_brake_forward = 0.0;
    double m_brake_rear = 0.0;
    double m_torque_L = 0.0;
    double m_torque_R = 0.0;

    double m_cFactor1 = 0.0;
    double m_cFactor2 = 0.0;
    double m_cFactor3 = 0.0;
    double m_cFactor4 = 0.0;


    double m_vcuCurrent = 0.0;
    double m_apps[2] = {0.0, 0.0};
    double m_bpps[2] = {0.0, 0.0};
    double m_swAngle[2] = {0.0, 0.0};
    double m_accelerationX = 0.0;
    double m_accelerationY = 0.0;
    double m_accelerationZ = 0.0;
    double m_gyroZ = 0.0;



    QString m_mode = "default";
    QString m_preset = "default";

    //digitalna stanja
    //pdm podaci




    

    //mijenjat ce se ovo je za testiranje prikaza
    int m_faultCount = 3;
    




};

#endif // SIGNALHANDLER_H
