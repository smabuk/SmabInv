namespace Smab.SmBiosInfo.Enums;

/// <summary>
/// Represents the types of Static Random-Access Memory (SRAM) that can be used in a system.
/// </summary>
/// <remarks>This enumeration is marked with the <see cref="FlagsAttribute"/>, allowing bitwise combinations of
/// its values. Use this enumeration to specify or identify the characteristics of an SRAM type, such as whether it is
/// burst or non-burst, synchronous or asynchronous, or if its type is unknown or other.</remarks>
[Flags]
public enum SRAMType
{
	None          = 0,
	Other         = 0b00000001,
	Unknown       = 0b00000010,
	NonBurst      = 0b00000100,
	Burst         = 0b00001000,
	PipelineBurst = 0b00010000,
	Synchronous   = 0b00100000,
	Asynchronous  = 0b01000000,
}
