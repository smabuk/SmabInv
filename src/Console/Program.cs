// Create a ManagementObjectSearcher to query WMI
ManagementObjectSearcher searcher;

try {

}
catch (ManagementException e) {
	Console.WriteLine("An error occurred while querying WMI: " + e.Message);
	return 1;
}

searcher = new("SELECT * FROM Win32_OperatingSystem");
foreach (ManagementObject os in searcher.Get().Cast<ManagementObject>()) {
	// Display some properties of the operating system
	Console.WriteLine($"Caption:         {os["Caption"]}");
	Console.WriteLine($"Version:         {os["Version"]}");
	Console.WriteLine($"Manufacturer:    {os["Manufacturer"]}");
	Console.WriteLine($"OS Architecture: {os["OSArchitecture"]}");
}


searcher = new(@"root\wmi", "SELECT * FROM MSSmBios_RawSMBiosTables");

foreach (ManagementObject smbios in searcher.Get()) {
	Console.WriteLine($"SM Bios Version: {smbios["SmbiosMajorVersion"]}.{smbios["SmbiosMinorVersion"]}");
	// Display some properties of the operating system
}

return 0;
