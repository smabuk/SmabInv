namespace Smab.SmBiosInfo.Enums;

public enum ErrorCorrectionType
{
	Other        = 0x01,
	Unknown      = 0x02,
	None         = 0x03,
	Parity       = 0x04,
	SingleBitECC = 0x05,
	MultiBitECC  = 0x06,
}
