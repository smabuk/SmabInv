using Smab.SmBiosInfo.Enums;

namespace Smab.SmBiosInfo.Structures;
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

	public string GetStringFromIndex(int index)
		=> Data[index] > 0 && Data[index] <= Strings.Count
			? Strings[Data[index] - 1]
			: string.Empty;

    public string BYTEToHexString(int index) => $"{Data[index]:X2}";
    public string BYTEToString(int index) => $"{Data[index]}";
    public byte BYTEToByte(int index) => Data[index];
    public int BYTEToInt(int index) => Data[index];
    public string WORDToHexString(int index) => $"{Data[index + 1]:X2}{Data[index]:X2}";
    public int WORDToInt(int index) => (Data[index + 1] * 256) + Data[index];
    public string DWORDToHexString(int index) => $"{Data[index + 3]:X2}{Data[index + 2]:X2}{Data[index + 1]:X2}{Data[index + 0]:X2}";
    public long DWORDToLong(int index)
		=> (Data[index + 3] * 256 * 256 * 256)
		 + (Data[index + 2] * 256 * 256)
		 + (Data[index + 1] * 256)
		 +  Data[index + 0];


}
