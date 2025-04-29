namespace Smab.SmBiosInfo.Structures;
public record Type012(byte[] Data, List<string> Strings) : SmBiosTable(Data, [.. Strings])
{
	public Type012(SmBiosTable table) : this(table.Data, [.. table.Strings]) { }

	public override string Description => "System Configuration Options";

	private const int DMI_12_Count = 0x04;

	public int Count => BYTEToByte(DMI_12_Count);
}
