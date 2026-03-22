#include "invertersignalhandler.h"

InverterSignalHandler::InverterSignalHandler(QObject* parent)
    : QObject(parent)
{
    // helper for unpacking bits
    auto unpack4 = [](uint8_t raw, std::array<bool,4>& out){
        for (int i = 0; i < 4; i++)
            out[i] = (raw >> i) & 1;
    };

    auto unpack8 = [](uint8_t raw, std::array<bool,8>& out){
        for (int i = 0; i < 8; i++)
            out[i] = (raw >> i) & 1;
    };

    auto unpack3 = [](uint8_t raw, std::array<bool,3>& out){
        for (int i = 0; i < 3; i++)
            out[i] = (raw >> i) & 1;
    };

    // -------- LEFT --------

    signal_map["L_Motor_Temp"] = [this](const QVariant &v){
        double val = v.toDouble();
        if (m_motor_temperature_l != val) {
            m_motor_temperature_l = val;
            emit motorTemperatureChanged();
        }
    };

    signal_map["L_Ctrl_Temp"] = [this](const QVariant &v){
        double val = v.toDouble();
        if (m_inverter_temperature_l != val) {
            m_inverter_temperature_l = val;
            emit inverterTemperatureChanged();
        }
    };

    signal_map["L_AC_Current"] = [this](const QVariant &v){
        double val = v.toDouble();
        if (m_ac_l != val) {
            m_ac_l = val;
            emit ACsChanged();
        }
    };

    signal_map["L_ERPM"] = [this](const QVariant &v){
        double val = v.toDouble();
        if (m_erpm_l != val) {
            m_erpm_l = val;
            emit ERPMsChanged();
        }
    };

    signal_map["L_Drive_Enable"] = [this](const QVariant &v){
        bool val = v.toBool();
        if (m_drive_enable_l != val) {
            m_drive_enable_l = val;
            emit driveEnableChanged();
        }
    };

    signal_map["L_DigitalOutputs"] = [this, unpack4](const QVariant &v){
        unpack4(v.toUInt(), m_digital_outputs_l);
        emit digitalOutputsChanged();
    };

    signal_map["L_Fault_Code"] = [this, unpack8](const QVariant &v){
        unpack8(v.toUInt(), m_fault_code_l);
    };

    signal_map["L_Limit_Bits"] = [this, unpack3](const QVariant &v){
        unpack3(v.toUInt(), m_limit_bits_l);
    };

    // -------- RIGHT --------

    signal_map["R_Motor_Temp"] = [this](const QVariant &v){
        double val = v.toDouble();
        if (m_motor_temperature_r != val) {
            m_motor_temperature_r = val;
            emit motorTemperatureChanged();
        }
    };

    signal_map["R_Ctrl_Temp"] = [this](const QVariant &v){
        double val = v.toDouble();
        if (m_inverter_temperature_r != val) {
            m_inverter_temperature_r = val;
            emit inverterTemperatureChanged();
        }
    };

    signal_map["R_AC_Current"] = [this](const QVariant &v){
        double val = v.toDouble();
        if (m_ac_r != val) {
            m_ac_r = val;
            emit ACsChanged();
        }
    };

    signal_map["R_ERPM"] = [this](const QVariant &v){
        double val = v.toDouble();
        if (m_erpm_r != val) {
            m_erpm_r = val;
            emit ERPMsChanged();
        }
    };

    signal_map["R_Drive_Enable"] = [this](const QVariant &v){
        bool val = v.toBool();
        if (m_drive_enable_r != val) {
            m_drive_enable_r = val;
            emit driveEnableChanged();
        }
    };

    signal_map["R_DigitalOutputs"] = [this, unpack4](const QVariant &v){
        unpack4(v.toUInt(), m_digital_outputs_r);
        emit digitalOutputsChanged();
    };

    signal_map["R_Fault_Code"] = [this, unpack8](const QVariant &v){
        unpack8(v.toUInt(), m_fault_code_r);
    };

    signal_map["R_Limit_Bits"] = [this, unpack3](const QVariant &v){
        unpack3(v.toUInt(), m_limit_bits_r);
    };
}

void InverterSignalHandler::processSignal(const QString& name, const QVariant& value)
{
    auto it = signal_map.find(name);
    if (it != signal_map.end()) {
        it->second(value);
    }
}
