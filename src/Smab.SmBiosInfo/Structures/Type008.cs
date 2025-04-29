namespace Smab.SmBiosInfo.Structures;
public record Type008(byte[] Data, List<string> Strings) : SmBiosTable(Data, [.. Strings])
{
	public Type008(SmBiosTable table) : this(table.Data, [.. table.Strings]) { }

	public override string Description => "Port Connector Information";
}
