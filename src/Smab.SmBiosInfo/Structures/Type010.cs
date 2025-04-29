namespace Smab.SmBiosInfo.Structures;

/// <summary>
/// Represents the On Board Devices Information (obsolete) structure in the SMBIOS specification.
/// </summary>
/// <remarks>This record provides information about onboard devices in a system. Note that this structure is
/// marked as obsolete in the SMBIOS specification.</remarks>
/// <param name="Data"></param>
/// <param name="Strings"></param>
public sealed record Type010(byte[] Data, List<string> Strings) : SmBiosTable(Data, [.. Strings])
{
	public Type010(SmBiosTable table) : this(table.Data, [.. table.Strings]) { }

	public override string Description => "On Board Devices Information (obsolete)";
}
