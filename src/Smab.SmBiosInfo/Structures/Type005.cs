namespace Smab.SmBiosInfo.Structures;

/// <summary>
/// Represents the memory controller information table in the SMBIOS specification.
/// </summary>
/// <remarks>This table is considered obsolete in the SMBIOS specification and is retained for backward
/// compatibility. It provides information about the memory controller, including its configuration and
/// capabilities.</remarks>
/// <param name="Data"></param>
/// <param name="Strings"></param>
public sealed record Type005(byte[] Data, List<string> Strings) : SmBiosTable(Data, [.. Strings])
{
	public Type005(SmBiosTable table) : this(table.Data, [.. table.Strings]) { }

	public override string Description => "Memory Controller Information (obsolete)";
}
