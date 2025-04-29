using Smab.SmBiosInfo.Enums;

namespace Smab.SmBiosInfo.Structures;
public record Type007(byte[] Data, List<string> Strings) : SmBiosTable(Data, [.. Strings])
{
	public Type007(SmBiosTable table) : this(table.Data, [.. table.Strings]) { }

	public override string Description => "Cache Information";

	private const int DMI_07_SocketDesignationSI = 0x04;
	private const int DMI_07_CacheConfiguration  = 0x05;
	private const int DMI_07_MaximumCacheSize    = 0x07;
	private const int DMI_07_InstalledSize       = 0x09;
	private const int DMI_07_SupportedSRAMType   = 0x0B;
	private const int DMI_07_CurrentSRAMType     = 0x0D;

	private const int DMI_07_CacheSpeed          = 0x0F;
	private const int DMI_07_ErrorCorrectionType = 0x10;
	private const int DMI_07_SystemCacheType     = 0x11;
	private const int DMI_07_Associativity       = 0x12;

	public string SocketDesignation => GetStringFromIndex(DMI_07_SocketDesignationSI);
	public SRAMType SupportedSRAMType => (SRAMType)BYTEToByte(DMI_07_SupportedSRAMType);
	public SRAMType CurrentSRAMType   => (SRAMType)BYTEToByte(DMI_07_CurrentSRAMType);
	public CacheConfiguration CacheConfiguration  => (CacheConfiguration)BYTEToByte(DMI_07_CacheConfiguration);
	public int MaximumCacheSize => WORDToInt(DMI_07_MaximumCacheSize);
	public int InstalledSize    => WORDToInt(DMI_07_InstalledSize);
	public byte CacheSpeed      => BYTEToByte(DMI_07_CacheSpeed);
	public ErrorCorrectionType ErrorCorrectionType => (ErrorCorrectionType)BYTEToByte(DMI_07_ErrorCorrectionType);
	public SystemCacheType SystemCacheType => (SystemCacheType)BYTEToByte(DMI_07_SystemCacheType);
	public Associativity Associativity => (Associativity)BYTEToByte(DMI_07_Associativity);
}
