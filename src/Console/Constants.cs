namespace SmabInv;
internal static class Constants
{
    public const string Version = "2025.04.28";

	public static readonly string[] Win32Tables =
		[
			"Win32_ComputerSystemProduct",
			"Win32_Bios",
			"Win32_SystemEnclosure",
			"Win32_Processor",
			"Win32_ComputerSystem",
			"Win32_WinSAT",
			"Win32_OperatingSystem",
			"Win32_DiskDrive",
			"Win32_DiskPartition",
			"Win32_CDROMDrive",
			"Win32_LogicalDisk WHERE DriveType <> 4",
		];

	public static readonly HashSet<string> PropertiesToIgnore =
		[
			"Caption",
			"Description",
			"CreationClassName",
		];
}
