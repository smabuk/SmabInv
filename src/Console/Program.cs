Console.WriteLine($"SmabInv - Hardware Inventory");

foreach (string table in Constants.Win32Tables) {
	Dump.ToConsoleAsPlainText(table, ignoreBlankProperties: true, propertyWidth: 42);
}


Console.WriteLine();
ManagementObject smbios = new 
	ManagementObjectSearcher(@"root\wmi", "SELECT * FROM MSSmBios_RawSMBiosTables")
	.Get()
	.Cast<ManagementObject>()
	.Single();

Console.WriteLine($"SMBIOS Version: {smbios["SmbiosMajorVersion"]}.{smbios["SmbiosMinorVersion"]}");


return 0;
