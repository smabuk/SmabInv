namespace Smab.SmBiosInfo.Structures;
public record Type010(byte[] Data, List<string> Strings) : SmBiosTable(Data, [.. Strings])
{
	public Type010(SmBiosTable table) : this(table.Data, [.. table.Strings]) { }

	public override string Description => "On Board Devices Information (obsolete)";
}
