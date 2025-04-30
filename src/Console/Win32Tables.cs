using Spectre.Console;

namespace SmabInv;

internal static class Win32Tables
{
	public static void DumpToConsoleAsPlainText(bool ignoreBlankProperties = true, int propertyWidth = 42)
	{
		foreach (string tableName in TableNames) {
			Console.WriteLine();
			foreach (ManagementObject mgmt in new ManagementObjectSearcher($"SELECT * FROM {tableName}").Get().Cast<ManagementObject>()) {
				Console.WriteLine($"{tableName}:");
				foreach (PropertyData? property in mgmt.Properties) {
					if (PropertiesToIgnore.Contains(property.Name)) {
						continue;
					}

					string? stringValue = property?.ToPropertyString().Replace(Environment.NewLine, Environment.NewLine.PadRight(propertyWidth + 6));
					if (ignoreBlankProperties && !string.IsNullOrWhiteSpace(stringValue)) {
						Console.WriteLine($"  {property?.Name.PadRight(propertyWidth)}: {stringValue}");
					}
				}
			}
		}
	}

	public static void DumpToConsoleAsTables(bool ignoreBlankProperties = true)
	{
		foreach (string tableName in TableNames) {
			AnsiConsole.WriteLine();
			foreach (ManagementObject mgmt in new ManagementObjectSearcher($"SELECT * FROM {tableName}").Get().Cast<ManagementObject>()) {
				Table table = new()
				{
					Title = new($"{tableName}:")
				};
				_ = table.AddColumns(["Property", "Value"]);

				foreach (PropertyData? property in mgmt.Properties) {
					if (PropertiesToIgnore.Contains(property.Name)) {
						continue;
					}

					string? stringValue = property?.ToPropertyString();
					if (ignoreBlankProperties && !string.IsNullOrWhiteSpace(stringValue)) {
						_ = table.AddRow(new(property?.Name), stringValue.CleanMarkup());
					}
				}

				AnsiConsole.Write(table);
			}
		}
	}

	private static readonly string[] TableNames =
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

	private static readonly HashSet<string> PropertiesToIgnore =
		[
			"Caption",
			"Description",
			"CreationClassName",
		];

}
