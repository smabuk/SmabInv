using SmabInv.SmBiosInfo;
using SmabInv.SmBios.Structures;

Console.WriteLine($"SmabInv - Hardware Inventory");

//foreach (string table in Constants.Win32Tables) {
//	//Dump.ToConsoleAsPlainText(table, ignoreBlankProperties: true, propertyWidth: 42);
//	Dump.ToConsoleAsTables(table);
//}


Console.WriteLine();

SmBiosInfo smBiosInfo = new();

Console.WriteLine($"SMBIOS Version: {smBiosInfo.MajorVersion}.{smBiosInfo.MinorVersion}");
Console.WriteLine($"SMBIOS Size: {smBiosInfo.Size}");
Console.WriteLine($"First Bytes: {string.Join(',', smBiosInfo.Data[..16])}");


foreach (SmBiosTable smBiosTable in smBiosInfo.Tables) {
	Console.WriteLine($"{smBiosTable.TableType, 3}: {smBiosTable.Description}");
	
	// Output specific table values (example for TableType 0)
	if (smBiosTable is Type000 type00) {
		Console.WriteLine($"        Vendor: {type00.Vendor}");
		Console.WriteLine($"        BIOS Version: {type00.BiosVersion}");
		Console.WriteLine($"        BIOS Release Date: {type00.BiosReleaseDate}");
		Console.WriteLine($"        StartAddress: {type00.BiosStartAddress:X}");
		Console.WriteLine($"        Rom Size: {type00.RomSize}");
		Console.WriteLine($"        Bios Version Major: {type00.SystemBiosMajorRelease}");
		Console.WriteLine($"        Bios Version Minor: {type00.SystemBiosMinorRelease}");
	}
}

return 0;
