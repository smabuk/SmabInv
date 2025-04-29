namespace Smab.SmBiosInfo.Structures;
public record Type006(byte[] Data, List<string> Strings) : SmBiosTable(Data, [.. Strings])
{
	public Type006(SmBiosTable table) : this(table.Data, [.. table.Strings]) { }

	public override string Description => "Memory Module Information (obsolete)";
}
