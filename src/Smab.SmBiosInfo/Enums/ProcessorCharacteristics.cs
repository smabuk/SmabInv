namespace Smab.SmBiosInfo.Enums;

/// <summary>
/// Represents the characteristics and capabilities of a processor.
/// </summary>
/// <remarks>This enumeration is decorated with the <see cref="FlagsAttribute"/>, allowing bitwise combination of
/// its values. Use this enumeration to identify specific features or capabilities of a processor, such as support for
/// 64-bit operations, multi-core architecture, or enhanced virtualization.</remarks>
[Flags]
public enum ProcessorCharacteristics
{
	Reserved                = 0,
	Unknown                 = 0b000000001,
	CapableOf64Bit          = 0b000000010,
	MultiCore               = 0b000000100,
	HardwareThread          = 0b000001000,
	ExecuteProtection       = 0b000010000,
	EnhancedVirtualization  = 0b000100000,
	PowerPerformanceControl = 0b001000000,
	CapableOf128Bit         = 0b010000000,
	Arm64SoCID              = 0b100000000,
}
