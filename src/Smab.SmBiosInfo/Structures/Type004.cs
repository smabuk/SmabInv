using Smab.SmBiosInfo.Enums;

namespace Smab.SmBiosInfo.Structures;
public record Type004(byte[] Data, List<string> Strings) : SmBiosTable(Data, [.. Strings])
{
	public Type004(SmBiosTable table) : this(table.Data, [.. table.Strings]) { }

	public override string Description => "Processor Information";

	private const int DMI_04_SocketDesignationSI = 0x04;
	private const int DMI_04_ProcessorType       = 0x05;
	private const int DMI_04_ProcessorFamily     = 0x06;
	private const int DMI_04_ManufacturerSI      = 0x07;
	private const int DMI_04_MaxSpeed            = 0x14;
	private const int DMI_04_CurrentSpeed        = 0x16;
	private const int DMI_04_ProcessorUpgrade    = 0x19;

	private const int DMI_04_SerialNumberSI      = 0x20;
	private const int DMI_04_AssetTagSI          = 0x21;
	private const int DMI_04_PartNumberSI        = 0x22;

	private const int DMI_04_CoreCount                = 0x23;
	private const int DMI_04_CoreEnabled              = 0x24;
	private const int DMI_04_ThreadCount              = 0x25;
	private const int DMI_04_ProcessorCharacteristics = 0x26;

	private const int DMI_04_CoreCount2   = 0x2A;
	private const int DMI_04_CoreEnabled2 = 0x2C;
	private const int DMI_04_ThreadCount2 = 0x2E;



	public string SocketDesignation        => GetStringFromIndex(DMI_04_SocketDesignationSI);
	public ProcessorType ProcessorType     => (ProcessorType)BYTEToByte(DMI_04_ProcessorType);
	public ProcessorFamily ProcessorFamily => (ProcessorFamily)BYTEToByte(DMI_04_ProcessorFamily);
	public string Manufacturer             => GetStringFromIndex(DMI_04_ManufacturerSI);
	public int    MaxSpeed                 => WORDToInt(DMI_04_MaxSpeed);
	public int    CurrentSpeed             => WORDToInt(DMI_04_CurrentSpeed);
	public ProcessorUpgrade ProcessorUpgrade => (ProcessorUpgrade)BYTEToByte(DMI_04_ProcessorUpgrade);

	public string SerialNumber             => Length >= 0x20 ? GetStringFromIndex(DMI_04_SerialNumberSI) : "";
	public string AssetTag                 => Length >= 0x20 ? GetStringFromIndex(DMI_04_AssetTagSI)     : "";
	public string PartNumber               => Length >= 0x20 ? GetStringFromIndex(DMI_04_PartNumberSI)   : "";
	
	public int   CoreCount                 => Length > 0x29 ? WORDToInt(DMI_04_CoreCount2)   : BYTEToByte(DMI_04_CoreCount);
	public int   CoreEnabled               => Length > 0x29 ? WORDToInt(DMI_04_CoreEnabled2) : BYTEToByte(DMI_04_CoreEnabled);
	public int   ThreadCount               => Length > 0x29 ? WORDToInt(DMI_04_ThreadCount2) : BYTEToByte(DMI_04_ThreadCount);
	public ProcessorCharacteristics ProcessorCharacteristics
		=> Length > 0x29 ? (ProcessorCharacteristics)BYTEToByte(DMI_04_ProcessorCharacteristics) : 0;
}
