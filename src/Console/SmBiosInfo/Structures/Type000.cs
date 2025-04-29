
namespace SmabInv.SmBios.Structures;
public record Type000(byte[] Data, List<string> Strings) : SmBiosTable(Data, [.. Strings])
{
	public override string Description => "Platform Firmware Information";

	const int DMI_00_VendorSI               =  4;
	const int DMI_00_BIOSVersionSI          =  5;
	const int DMI_00_BIOSStartingAddress    =  6;
	const int DMI_00_BIOSReleaseDateSI      =  8;
	const int DMI_00_BIOSRBIOSROMSize       =  9;
	const int DMI_00_SystemBIOSMajorRelease = 20;
	const int DMI_00_SystemBIOSMinorRelease = 21;

	public string Vendor            => GetStringFromIndex(DMI_00_VendorSI);
	public string BiosVersion       => GetStringFromIndex(DMI_00_BIOSVersionSI);
	public string BiosReleaseDate   => GetStringFromIndex(DMI_00_BIOSReleaseDateSI);
	public int BiosStartAddress     => WORDToInt(DMI_00_BIOSStartingAddress);
	public int RomSize              => BYTEToInt(DMI_00_BIOSRBIOSROMSize);
	public int? SystemBiosMajorRelease => Length > 18 ? BYTEToInt(DMI_00_SystemBIOSMajorRelease) : null;
	public int? SystemBiosMinorRelease => Length > 18 ? BYTEToInt(DMI_00_SystemBIOSMinorRelease) : null;
}
