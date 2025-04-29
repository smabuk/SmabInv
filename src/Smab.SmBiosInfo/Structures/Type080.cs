namespace Smab.SmBiosInfo.Structures;
public record Type080(byte[] Data, List<string> Strings) : SmBiosTable(Data, [.. Strings])
{
	public Type080(SmBiosTable table) : this(table.Data, [.. table.Strings]) { }

	public override string Description => "HP Platform Information";

	private const int DMI_80_PCID = 6;
	private const int DMI_80_Signature = 4;
	private const int DMI_80_BIOSLetter = 7;

	public string PCID => BYTEToHexString(Data[DMI_80_PCID]);
	public string Signature => $"{(char)Data[DMI_80_Signature]}{(char)Data[DMI_80_Signature + 1]}";
	public string BIOSLetters => $"{(char)Data[DMI_80_BIOSLetter]}{(char)Data[DMI_80_BIOSLetter + 1]}";
}
