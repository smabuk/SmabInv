namespace Smab.SmBiosInfo.Enums;

// ToDo: Configure this to behave properly
// Bits 15:10 Reserved, must be zero
// Bits 9:8 Operational Mode
//         00b – Write Through
//         01b – Write Back
//         10b – Varies with Memory Address
//         11b – Unknown
// Bit 7 Enabled/Disabled (at boot time)
//          1b – Enabled
//          0b – Disabled
// Bits 6:5 Location, relative to the CPU module:
//         00b – Internal
//         01b – External
//         10b – Reserved
//         11b – Unknown
// Bit 4 Reserved, must be zero
// Bit 3 Cache Socketed (e.g., Cache on a Stick)
//          1b – Socketed
//          0b – Not Socketed
// Bits 2:0 Cache Level – 1 through 8 (For example, an L1 cache would use value 000b and an L3 cache would use 010b.)
[Flags]
public enum CacheConfiguration
{
	L1            = 0b00000000,
	L2            = 0b00000001,
	L3            = 0b00000010,
	L4            = 0b00000011,
	L5            = 0b00000100,
	L6            = 0b00000101,
	L7            = 0b00000110,
	L8            = 0b00000111,

	Socketed      = 0b00001000,
}
