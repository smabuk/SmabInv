namespace Smab.SmBiosInfo.Enums;

/// <summary>
/// Specifies the type of error correction used in a system or component.
/// </summary>
/// <remarks>This enumeration provides values that represent different error correction mechanisms,  such as
/// parity checks or error-correcting codes (ECC). These values can be used to  describe or configure the error
/// correction capabilities of a system.</remarks>
public enum ErrorCorrectionType
{
	Other        = 0x01,
	Unknown      = 0x02,
	None         = 0x03,
	Parity       = 0x04,
	SingleBitECC = 0x05,
	MultiBitECC  = 0x06,
}
