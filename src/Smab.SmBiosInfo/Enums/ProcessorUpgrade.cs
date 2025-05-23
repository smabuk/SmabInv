﻿namespace Smab.SmBiosInfo.Enums;

/// <summary>
/// Represents the type of processor upgrade or socket used for a CPU.
/// </summary>
/// <remarks>This enumeration provides a comprehensive list of processor upgrade types and socket configurations.
/// It is commonly used to identify the physical interface or upgrade path for a processor in a system.</remarks>
public enum ProcessorUpgrade
{
	Other                 = 0x01,
	Unknown               = 0x02,
	DaughterBoard         = 0x03,
	ZIFSocket             = 0x04,
	ReplaceablePiggyBack  = 0x05,
	None                  = 0x06,
	LIFSocket             = 0x07,
	Slot1                 = 0x08,
	Slot2                 = 0x09,
	Socket370             = 0x0A,
	SlotA                 = 0x0B,
	SlotM                 = 0x0C,
	Socket423             = 0x0D,
	SocketA               = 0x0E,
	Socket478             = 0x0F,
	Socket754             = 0x10,
	Socket940             = 0x11,
	Socket939             = 0x12,
	SocketmPGA604         = 0x13,
	SocketLGA771          = 0x14,
	SocketLGA775          = 0x15,
	SocketS1              = 0x16,
	SocketAM2             = 0x17,
	SocketF               = 0x18,
	SocketLGA1366         = 0x19,
	SocketG34             = 0x1A,
	SocketAM3             = 0x1B,
	SocketC32             = 0x1C,
	SocketLGA1156         = 0x1D,
	SocketLGA1567         = 0x1E,
	SocketPGA988A         = 0x1F,
	SocketBGA1288         = 0x20,
	SocketrPGA988B        = 0x21,
	SocketBGA1023         = 0x22,
	SocketBGA1224         = 0x23,
	SocketLGA1155         = 0x24,
	SocketLGA1356         = 0x25,
	SocketLGA2011         = 0x26,
	SocketFS1             = 0x27,
	SocketFS2             = 0x28,
	SocketFM1             = 0x29,
	SocketFM2             = 0x2A,
	SocketLGA2011_3       = 0x2B,
	SocketLGA1356_3       = 0x2C,
	SocketLGA1150         = 0x2D,
	SocketBGA1168         = 0x2E,
	SocketBGA1234         = 0x2F,
	SocketBGA1364         = 0x30,
	SocketAM4             = 0x31,
	SocketLGA1151         = 0x32,
	SocketBGA1356         = 0x33,
	SocketBGA1440         = 0x34,
	SocketBGA1515         = 0x35,
	SocketLGA3647_1       = 0x36,
	SocketSP3             = 0x37,
	SocketSP3r2           = 0x38,
	SocketBGA1392         = 0x3A,
	SocketBGA1510         = 0x3B,
	SocketBGA1528         = 0x3C,
	SocketLGA4189         = 0x3D,
	SocketLGA1200         = 0x3E,
	SocketLGA4677         = 0x3F,
	SocketLGA1700         = 0x40,
	SocketBGA1744         = 0x41,
	SocketBGA1781         = 0x42,
	SocketBGA1211         = 0x43,
	SocketBGA2422         = 0x44,
	SocketLGA1211         = 0x45,
	SocketLGA2422         = 0x46,
	SocketLGA5773         = 0x47,
	SocketBGA5773         = 0x48,
	SocketAM5             = 0x49,
	SocketSP5             = 0x4A,
	SocketSP6             = 0x4B,
	SocketBGA883          = 0x4C,
	SocketBGA1190         = 0x4D,
	SocketBGA4129         = 0x4E,
	SocketLGA4710         = 0x4F,
	SocketLGA7529         = 0x50,
	SocketBGA1964         = 0x51,
	SocketBGA1792         = 0x52,
	SocketBGA2049         = 0x53,
	SocketBGA2551         = 0x54,
	SocketLGA1851         = 0x55,
	SocketBGA2114         = 0x56,
	SocketBGA2833         = 0x57,
}
