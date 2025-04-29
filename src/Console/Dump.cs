using Spectre.Console;

namespace SmabInv;
internal static class Dump
{
	public static void ToConsoleAsPlainText(string table, bool ignoreBlankProperties = true, int propertyWidth = 42)
	{
		Console.WriteLine();
		foreach (ManagementObject mgmt in new ManagementObjectSearcher($"SELECT * FROM {table}").Get().Cast<ManagementObject>()) {
			Console.WriteLine($"{table}:");
			foreach (PropertyData? property in mgmt.Properties) {
				if (Constants.PropertiesToIgnore.Contains(property.Name)) {
					continue;
				}

				string? stringValue = property?.ToPropertyString().Replace(Environment.NewLine, Environment.NewLine.PadRight(propertyWidth + 6));
				if (ignoreBlankProperties && !string.IsNullOrWhiteSpace(stringValue)) {
					Console.WriteLine($"  {property?.Name.PadRight(propertyWidth)}: {stringValue}");
				}
			}
		}
	}

	public static void ToConsoleAsTables(string tableName, bool ignoreBlankProperties = true)
	{
		AnsiConsole.WriteLine();
		foreach (ManagementObject mgmt in new ManagementObjectSearcher($"SELECT * FROM {tableName}").Get().Cast<ManagementObject>()) {
			Table table = new()
			{
				Title = new($"{tableName}:")
			};
			_ = table.AddColumns(["Property", "Value"]);

			foreach (PropertyData? property in mgmt.Properties) {
				if (Constants.PropertiesToIgnore.Contains(property.Name)) {
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
