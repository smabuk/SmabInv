namespace Smab.SmBiosInfo.Enums;

/// <summary>
/// Represents the operational state of a chassis, typically used in hardware monitoring or management systems.
/// </summary>
/// <remarks>The <see cref="ChassisState"/> enumeration provides a set of predefined states that describe the
/// current condition of a chassis. These states can be used to assess the health or operational status of the chassis
/// and take appropriate actions based on the reported state.</remarks>
public enum ChassisState
{
	Other          = 0x01,
	Unknown        = 0x02,
	Safe           = 0x03,
	Warning        = 0x04,
	Critical       = 0x05,
	NonRecoverable = 0x06,
}
