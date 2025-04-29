using System.Management;

namespace Smab.SmBiosInfo;

/// <summary>
/// Represents information about the System Management BIOS (SMBIOS) data, including its version, size, raw data, and
/// parsed tables.
/// </summary>
/// <remarks>The <see cref="SmBiosInfo"/> class provides access to SMBIOS data, which contains detailed
/// information about the hardware and firmware of a system. This data can be retrieved from the system's firmware or
/// provided as raw binary data. The class also parses the raw SMBIOS data into structured tables for easier access to
/// specific information.</remarks>
public class SmBiosInfo
{
	public readonly byte[] Data;
	public readonly uint Size;
	public readonly byte MajorVersion;
	public readonly byte MinorVersion;
	public string Version => $"{MajorVersion}.{MinorVersion}";

	public SmBiosTable[] Tables = [];

	/// <summary>
	/// Initializes a new instance of the <see cref="SmBiosInfo"/> class,  retrieving and parsing system firmware
	/// information from the SMBIOS (System Management BIOS) table.
	/// </summary>
	/// <remarks>This constructor queries the SMBIOS data using WMI (Windows Management Instrumentation)  and
	/// extracts key information such as the SMBIOS version, table size, and raw data.  The parsed SMBIOS tables are also
	/// initialized for further use. <para> This functionality is only available on Windows platforms. On non-Windows
	/// platforms,  this constructor will not perform any operations. </para></remarks>
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

	/// <summary>
	/// Initializes a new instance of the <see cref="SmBiosInfo"/> class with the specified raw SMBIOS data.
	/// </summary>
	/// <remarks>The provided <paramref name="data"/> must contain valid SMBIOS data.  The constructor parses the
	/// data to initialize the <see cref="Tables"/> property,  which provides access to the extracted SMBIOS
	/// tables.</remarks>
	/// <param name="data">A byte array containing the raw SMBIOS (System Management BIOS) data.  This data is used to parse and extract
	/// SMBIOS tables and related information.</param>
	public SmBiosInfo(byte[] data)
	{
		//MajorVersion = (byte)smbios["SmbiosMajorVersion"];
		//MinorVersion = (byte)smbios["SmbiosMinorVersion"];
		Size = (uint)data.Length;
		Data = data;
		Tables = [.. ParseSmBios(Data)];
	}

	/// <summary>
	/// Parses raw SMBIOS data and extracts a list of SMBIOS tables.
	/// </summary>
	/// <remarks>This method processes the raw SMBIOS data by iterating through the byte array, identifying
	/// individual SMBIOS tables based on their type and length, and extracting any associated strings. The method supports
	/// multiple SMBIOS table types, including but not limited to types 0 through 12 and type 80. If an unrecognized table
	/// type is encountered, it is parsed as a generic <see cref="SmBiosTable"/> object.  The caller is responsible for
	/// ensuring that the input data is valid and complete. Invalid or malformed data may result in undefined behavior or
	/// incomplete parsing.</remarks>
	/// <param name="rawSmBiosData">A byte array containing the raw SMBIOS data to be parsed. This data is typically obtained from system firmware and
	/// must conform to the SMBIOS specification.</param>
	/// <returns>A list of <see cref="SmBiosTable"/> objects representing the parsed SMBIOS tables. Each table contains structured
	/// data and associated strings as defined by the SMBIOS specification.</returns>
	private static List<SmBiosTable> ParseSmBios(byte[] rawSmBiosData)
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
