namespace Smab.SmBiosInfo.Enums;

[Flags]
public enum FeatureFlags
{
	None                 = 0,
	HostingBoard         = 0b00000001,
	RequiresAnotherBoard = 0b00000010,
	Removable            = 0b00000100,
	Replaceable          = 0b00001000,
	HotSwappable         = 0b00010000,
}
