using Smab.SmBiosInfo.Enums;

namespace Smab.SmBiosInfo.Structures;
public record Type002(byte[] Data, List<string> Strings) : SmBiosTable(Data, [.. Strings])
{
	public Type002(SmBiosTable table) : this(table.Data, [.. table.Strings]) { }

	public override string Description => "Baseboard Information";

	private const int DMI_02_ManufacturerSI      = 0x04;
	private const int DMI_02_ProductNameSI       = 0x05;
	private const int DMI_02_VersionSI           = 0x06;
	private const int DMI_02_SerialNoSI          = 0x07;
	private const int DMI_02_AssetTagSI          = 0x08;
	private const int DMI_02_FeatureFlags        = 0x09;
	private const int DMI_02_LocationInChassisSI = 0x0A;
	private const int DMI_02_ChassisHandle       = 0x0B;
	private const int DMI_02_BoardType           = 0x0D;

	public string Manufacturer       => GetStringFromIndex(DMI_02_ManufacturerSI);
	public string ProductName        => GetStringFromIndex(DMI_02_ProductNameSI);
	public string Version            => GetStringFromIndex(DMI_02_VersionSI);
	public string SerialNumber       => GetStringFromIndex(DMI_02_SerialNoSI);
	public string AssetTag           => GetStringFromIndex(DMI_02_AssetTagSI);
	public FeatureFlags FeatureFlags => (FeatureFlags)BYTEToByte(DMI_02_FeatureFlags);
	public string LocationInChassis  => GetStringFromIndex(DMI_02_LocationInChassisSI);
	public int    ChassisHandle      => WORDToInt(DMI_02_ChassisHandle);
	public BoardType BoardType       => (BoardType)BYTEToByte(DMI_02_BoardType);
}
