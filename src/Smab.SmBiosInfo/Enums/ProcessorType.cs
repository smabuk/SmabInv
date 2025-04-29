namespace Smab.SmBiosInfo.Enums;

/// <summary>
/// Specifies the type of processor in a system.
/// </summary>
/// <remarks>This enumeration provides a set of predefined processor types, including central processors,  math
/// processors, digital signal processors (DSP), and video processors. It also includes  options for unknown or other
/// processor types.</remarks>
public enum ProcessorType
{
	Other            = 0x01,
	Unknown          = 0x02,
	CentralProcessor = 0x03,
	MathProcessor    = 0x04,
	DSPProcessor     = 0x05,
	VideoProcessor   = 0x06,
}
