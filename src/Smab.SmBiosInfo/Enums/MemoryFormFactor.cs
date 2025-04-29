namespace Smab.SmBiosInfo.Enums;

/// <summary>
/// Specifies the physical form factor of a memory module.
/// </summary>
/// <remarks>This enumeration provides a set of predefined values representing the physical design or packaging of
/// memory modules, such as DIMM, SODIMM, or proprietary card formats. These values are commonly used to identify the
/// type of memory in a system or device.</remarks>
public enum MemoryFormFactor
{
	Other           = 0x01,
	Unknown         = 0x02,
	SIMM            = 0x03,
	SIP             = 0x04,
	Chip            = 0x05,
	DIP             = 0x06,
	ZIP             = 0x07,
	ProprietaryCard = 0x08,
	DIMM            = 0x09,
	TSOP            = 0x0A,
	RowOfChips      = 0x0B,
	RIMM            = 0x0C,
	SODIMM          = 0x0D,
	SRIMM           = 0x0E,
	FBDIMM          = 0x0F,
}
