namespace Smab.SmBiosInfo.Structures;

/// <summary>
/// Represents a System Management BIOS (SMBIOS) table, containing raw data and associated string values.
/// </summary>
/// <remarks>The <see cref="SmBiosTable"/> class provides access to the raw data of an SMBIOS table, as well as
/// methods for interpreting and extracting specific values from the table. Each table is identified by its type,
/// length, and handle, which are derived from the raw data. The class also includes utilities for converting raw bytes
/// into meaningful representations, such as hexadecimal strings or integers.</remarks>
/// <param name="Data"></param>
/// <param name="Strings"></param>
public record SmBiosTable(byte[] Data, List<string> Strings)
{
	public readonly int TableType = Data[0];
	public readonly int Length    = Data[1];
	public readonly int Handle    = (Data[3] * 256) + Data[2];

	public virtual string Description => LookupSmBiosTableName(TableType);

	private static string LookupSmBiosTableName(int tableType)
	{
		return Enum.IsDefined(typeof(SmBiosTableName), tableType)
			? ((SmBiosTableName)tableType).ToString()
			: "<Unknown>";
	}

	/// <summary>
	/// Retrieves a string from the <see cref="Strings"/> collection based on the value at the specified index in the <see
	/// cref="Data"/> array.
	/// </summary>
	/// <param name="index">The one-based index of the <see cref="Data"/> array to evaluate. Must be within the bounds of the array.</param>
	/// <returns>The corresponding string from the <see cref="Strings"/> collection if the value at the specified index in <see
	/// cref="Data"/>  is greater than 0 and less than or equal to the number of elements in <see cref="Strings"/>;
	/// otherwise, an empty string.</returns>
	public string GetStringFromIndex(int index)
		=> Data[index] > 0 && Data[index] <= Strings.Count
			? Strings[Data[index] - 1]
			: string.Empty;

	/// <summary>
	/// Converts the byte at the specified index in the <see cref="Data"/> array to its hexadecimal string representation.
	/// </summary>
	/// <param name="index">The zero-based index of the byte in the <see cref="Data"/> array to convert.</param>
	/// <returns>A string representing the byte at the specified index in two-character uppercase hexadecimal format.</returns>
    public string BYTEToHexString(int index) => $"{Data[index]:X2}";
	/// <summary>
	/// Converts the byte at the specified index in the <see cref="Data"/> collection to its string representation.
	/// </summary>
	/// <param name="index">The zero-based index of the byte in the <see cref="Data"/> collection to convert.</param>
	/// <returns>A string representation of the byte at the specified index.</returns>
    public string BYTEToString(int index) => $"{Data[index]}";
	/// <summary>
	/// Retrieves the byte value at the specified index from the data source.
	/// </summary>
	/// <param name="index">The zero-based index of the byte to retrieve.</param>
	/// <returns>The byte value at the specified index.</returns>
    public byte   BYTEToByte(int index) => Data[index];
	/// <summary>
	/// Converts the byte value at the specified index in the data array to an integer.
	/// </summary>
	/// <param name="index">The zero-based index of the byte in the data array to convert.</param>
	/// <returns>The integer representation of the byte value at the specified index.</returns>
    public int    BYTEToInt(int index) => Data[index];

	/// <summary>
	/// Converts a 16-bit WORD value at the specified index in the data array to a hexadecimal string.
	/// </summary>
	/// <remarks>The method assumes that the data array contains at least two bytes starting from the specified
	/// <paramref name="index"/>. The returned string is always 4 characters long, representing the hexadecimal value of
	/// the WORD in uppercase.</remarks>
	/// <param name="index">The zero-based index of the lower byte of the WORD value in the data array. The method reads the byte at <paramref
	/// name="index"/> and the subsequent byte at <paramref name="index"/> + 1.</param>
	/// <returns>A string representing the 16-bit WORD value in big-endian hexadecimal format, where the higher byte appears first.</returns>
    public string WORDToHexString(int index) => $"{Data[index + 1]:X2}{Data[index]:X2}";
	/// <summary>
	/// Converts two consecutive bytes from the <see cref="Data"/> array, starting at the specified index, into a 16-bit
	/// integer.
	/// </summary>
	/// <remarks>The method interprets the byte at <paramref name="index"/> as the least significant byte (LSB) and
	/// the byte at <c>index + 1</c> as the most significant byte (MSB).</remarks>
	/// <param name="index">The zero-based index in the <see cref="Data"/> array where the conversion starts. The method reads the byte at this
	/// index and the next byte.</param>
	/// <returns>A 16-bit integer constructed from the two bytes at the specified index and the following index in the <see
	/// cref="Data"/> array.</returns>
    public int WORDToInt(int index) => (Data[index + 1] << 8) | Data[index];

	/// <summary>
	/// Converts a 4-byte DWORD value, starting at the specified index in the data array, to a hexadecimal string.
	/// </summary>
	/// <param name="index">The zero-based index in the data array where the DWORD value starts. The method reads four consecutive bytes
	/// starting from this index.</param>
	/// <returns>A string representing the DWORD value in big-endian hexadecimal format, with each byte represented as two uppercase
	/// hexadecimal characters.</returns>
    public string DWORDToHexString(int index) => $"{Data[index + 3]:X2}{Data[index + 2]:X2}{Data[index + 1]:X2}{Data[index + 0]:X2}";
	/// <summary>
	/// Converts a sequence of four bytes starting at the specified index in the <see cref="Data"/> array  into a 64-bit
	/// signed integer.
	/// </summary>
	/// <remarks>The method assumes that the bytes are stored in little-endian order, where the least significant 
	/// byte is at the lowest address. Ensure that the <paramref name="index"/> is within the valid range  to avoid an
	/// exception.</remarks>
	/// <param name="index">The zero-based index in the <see cref="Data"/> array where the conversion begins. The method reads  four
	/// consecutive bytes starting at this index.</param>
	/// <returns>A 64-bit signed integer representing the combined value of the four bytes, with the byte at  <paramref
	/// name="index"/> treated as the least significant byte.</returns>
    public long DWORDToLong(int index)
    => ((long)Data[index + 3] << 24)
     | ((long)Data[index + 2] << 16)
     | ((long)Data[index + 1] << 8)
     | Data[index];
}
