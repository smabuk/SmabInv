namespace Smab.SmBiosInfo.Enums;

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
