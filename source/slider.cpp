#include <3ds.h>
#include "slider.hpp"
#include "mcuhid.hpp"

void Slider::ReadValuesFromMCU()
{
    Result ret = mcuHidGetSliderState((u8*)&m_rawstate);
    if(R_FAILED(ret))
        m_rawstate = m_oldrawstate;
    else
        m_oldrawstate = m_rawstate;
}

void Slider::GetConfigSettings()
{
    // This is a virtual slider using the complete 0x00-0xFF range.
    // Physical 3D-slider calibration is therefore not needed.
}

float Slider::Normalize()
{
    int32_t raw = m_rawstate;

    if (raw < 0)
        raw = 0;

    if (raw > 0xFF)
        raw = 0xFF;

    return static_cast<float>(raw) / 255.0f;
}
