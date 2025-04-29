namespace Smab.SmBiosInfo.Enums;

/// <summary>
/// Represents the security status of a chassis, indicating the current state of its external interface or security
/// configuration.
/// </summary>
/// <remarks>This enumeration is typically used to describe the security state of a hardware chassis in systems
/// where external interface access or security settings are relevant. The values correspond to specific states as
/// defined by the system's security model.</remarks>
public enum ChassisSecurityStatus
{
	Other                      = 0x01,
	Unknown                    = 0x02,
	None                       = 0x03,
	ExternalInterfaceLockedOut = 0x04,
	ExternalInterfaceEnabled   = 0x05,
}
