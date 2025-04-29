using Smab.SmBiosInfo.Enums;

namespace Smab.SmBiosInfo.Structures;
public record Type003(byte[] Data, List<string> Strings) : SmBiosTable(Data, [.. Strings])
{
	public Type003(SmBiosTable table) : this(table.Data, [.. table.Strings]) { }

	public override string Description => "System Enclosure or Chassis";

	private const int DMI_03_ManufacturerSI = 0x04;
	private const int DMI_03_ChassisType    = 0x05;
	private const int DMI_03_VersionSI      = 0x06;
	private const int DMI_03_SerialNoSI     = 0x07;
	private const int DMI_03_AssetTagNoSI   = 0x08;
	
	private const int DMI_03_BootupState       = 0x09;
	private const int DMI_03_PowerSupplyState  = 0x0A;
	private const int DMI_03_ThermalState      = 0x0B;
	private const int DMI_03_SecurityStatus    = 0x0C;

	private const int DMI_03_Height            = 0x11;
	private const int DMI_03_NoOfPowerCords    = 0x12;



	public string Manufacturer   => GetStringFromIndex(DMI_03_ManufacturerSI);
	public string Version        => GetStringFromIndex(DMI_03_VersionSI);
	public string SerialNumber   => GetStringFromIndex(DMI_03_SerialNoSI);
	public string AssetTagNumber => GetStringFromIndex(DMI_03_AssetTagNoSI);
	public ChassisType ChassisType  => (ChassisType)BYTEToByte(DMI_03_ChassisType);

	public ChassisState? BootupState             => Length > 0x08 ? (ChassisState)BYTEToByte(DMI_03_BootupState) : null;
	public ChassisState? PowerSupplyState        => Length > 0x08 ? (ChassisState)BYTEToByte(DMI_03_PowerSupplyState) : null;
	public ChassisState? ThermalState            => Length > 0x08 ? (ChassisState)BYTEToByte(DMI_03_ThermalState) : null;
	public ChassisSecurityStatus? SecurityStatus => Length > 0x08 ? (ChassisSecurityStatus)BYTEToByte(DMI_03_SecurityStatus) : null;
	
	public byte? Height         => Length > 0x10 ? BYTEToByte(DMI_03_Height)         : null;
	public byte? NoOfPowerCords => Length > 0x10 ? BYTEToByte(DMI_03_NoOfPowerCords) : null;
}
