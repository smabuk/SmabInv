namespace Smab.SmBiosInfo.Enums;

/// <summary>
/// Represents the current usage state of a resource or entity.
/// </summary>
/// <remarks>This enumeration provides a set of predefined states that describe the availability or usage status
/// of a resource. It can be used to indicate whether a resource is available, in use, or in an unknown state, among
/// other conditions.</remarks>
public enum CurrentUsage
{
	None        = 0,
	Other       = 0x01,
	Unknown     = 0x02,
	Available   = 0x03,
	InUse       = 0x04,
	Unavailable = 0x05,
}
