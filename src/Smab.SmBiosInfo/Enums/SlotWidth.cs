namespace Smab.SmBiosInfo.Enums;

/// <summary>
/// Represents the width of a hardware slot or bus, typically used to describe data transfer or physical slot
/// configurations.
/// </summary>
/// <remarks>This enumeration provides a set of predefined values to describe the width of a slot or bus in terms
/// of data bits or  physical lane configurations. The values include both traditional bit widths (e.g., 8-bit, 16-bit)
/// and modern lane-based  configurations (e.g., x1, x4, x16). Use this enumeration to standardize slot width
/// descriptions in hardware-related contexts.</remarks>
public enum SlotWidth
{
	Other     = 0x01,
	Unknown   = 0x02,
	_8Bit     = 0x03,
	_16Bit    = 0x04,
	_32Bit    = 0x05,
	_64Bit    = 0x06,
	_128Bit   = 0x07,
	x1Or1x    = 0x08,
	x2Or2x    = 0x09,
	x4Or4x    = 0x0A,
	x8Or8x    = 0x0B,
	x12Or12x  = 0x0C,
	x16Or16x  = 0x0D,
	x32Or32x  = 0x0E,
}
