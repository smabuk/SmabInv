namespace Smab.SmBiosInfo.Structures;

/// <summary>
/// Represents the SMBIOS Type 8 structure, which provides information about port connectors.
/// </summary>
/// <remarks>This record encapsulates data and associated strings for the SMBIOS Type 8 table,  commonly used to
/// describe port connector details such as type, location, and function.</remarks>
/// <param name="Data"></param>
/// <param name="Strings"></param>
public sealed record Type008(byte[] Data, List<string> Strings) : SmBiosTable(Data, [.. Strings])
{
	public Type008(SmBiosTable table) : this(table.Data, [.. table.Strings]) { }

	public override string Description => "Port Connector Information";
}
