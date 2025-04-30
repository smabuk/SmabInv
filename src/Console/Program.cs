using Smab.SmBiosInfo;
using Smab.SmBiosInfo.Structures;

Console.WriteLine($"SmabInv - Hardware Inventory");

//Win32Tables.DumpToConsoleAsTables();

Console.WriteLine();

SmBiosInfo smBiosInfo = new();

Console.WriteLine($"SMBIOS Version: {smBiosInfo.Version}");
Console.WriteLine($"SMBIOS Size:    {smBiosInfo.Size}");


foreach (SmBiosTable smBiosTable in smBiosInfo.Tables.OrderBy(t => t.TableType)) {
	smBiosTable.DumpAsTable();
}



return 0;
