namespace Smab.SmBiosInfo.Enums;

/// <summary>
/// Represents the names of System Management BIOS (SMBIOS) table types,  which define various hardware and system
/// information structures.
/// </summary>
/// <remarks>The <see cref="SmBiosTableName"/> enumeration provides identifiers for SMBIOS table types,  as
/// defined by the SMBIOS specification. These table types describe hardware and system  configuration details, such as
/// BIOS information, system information, memory devices,  and more. Custom or vendor-specific table types are also
/// included.  This enumeration can be used to interpret SMBIOS data structures when parsing or analyzing  system
/// information.</remarks>
public enum SmBiosTableName
{
	PlatformFirmwareInformation        =  0,
	SystemInformation                  =  1,
	BaseBoardInformation               =  2,
	SystemEnclosureOrChassis           =  3,
	ProcessorInformation               =  4,
	MemoryControllerInformation        =  5,
	MemoryModuleInformation            =  6,
	CacheInformation                   =  7,
	PortConnectorInformation           =  8,
	SystemSlots                        =  9,
	OnBoardDevices                     = 10,
	OEMStrings                         = 11,
	SystemConfigurationOptions         = 12,
	FirmwareLanguageInformation        = 13,
	GroupAssociations                  = 14,
	SystemEventLog                     = 15,
	PhysicalMemoryArray                = 16,
	MemoryDevice                       = 17,
	MemoryErrorInformation             = 18,
	MemoryArrayMappedAddress           = 19,
	MemoryDeviceMappedAddress          = 20,
	BuiltInPointingDevice              = 21,
	PortableBattery                    = 22,
	SystemReset                        = 23,
	HardwareSecurity                   = 24,
	SystemPowerControls                = 25,
	VoltageProbe                       = 26,
	CoolingDevice                      = 27,
	TemperatureProbe                   = 28,
	ElectricalCurrentProbe             = 29,
	OutOfBandRemoteAccess              = 30,
	BootIntegrityServicesEntryPoint    = 31,
	SystemBootInformation              = 32,
	MemoryError64BitInformation        = 33,
	ManagementDevice                   = 34,
	ManagementDeviceComponent          = 35,
	ManagementDeviceThresholdData      = 36,
	MemoryChannel                      = 37,
	IPMIDeviceInformation              = 38,
	SystemPowerSupply                  = 39,
	AdditionalInformation              = 40,
	OnboardDevicesExtendedInformation  = 41,
	ManagementControllerHostInterface  = 42,
	TPMDevice                          = 43,
	SystemSlotsType9Structure          = 44,

	Inactive                           = 126,
	EndOfTable                         = 127,
	HPPlatformInformation              = 128,
	MechanicalInformation              = 129,
	MotherboardSwitchesInformation     = 130,
	MassStorageDevice                  = 131,
	FrontPanelInformation              = 132,
	LANSCSIInformation                 = 133,
	MonitoredParameter                 = 134,
	HardwareMonitoringFlagsInformation = 135,
	PostErrors                         = 136,
	VideoInformation                   = 137,
	BootInformation                    = 138,
	MailboxInformation                 = 139,
	MCDPostInformation                 = 140,

	DellRevisionsAndIDs                = 208,
	DellParallelPort                   = 209,
	DellSerialPort                     = 210,
	DellIRPort                         = 211,
}
