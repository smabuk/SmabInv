namespace Smab.SmBiosInfo.Structures;

/// <summary>
/// Represents the SMBIOS Type 006 structure, which provides information about a memory module.
/// </summary>
/// <remarks>This structure is considered obsolete in the SMBIOS specification. It is retained for backward
/// compatibility and may not be present in modern systems. Use this type to access details about memory modules if the
/// SMBIOS implementation includes this table.</remarks>
/// <param name="Data"></param>
/// <param name="Strings"></param>
public sealed record Type006(byte[] Data, List<string> Strings) : SmBiosTable(Data, [.. Strings])
{
	public Type006(SmBiosTable table) : this(table.Data, [.. table.Strings]) { }

	public override string Description => "Memory Module Information (obsolete)";
}
