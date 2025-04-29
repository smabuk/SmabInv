using Smab.SmBiosInfo;
using Smab.SmBiosInfo.Structures;

Console.WriteLine($"SmabInv - Hardware Inventory");

//foreach (string table in Constants.Win32Tables) {
//	//Dump.ToConsoleAsPlainText(table, ignoreBlankProperties: true, propertyWidth: 42);
//	Dump.ToConsoleAsTables(table);
//}


Console.WriteLine();

SmBiosInfo smBiosInfo = new();

Console.WriteLine($"SMBIOS Version: {smBiosInfo.MajorVersion}.{smBiosInfo.MinorVersion}");
Console.WriteLine($"SMBIOS Size: {smBiosInfo.Size}");


foreach (SmBiosTable smBiosTable in smBiosInfo.Tables.OrderBy(t => t.TableType)) {
	smBiosTable.DumpAsTable();
}



return 0;
