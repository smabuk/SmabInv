namespace Smab.SmBiosInfo.Structures;

/// <summary>
/// Represents an SMBIOS Type 11 structure, which contains OEM-specific strings.
/// </summary>
/// <remarks>This record provides access to OEM strings stored in the SMBIOS Type 11 table.  The strings are
/// typically used to store vendor-specific information.</remarks>
/// <param name="Data"></param>
/// <param name="Strings"></param>
public sealed record Type011(byte[] Data, List<string> Strings) : SmBiosTable(Data, [.. Strings])
{
	public Type011(SmBiosTable table) : this(table.Data, [.. table.Strings]) { }

	public override string Description => "OEM Strings";

	private const int DMI_11_Count = 0x04;

	public int Count => BYTEToByte(DMI_11_Count);
}
