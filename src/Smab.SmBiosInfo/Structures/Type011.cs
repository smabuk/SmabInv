namespace Smab.SmBiosInfo.Structures;
public record Type011(byte[] Data, List<string> Strings) : SmBiosTable(Data, [.. Strings])
{
	public Type011(SmBiosTable table) : this(table.Data, [.. table.Strings]) { }

	public override string Description => "OEM Strings";

	private const int DMI_11_Count = 0x04;

	public int Count => BYTEToByte(DMI_11_Count);
}
