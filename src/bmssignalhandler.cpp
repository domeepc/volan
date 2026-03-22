#include "bmssignalhandler.h"
#include <QDebug>

BmsSignalHandler::BmsSignalHandler(QObject* parent)
    : QObject(parent)
{
    // STATE
    signal_map["BMS_StateID"] = [this](const QVariant &v){
        QString val = v.toString();
        if (m_state != val) {
            m_state = val;
            emit statesChanged();
        }
    };

    signal_map["AIR_Plus"] = [this](const QVariant &v){
        bool val = v.toBool();
        if (m_air_plus != val) {
            m_air_plus = val;
            emit statesChanged();
        }
    };

    signal_map["AIR_Minus"] = [this](const QVariant &v){
        bool val = v.toBool();
        if (m_air_minus != val) {
            m_air_minus = val;
            emit statesChanged();
        }
    };

    signal_map["Precharge_Relay"] = [this](const QVariant &v){
        bool val = v.toBool();
        if (m_precharge != val) {
            m_precharge = val;
            emit statesChanged();
        }
    };

    signal_map["IMD_OK"] = [this](const QVariant &v){
        bool val = v.toBool();
        if (m_imd_ok != val) {
            m_imd_ok = val;
            emit statesChanged();
        }
    };

    // BATTERY STATE
    signal_map["SOC"] = [this](const QVariant &v){
        double val = v.toDouble();
        if (m_soc != val) {
            m_soc = val;
            emit stateOfBatteryValuesChanged();
        }
    };

    signal_map["SOH"] = [this](const QVariant &v){
        double val = v.toDouble();
        if (m_soh != val) {
            m_soh = val;
            emit stateOfBatteryValuesChanged();
        }
    };

    signal_map["SOP"] = [this](const QVariant &v){
        double val = v.toDouble();
        if (m_sop != val) {
            m_sop = val;
            emit stateOfBatteryValuesChanged();
        }
    };

    // VALUES
    signal_map["TotalCurrent"] = [this](const QVariant &v){
        double val = v.toDouble();
        if (m_total_current != val) {
            m_total_current = val;
            emit valuesChanged();
        }
    };

    signal_map["TotalVoltage"] = [this](const QVariant &v){
        double val = v.toDouble();
        if (m_total_voltage != val) {
            m_total_voltage = val;
            emit valuesChanged();
        }
    };
}


void BmsSignalHandler::processSignal(const QString& name, const QVariant& value, const QString& messageName){

}

void BmsSignalHandler::processFrame(const QString& messageName, const QMap<QString, QVariant>& sigs)
{
    int moduleIndex;

    // TEMPERATURE FRAMES
    if (messageName.startsWith("BMS_Temp_M")) {
        QString numberPart = messageName.section('M', 2, 2).section('_', 0, 0);
        moduleIndex = numberPart.toInt() / 2;

        if (module_temperatures[moduleIndex].messageCount == 2) {
            emit temperaturesChanged();
            module_temperatures[moduleIndex].reset();
        }

        for (auto it = sigs.begin(); it != sigs.end(); ++it) {
            if (it.key().startsWith("Temp_") && it.key() != "Temp_Group") {
                module_temperatures[moduleIndex].update(it.value().toDouble());
            }
        }

        module_temperatures[moduleIndex].messageCount++;
        return;
    }

    // VOLTAGE FRAMES
    if (messageName.startsWith("BMS_Voltage_M")) {
        QString numberPart = messageName.section('M', 2, 2).section('_', 0, 0);
        moduleIndex = numberPart.toInt() / 2;

        if (module_voltages[moduleIndex].messageCount == 2) {
            emit voltagesChanged();
            module_voltages[moduleIndex].reset();
        }

        for (auto it = sigs.begin(); it != sigs.end(); ++it) {
            if (it.key().startsWith("Cell_")) {
                module_voltages[moduleIndex].update(it.value().toDouble());
            }
        }

        module_voltages[moduleIndex].messageCount++;
        return;
    }

    // NORMAL SIGNALS
    for (auto it = sigs.begin(); it != sigs.end(); ++it) {
        //processSignal(it.key(), it.value());
    }
}

QVector<double> BmsSignalHandler::voltageMin() const {
    QVector<double> r;
    for (const auto &m : module_voltages) r.push_back(m.min);
    return r;
}

QVector<double> BmsSignalHandler::voltageMax() const {
    QVector<double> r;
    for (const auto &m : module_voltages) r.push_back(m.max);
    return r;
}

QVector<double> BmsSignalHandler::temperatureMin() const {
    QVector<double> r;
    for (const auto &m : module_temperatures) r.push_back(m.min);
    return r;
}

QVector<double> BmsSignalHandler::temperatureAvg() const {
    QVector<double> r;
    for (const auto &m : module_temperatures) r.push_back(m.avg());
    return r;
}

QVector<double> BmsSignalHandler::temperatureMax() const {
    QVector<double> r;
    for (const auto &m : module_temperatures) r.push_back(m.max);
    return r;
}

QVector<double> BmsSignalHandler::ntcTemperature() const {
    return {m_ntc_temperatures[0], m_ntc_temperatures[1]};
}

double BmsSignalHandler::avgTemperature() const {
    double sum = 0.0;
    int count = 0;
    for(int i = 0; i < 6; i++){
        sum += module_temperatures[i].sum;
        count += module_temperatures[i].count;
    }
    return (double)sum/count;
}

double BmsSignalHandler::maxTemperature() const {
    double max = -20.0;
    for (int i = 0; i < 6; ++i) {
        if(module_temperatures[i].max > max){
            max = module_temperatures[i].max;
        }
    }

    return max;
}
