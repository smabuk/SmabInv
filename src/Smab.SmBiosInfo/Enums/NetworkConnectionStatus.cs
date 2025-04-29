namespace Smab.SmBiosInfo.Enums;

/// <summary>
/// Represents the various states of a network connection.
/// </summary>
/// <remarks>This enumeration provides a comprehensive set of statuses that describe the current state of a
/// network connection. It includes states for connection progress, hardware issues, and authentication results.  Use
/// these values to determine the connection status and handle specific scenarios accordingly.</remarks>
public enum NetworkConnectionStatus
{
	Disconnected            = 0x00,
	Connecting              = 0x01,
	Connected               = 0x02,
	Disconnecting           = 0x03,
	HardwareNotPresent      = 0x04,
	HardwareDisabled        = 0x05,
	HardwareMalfunction     = 0x06,
	MediaDisconnected       = 0x07,
	Authenticating          = 0x08,
	AuthenticationSucceeded = 0x09,
	AuthenticationFailed    = 0x0A,
}
