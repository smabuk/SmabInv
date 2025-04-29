using SmabInv.SmBios.Structures;

namespace SmabInv.SmBiosInfo;

public class SmBiosInfo
{
	public readonly byte[] Data;
	public readonly uint Size;
	public readonly byte MajorVersion;
	public readonly byte MinorVersion;
	public string Version => $"{MajorVersion}.{MinorVersion}";

	public SmBiosTable[] Tables = [];


	public SmBiosInfo()
	{
		ManagementObject smbios = new
			ManagementObjectSearcher(@"root\wmi", "SELECT * FROM MSSmBios_RawSMBiosTables")
			.Get()
			.Cast<ManagementObject>()
			.Single();

		MajorVersion = (byte)smbios["SmbiosMajorVersion"];
		MinorVersion = (byte)smbios["SmbiosMinorVersion"];
		Size = (uint)smbios["Size"];
		Data = (byte[])smbios["SmBIOSData"];
		Tables = [.. ParseSmBios(Data)];
	}




	public static IEnumerable<SmBiosTable> ParseSmBios(byte[] rawSmBiosData)
	{
		List<SmBiosTable> tables = [];
		int smBiosSize = rawSmBiosData.Length;

		int pSmBiosData = 0;
		while (pSmBiosData < smBiosSize) {
			int tableType   = rawSmBiosData[pSmBiosData + 0];
			int tableLength = rawSmBiosData[pSmBiosData + 1];

			// Load all strings from the end of the table
			List<string> strings = [];
			int stringPointer = pSmBiosData + tableLength;
			while (stringPointer < smBiosSize && rawSmBiosData[stringPointer] != 0) {
				var str = new List<byte>();
				while (rawSmBiosData[stringPointer] != 0) {
					str.Add(rawSmBiosData[stringPointer]);
					stringPointer++;
				}
				strings.Add(System.Text.Encoding.ASCII.GetString([.. str]));
				stringPointer++;
			}

			SmBiosTable table = tableType switch
			{
				0 => new Type000(rawSmBiosData[pSmBiosData..(pSmBiosData + tableLength)], [.. strings]),
				_ => new SmBiosTable(rawSmBiosData[pSmBiosData..(pSmBiosData + tableLength)], [.. strings])
			};

			tables.Add(table);

			// Find the next table in the array
			pSmBiosData += tableLength;
			while (pSmBiosData < smBiosSize && (rawSmBiosData[pSmBiosData] != 0 || rawSmBiosData[pSmBiosData + 1] != 0)) {
				pSmBiosData++;
			}
			pSmBiosData += 2;
		}

		return tables;
	}
}
