namespace Smab.SmBiosInfo.Structures;
public record Type000(byte[] Data, List<string> Strings) : SmBiosTable(Data, [.. Strings])
{
	public Type000(SmBiosTable table) : this(table.Data, [.. table.Strings]) { }

	public override string Description => "Platform Firmware Information";

	private const int DMI_00_VendorSI               = 0x04;
	private const int DMI_00_BIOSVersionSI          = 0x05;
	private const int DMI_00_BIOSStartingAddress    = 0x06;
	private const int DMI_00_BIOSReleaseDateSI      = 0x08;
	private const int DMI_00_BIOSRBIOSROMSize       = 0x09;

	private const int DMI_00_PlatformFirmwareMajorRelease = 0x14;
	private const int DMI_00_PlatformFirmwareMinorRelease = 0x15;

	private const int DMI_00_EmbeddedControllerFirmwareMajorRelease = 0x16;
	private const int DMI_00_EmbeddedControllerFirmwareMinorRelease = 0x17;

	public string Vendor                 => GetStringFromIndex(DMI_00_VendorSI);
	public string BiosVersion            => GetStringFromIndex(DMI_00_BIOSVersionSI);
	public string BiosReleaseDate        => GetStringFromIndex(DMI_00_BIOSReleaseDateSI);
	public int    BiosStartAddress       => WORDToInt(DMI_00_BIOSStartingAddress);
	public byte   RomSize                => BYTEToByte(DMI_00_BIOSRBIOSROMSize);
	public int?   PlatformFirmwareMajorRelease => Length > 18 ? BYTEToInt(DMI_00_PlatformFirmwareMajorRelease) : null;
	public int?   PlatformFirmwareMinorRelease => Length > 18 ? BYTEToInt(DMI_00_PlatformFirmwareMinorRelease) : null;
	public int?   EmbeddedControllerFirmwareMajorRelease => Length > 18 ? BYTEToInt(DMI_00_EmbeddedControllerFirmwareMajorRelease) : null;
	public int?   EmbeddedControllerFirmwareMinorRelease => Length > 18 ? BYTEToInt(DMI_00_EmbeddedControllerFirmwareMinorRelease) : null;
}
