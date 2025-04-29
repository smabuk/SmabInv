namespace Smab.SmBiosInfo.Structures;
public record Type009(byte[] Data, List<string> Strings) : SmBiosTable(Data, [.. Strings])
{
	public Type009(SmBiosTable table) : this(table.Data, [.. table.Strings]) { }

	public override string Description => "System Slots";

	private const int DMI_09_SlotDesignationSI = 0x04;
	private const int DMI_09_SlotType          = 0x05;
	private const int DMI_09_SlotDataBusWidth  = 0x06;
	private const int DMI_09_CurrentUsage      = 0x07;
	private const int DMI_09_SlotLength        = 0x08;
	private const int DMI_09_SlotId            = 0x09;

	public string SlotDesignation => GetStringFromIndex(DMI_09_SlotDesignationSI);
	public SlotType SlotType => (SlotType)BYTEToByte(DMI_09_SlotType);
	public SlotWidth SlotDataBusWidth => (SlotWidth)BYTEToByte(DMI_09_SlotDataBusWidth);
	public CurrentUsage CurrentUsage => (CurrentUsage)BYTEToByte(DMI_09_CurrentUsage);
	public SlotLength SlotLength => (SlotLength)BYTEToByte(DMI_09_SlotLength);
}
