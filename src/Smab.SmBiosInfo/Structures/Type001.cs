namespace Smab.SmBiosInfo.Structures;

/// <summary>
/// Represents the System Information (Type 1) structure of the SMBIOS (System Management BIOS) specification.
/// </summary>
/// <remarks>This record provides detailed information about the system, including manufacturer, product name,
/// version,  serial number, UUID, wake-up type, SKU number, and family. It extends the <see cref="SmBiosTable"/> class 
/// to parse and expose these fields from the SMBIOS data.</remarks>
/// <param name="Data"></param>
/// <param name="Strings"></param>
public sealed record Type001(byte[] Data, List<string> Strings) : SmBiosTable(Data, [.. Strings])
{
	public Type001(SmBiosTable table) : this(table.Data, [.. table.Strings]) { }

	public override string Description => "System Information";

	const int DMI_01_ManufacturerSI = 0x04;
	const int DMI_01_ProductNameSI  = 0x05;
	const int DMI_01_VersionSI      = 0x06;
	const int DMI_01_SerialNoSI     = 0x07;
	const int DMI_01_UUID           = 0x08;
	const int DMI_01_WakeupType     = 0x18;
	const int DMI_01_SKUNumberSI    = 0x19;
	const int DMI_01_FamilySI       = 0x1A;

	public string     Manufacturer => GetStringFromIndex(DMI_01_ManufacturerSI);
	public string     ProductName  => GetStringFromIndex(DMI_01_ProductNameSI);
	public string     Version      => GetStringFromIndex(DMI_01_VersionSI);
	public string     SerialNumber => GetStringFromIndex(DMI_01_SerialNoSI);
	public string     UUID         => GetUUID(DMI_01_UUID);
	public WakeUpType WakeupType   => (WakeUpType)BYTEToByte(DMI_01_WakeupType);
	public string     SKUNumber    => GetStringFromIndex(DMI_01_SKUNumberSI);
	public string     Family       => GetStringFromIndex(DMI_01_FamilySI);

	private string GetUUID(int offset)
		=> string.Join("-", Enumerable.Range(0, 16).Select(i => BYTEToHexString(offset + i)));
}
