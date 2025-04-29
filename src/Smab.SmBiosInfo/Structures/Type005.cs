namespace Smab.SmBiosInfo.Structures;
public record Type005(byte[] Data, List<string> Strings) : SmBiosTable(Data, [.. Strings])
{
	public Type005(SmBiosTable table) : this(table.Data, [.. table.Strings]) { }

	public override string Description => "Memory Controller Information (obsolete)";
}
