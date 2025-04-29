namespace Smab.SmBiosInfo.Enums;

[Flags]
public enum SRAMType
{
	None          = 0,
	Other         = 0b00000001,
	Unknown       = 0b00000010,
	NonBurst      = 0b00000100,
	Burst         = 0b00001000,
	PipelineBurst = 0b00010000,
	Synchronous   = 0b00100000,
	Asynchronous  = 0b01000000,
}
