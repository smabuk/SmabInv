namespace Smab.SmBiosInfo.Enums;

/// <summary>
/// Represents the type of a hardware board in a system.
/// </summary>
/// <remarks>This enumeration defines various types of hardware boards that may be present in a system,  such as
/// server blades, motherboards, or memory modules. Each value corresponds to a specific  board type, which can be used
/// to identify or categorize hardware components.</remarks>
public enum BoardType
{
	Unknown                = 0x01,
	Other                  = 0x02,
	ServerBlade            = 0x03,
	ConnectivitySwitch     = 0x04,
	SystemManagementModule = 0x05,
	ProcessorModule        = 0x06,
	IOModule               = 0x07,
	MemoryModule           = 0x08,
	DaughterBoard          = 0x09,
	Motherboard            = 0x0A,
	ProcessorMemoryModule  = 0x0B,
	ProcessorIOModule      = 0x0C,
	InterconnectBoard      = 0x0D,
}
