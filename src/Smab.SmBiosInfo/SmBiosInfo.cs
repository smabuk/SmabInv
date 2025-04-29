using System.Management;
using Smab.SmBiosInfo.Structures;

namespace Smab.SmBiosInfo;

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
#if WINDOWS
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
#endif
	}

	public SmBiosInfo(byte[] data)
	{
		//MajorVersion = (byte)smbios["SmbiosMajorVersion"];
		//MinorVersion = (byte)smbios["SmbiosMinorVersion"];
		//Size = (uint)smbios["Size"];
		Data = data;
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
				000 => new     Type000(rawSmBiosData[pSmBiosData..(pSmBiosData + tableLength)], [.. strings]),
				001 => new     Type001(rawSmBiosData[pSmBiosData..(pSmBiosData + tableLength)], [.. strings]),
				002 => new     Type002(rawSmBiosData[pSmBiosData..(pSmBiosData + tableLength)], [.. strings]),
				003 => new     Type003(rawSmBiosData[pSmBiosData..(pSmBiosData + tableLength)], [.. strings]),
				004 => new     Type004(rawSmBiosData[pSmBiosData..(pSmBiosData + tableLength)], [.. strings]),
				005 => new     Type005(rawSmBiosData[pSmBiosData..(pSmBiosData + tableLength)], [.. strings]),
				006 => new     Type006(rawSmBiosData[pSmBiosData..(pSmBiosData + tableLength)], [.. strings]),
				007 => new     Type007(rawSmBiosData[pSmBiosData..(pSmBiosData + tableLength)], [.. strings]),
				008 => new     Type008(rawSmBiosData[pSmBiosData..(pSmBiosData + tableLength)], [.. strings]),
				009 => new     Type009(rawSmBiosData[pSmBiosData..(pSmBiosData + tableLength)], [.. strings]),
				010 => new     Type010(rawSmBiosData[pSmBiosData..(pSmBiosData + tableLength)], [.. strings]),
				011 => new     Type011(rawSmBiosData[pSmBiosData..(pSmBiosData + tableLength)], [.. strings]),
				012 => new     Type012(rawSmBiosData[pSmBiosData..(pSmBiosData + tableLength)], [.. strings]),
				080 => new     Type080(rawSmBiosData[pSmBiosData..(pSmBiosData + tableLength)], [.. strings]),
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
