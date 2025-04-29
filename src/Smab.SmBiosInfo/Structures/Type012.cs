namespace Smab.SmBiosInfo.Structures;

/// <summary>
/// Represents the System Configuration Options (Type 12) structure in the SMBIOS specification.
/// </summary>
/// <remarks>This record provides information about system configuration options as defined in the SMBIOS
/// standard. It includes raw data and associated strings, and exposes a description and count of configuration
/// options.</remarks>
/// <param name="Data"></param>
/// <param name="Strings"></param>
public sealed record Type012(byte[] Data, List<string> Strings) : SmBiosTable(Data, [.. Strings])
{
	public Type012(SmBiosTable table) : this(table.Data, [.. table.Strings]) { }

	public override string Description => "System Configuration Options";

	private const int DMI_12_Count = 0x04;

	public int Count => BYTEToByte(DMI_12_Count);
}
