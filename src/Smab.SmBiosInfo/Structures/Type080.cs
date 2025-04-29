namespace Smab.SmBiosInfo.Structures;

/// <summary>
/// Represents the HP Platform Information table in the SMBIOS (System Management BIOS) structure.
/// </summary>
/// <remarks>This record provides access to specific fields within the HP Platform Information table,  including
/// the PCID, signature, and BIOS letters. It inherits from <see cref="SmBiosTable"/>  and provides additional
/// functionality for interpreting the table's data.</remarks>
/// <param name="Data"></param>
/// <param name="Strings"></param>
public sealed record Type080(byte[] Data, List<string> Strings) : SmBiosTable(Data, [.. Strings])
{
	public Type080(SmBiosTable table) : this(table.Data, [.. table.Strings]) { }

	public override string Description => "HP Platform Information";

	private const int DMI_80_Signature  = 0x04;
	private const int DMI_80_PCID       = 0x06;
	private const int DMI_80_BIOSLetter = 0x07;

	public string PCID => BYTEToHexString(Data[DMI_80_PCID]);
	public string Signature => $"{(char)Data[DMI_80_Signature]}{(char)Data[DMI_80_Signature + 1]}";
	public string BIOSLetters => $"{(char)Data[DMI_80_BIOSLetter]}{(char)Data[DMI_80_BIOSLetter + 1]}";
}
