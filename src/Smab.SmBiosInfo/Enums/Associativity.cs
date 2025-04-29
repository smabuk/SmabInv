namespace Smab.SmBiosInfo.Enums;

/// <summary>
/// Represents the associativity of a cache or memory structure, indicating how data is mapped to cache lines or sets.
/// </summary>
/// <remarks>Associativity defines the relationship between memory addresses and cache lines or sets. For example,
/// a "DirectMapped" cache maps each memory address to a single cache line, while "FullyAssociative" allows any memory
/// address to map to any cache line. Set-associative configurations (e.g., "SetAssociative2Way") allow a memory address
/// to map to a specific set of cache lines, with the number indicating the number of lines per set.</remarks>
public enum Associativity
{
	Other               = 0x01,
	Unknown             = 0x02,
	DirectMapped        = 0x03,
	SetAssociative2Way  = 0x04,
	SetAssociative4Way  = 0x05,
	FullyAssociative    = 0x06,
	SetAssociative8Way  = 0x07,
	SetAssociative16Way = 0x08,
	SetAssociative12Way = 0x09,
	SetAssociative24Way = 0x0A,
	SetAssociative32Way = 0x0B,
	SetAssociative48Way = 0x0C,
	SetAssociative64Way = 0x0D,
	SetAssociative20Way = 0x0E,
}
