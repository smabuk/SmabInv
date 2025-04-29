namespace Smab.SmBiosInfo.Enums;

/// <summary>
/// Specifies the types of events that can wake up a system from a low-power state.
/// </summary>
/// <remarks>This enumeration defines various wake-up sources, such as timers, network activity, or power state
/// changes. It is commonly used in scenarios where the wake-up event needs to be identified or logged.</remarks>
public enum WakeUpType
{
	Reserved        = 0x00,
	Other           = 0x01,
	Unknown         = 0x02,
	APMTimer        = 0x03,
	ModemRing       = 0x04,
	LANRemote       = 0x05,
	PowerSwitch     = 0x06,
	PCIPME          = 0x07,
	ACPowerRestored = 0x08,
}
