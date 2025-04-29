namespace Smab.SmBiosInfo.Enums;

/// <summary>
/// Specifies the type of system cache in a computing environment.
/// </summary>
/// <remarks>This enumeration provides values to identify different types of system caches,  such as instruction
/// caches, data caches, and unified caches. These values can  be used to categorize or query cache types in hardware or
/// system-level operations.</remarks>
public enum SystemCacheType
{
	Other        = 0x01,
	Unknown      = 0x02,
	Insgtruction = 0x03,
	Data         = 0x04,
	Unified      = 0x05,
}
