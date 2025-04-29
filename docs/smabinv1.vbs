' ***************************************************************************
' ***                 I N V E N T O R Y     S C R I P T                   ***
' ***************************************************************************
' ***  Written by Simon Brookes                                           ***
' ***                                                                     ***
' ***                                                                     ***
' ***                                                                     ***
' ***                                                                     ***
' ***                                                                     ***
' ***                                                                     ***
' ***                                                                     ***
' ***                                                                     ***
' ***                                                                     ***
' ***                                                                     ***
' ***   2010-01-20 001   Modified .Net Framework to recognise v4+         ***
' ***   2010-01-20 002   Added script version                             ***
' ***   2010-07-13 001   Recognise SmBios v2.6.1                          ***
' ***   2011-06-18 001   Added SmBios additional memory and table types   ***
' ***   2012-10-27 001   Support for Windows 8                            ***
' ***   2014-10-02 001   Support for Windows 10 Technical Preview         ***
' ***   2017-04-15 001   Recognise SmBios v3.1.1                          ***
' ***   2018-01-06 001   Updated Processor Upgrade field                  ***
' ***   2018-01-06 002   Added lookup for Processor Family                ***
' ***************************************************************************

Const SCRIPT_VERSION = "2018.01.06.002"

Const HKLM = &H80000002 'HKEY_LOCAL_MACHINE
Const adVarChar = 200
Const adInteger = 3
Const adDate = 7

strMessage = "Script version: " & SCRIPT_VERSION
WScript.Echo strMessage

Set objArgs = WScript.Arguments

If objArgs.Count = 0 Then
    strComputerName = "."
Else
    strComputerName = objArgs(0)
End If

strMessage = "ComputerName: " & strComputerName
WScript.Echo strMessage

Set objWMI = GetObject("winmgmts:{impersonationlevel=impersonate}!\\" & strComputerName & "\root\cimv2")

' ***************************************************************************
' ***    H A R D W A R E                                                  ***
' ***************************************************************************

strMessage = ""
Set myEnum = objWMI.ExecQuery("SELECT * from Win32_ComputerSystemProduct")
For Each csp In myEnum
    strMessage = ""
    strMessage = strMessage & vbCrLf & "Win32_ComputerSystemProduct:"
    strMessage = strMessage & vbCrLf & "  IdentifyingNumber: " & csp.IdentifyingNumber
    strMessage = strMessage & vbCrLf & "  Name: " & csp.Name
    strMessage = strMessage & vbCrLf & "  SKUNumber: " & csp.SKUNumber
    strMessage = strMessage & vbCrLf & "  UUID: " & csp.UUID
    strMessage = strMessage & vbCrLf & "  Vendor: " & csp.Vendor
    strMessage = strMessage & vbCrLf & "  Version: " & csp.Version
    WScript.Echo strMessage
Next

strMessage = ""
Set myEnum = objWMI.ExecQuery("SELECT * from Win32_Bios")
For Each w32bios In myEnum
    strMessage = ""
    strMessage = strMessage & vbCrLf & "Win32_Bios:"
    For Each w32biosBiosVersion In w32bios.BIOSVersion
        strMessage = strMessage & vbCrLf & "  BIOSVersion(): " & w32biosBiosVersion
    Next
    strMessage = strMessage & vbCrLf & "  BuildNumber: " & w32bios.BuildNumber
    strMessage = strMessage & vbCrLf & "  IdentificationCode: " & w32bios.IdentificationCode
    strMessage = strMessage & vbCrLf & "  InstallDate: " & w32bios.InstallDate
    strMessage = strMessage & vbCrLf & "  Manufacturer: " & w32bios.Manufacturer
    strMessage = strMessage & vbCrLf & "  Name: " & w32bios.Name
    strMessage = strMessage & vbCrLf & "  ReleaseDate: " & w32bios.ReleaseDate
    strMessage = strMessage & vbCrLf & "  SerialNumber: " & w32bios.SerialNumber
    strMessage = strMessage & vbCrLf & "  SMBIOSBIOSVersion: " & w32bios.SMBIOSBIOSVersion
    strMessage = strMessage & vbCrLf & "  SMBIOSMajorVersion: " & w32bios.SMBIOSMajorVersion
    strMessage = strMessage & vbCrLf & "  SMBIOSMinorVersion: " & w32bios.SMBIOSMinorVersion
    strMessage = strMessage & vbCrLf & "  Version: " & w32bios.Version
    WScript.Echo strMessage
Next

strMessage = ""
Set myEnum = objWMI.ExecQuery("SELECT * from Win32_SystemEnclosure")
For Each w32se In myEnum
    strMessage = ""
    strMessage = strMessage & vbCrLf & "Win32_SystemEnclosure:"
    strMessage = strMessage & vbCrLf & "  ChassisTypes(0): " & w32se.ChassisTypes(0) & " (" & LookupChassisType(w32se.ChassisTypes(0)) & ")"
    'strMessage = strMessage & vbCrLf & "  TypeDescriptions(0): " & w32se.TypeDescriptions(0)
    strMessage = strMessage & vbCrLf & "  SMBIOSAssetTag: " & w32se.SMBIOSAssetTag
    WScript.Echo strMessage
Next

strMessage = ""
Set myEnum = objWMI.ExecQuery("SELECT * from Win32_Processor")
For Each w32proc In myEnum
    strMessage = ""
    strMessage = strMessage & vbCrLf & "Win32_Processor:"
    strMessage = strMessage & vbCrLf & "  Caption: " & w32proc.Caption
    strMessage = strMessage & vbCrLf & "  CurrentClockSpeed: " & w32proc.CurrentClockSpeed
    strMessage = strMessage & vbCrLf & "  Description: " & w32proc.Description
    strMessage = strMessage & vbCrLf & "  DeviceID: " & w32proc.DeviceID
    strMessage = strMessage & vbCrLf & "  Family: " & w32proc.Family & " (" & LookupProcessorFamily(w32proc.Family) & ")"
    strMessage = strMessage & vbCrLf & "  L2CacheSpeed: " & w32proc.L2CacheSpeed
    strMessage = strMessage & vbCrLf & "  Level: " & w32proc.Level
    strMessage = strMessage & vbCrLf & "  Manufacturer: " & w32proc.Manufacturer
    strMessage = strMessage & vbCrLf & "  MaxClockSpeed: " & w32proc.MaxClockSpeed
    strMessage = strMessage & vbCrLf & "  Name: " & w32proc.Name
    strMessage = strMessage & vbCrLf & "  ProcessorId: " & w32proc.ProcessorId
    strMessage = strMessage & vbCrLf & "  ProcessorType: " & w32proc.ProcessorType & " (" & LookupProcessorType(w32proc.ProcessorType) & ")"
    strMessage = strMessage & vbCrLf & "  Role: " & w32proc.Role
    strMessage = strMessage & vbCrLf & "  SocketDesignation: " & w32proc.SocketDesignation
    strMessage = strMessage & vbCrLf & "  Stepping: " & w32proc.Stepping
    strMessage = strMessage & vbCrLf & "  UniqueId: " & w32proc.UniqueId
    strMessage = strMessage & vbCrLf & "  UpgradeMethod: " & w32proc.UpgradeMethod & " (" & LookupProcessorUpgrade(w32proc.UpgradeMethod) & ")"
    strMessage = strMessage & vbCrLf & "  Version: " & w32proc.Version
    WScript.Echo strMessage
Next

' ***************************************************************************
' ***    O P E R A T I N G     S Y S T E M                                ***
' ***************************************************************************

strMessage = ""
Set myEnum = objWMI.ExecQuery("SELECT * from Win32_ComputerSystem")
For Each cs In myEnum
    strMessage = ""
    strMessage = strMessage & vbCrLf & "Win32_ComputerSystem:"
    strMessage = strMessage & vbCrLf & "  CurrentTimeZone: " & cs.CurrentTimeZone
    strMessage = strMessage & vbCrLf & "  Domain: " & cs.Domain
    strMessage = strMessage & vbCrLf & "  InfraredSupported: " & cs.InfraredSupported
    strMessage = strMessage & vbCrLf & "  Manufacturer: " & cs.Manufacturer
    strMessage = strMessage & vbCrLf & "  Model: " & cs.Model
    strMessage = strMessage & vbCrLf & "  Name: " & cs.Name
    strMessage = strMessage & vbCrLf & "  PartOfDomain: " & cs.PartOfDomain
    strMessage = strMessage & vbCrLf & "  PrimaryOwnerName: " & cs.PrimaryOwnerName
    strMessage = strMessage & vbCrLf & "  TotalPhysicalMemory: " & cs.TotalPhysicalMemory
    strMessage = strMessage & vbCrLf & "  UserName: " & cs.UserName
    WScript.Echo strMessage
Next

On Error Resume Next
strMessage = ""
Set myEnum = objWMI.ExecQuery("Select * From Win32_WinSAT")
For Each wSAT in myEnum
    strMessage = ""
    strMessage = strMessage & vbCrLf & "Win32_WinSAT:"
    strMessage = strMessage & vbCrLf & "  Windows System Performance Rating: " & wSAT.WinSPRLevel
    'strMessage = strMessage & vbCrLf & "  TimeTaken: " & wSAT.TimeTaken
    'strMessage = strMessage & vbCrLf & "  WinSATAssessmentState: " & wSAT.WinSATAssessmentState
    strMessage = strMessage & vbCrLf & "  Processor: " & wSAT.CPUScore
    strMessage = strMessage & vbCrLf & "  Memory: " & wSAT.MemoryScore
    strMessage = strMessage & vbCrLf & "  Primary hard disk: " & wSAT.DiskScore
    strMessage = strMessage & vbCrLf & "  Graphics: " & wSAT.GraphicsScore
    strMessage = strMessage & vbCrLf & "  Gaming graphics: " & wSAT.D3DScore
    WScript.Echo strMessage
Next
On Error Goto 0


strMessage = ""
Set myEnum = objWMI.ExecQuery("SELECT * from Win32_OperatingSystem WHERE Primary = True")
For Each w32OS In myEnum
    strMessage = ""
    strMessage = strMessage & vbCrLf & "Win32_OperatingSystem (Primary):"
    strMessage = strMessage & vbCrLf & "  BootDevice: " & w32OS.BootDevice
    strMessage = strMessage & vbCrLf & "  BuildNumber: " & w32OS.BuildNumber
    strMessage = strMessage & vbCrLf & "  BuildType: " & w32OS.BuildType
    strMessage = strMessage & vbCrLf & "  Caption: " & w32OS.Caption
    strMessage = strMessage & vbCrLf & "  Codeset: " & w32OS.Codeset
    strMessage = strMessage & vbCrLf & "  CountryCode: " & w32OS.CountryCode
    strMessage = strMessage & vbCrLf & "  CSDVersion: " & w32OS.CSDVersion
    strMessage = strMessage & vbCrLf & "  CSName: " & w32OS.CSName
    strMessage = strMessage & vbCrLf & "  CurrentTimeZone (min): " & w32OS.CurrentTimeZone
    strMessage = strMessage & vbCrLf & "  Description: " & w32OS.Description
    strMessage = strMessage & vbCrLf & "  EncryptionLevel: " & w32OS.EncryptionLevel
    strMessage = strMessage & vbCrLf & "  InstallDate: " & w32OS.InstallDate
'	strMessage = strMessage & vbCrLf & "  InstallDate: " & SWbemDateStringToDateString(w32OS.InstallDate)
    strMessage = strMessage & vbCrLf & "  LastBootupTime: " & w32OS.LastBootupTime
    ' strMessage = strMessage & vbCrLf & "  "  UpTime: " & Now() - WMIDateStringToDate(w32OS.LastBootupTime)
    strMessage = strMessage & vbCrLf & "  LocalDateTime: " & w32OS.LocalDateTime
    strMessage = strMessage & vbCrLf & "  Locale: " & w32OS.Locale
    strMessage = strMessage & vbCrLf & "  Name: " & w32OS.Name
    strMessage = strMessage & vbCrLf & "  OperatingSystemSKU: " & w32OS.OperatingSystemSKU
    strMessage = strMessage & vbCrLf & "  Organization: " & w32OS.Organization
    strMessage = strMessage & vbCrLf & "  OSArchitecture: " & w32OS.OSArchitecture
    strMessage = strMessage & vbCrLf & "  OSLanguage: " & w32OS.OSLanguage
    strMessage = strMessage & vbCrLf & "  OSProductSuite: " & w32OS.OSProductSuite
    strMessage = strMessage & vbCrLf & "  OSType: " & w32OS.OSType
    strMessage = strMessage & vbCrLf & "  OtherTypeDescription: " & w32OS.OtherTypeDescription
    strMessage = strMessage & vbCrLf & "  PortableOperatingSystem: " & w32OS.PortableOperatingSystem
    strMessage = strMessage & vbCrLf & "  Primary: " & w32OS.Primary
    strMessage = strMessage & vbCrLf & "  RegisteredUser: " & w32OS.RegisteredUser
    strMessage = strMessage & vbCrLf & "  SerialNumber: " & w32OS.SerialNumber
    strMessage = strMessage & vbCrLf & "  ServicePackMajorVersion: " & w32OS.ServicePackMajorVersion
    strMessage = strMessage & vbCrLf & "  ServicePackMinorVersion: " & w32OS.ServicePackMinorVersion
    strMessage = strMessage & vbCrLf & "  SystemDevice: " & w32OS.SystemDevice
    strMessage = strMessage & vbCrLf & "  SystemDrive: " & w32OS.SystemDrive
    strMessage = strMessage & vbCrLf & "  SystemDirectory: " & w32OS.SystemDirectory
    strMessage = strMessage & vbCrLf & "  TotalVisibleMemorySize: " & w32OS.TotalVisibleMemorySize
    strMessage = strMessage & vbCrLf & "  Version: " & w32OS.Version
    strMessage = strMessage & vbCrLf & "  WindowsDirectory: " & w32OS.WindowsDirectory
    WScript.Echo strMessage
Next

strMessage = ""
Set myEnum = objWMI.ExecQuery("SELECT * FROM Win32_DiskDrive")
For Each w32dd In myEnum
    strMessage = ""
    strMessage = strMessage & vbCrLf & "Win32_DiskDrive:"
    strMessage = strMessage & vbCrLf & "  DeviceID: " & w32dd.DeviceID
    strMessage = strMessage & vbCrLf & "    Caption: " & w32dd.Caption
    strMessage = strMessage & vbCrLf & "    Description: " & w32dd.Description
    strMessage = strMessage & vbCrLf & "    Manufacturer: " & w32dd.Manufacturer
    strMessage = strMessage & vbCrLf & "    MediaLoaded: " & w32dd.MediaLoaded
    strMessage = strMessage & vbCrLf & "    MediaType: " & w32dd.MediaType
    strMessage = strMessage & vbCrLf & "    Model: " & w32dd.Model
    strMessage = strMessage & vbCrLf & "    Name : " & w32dd.Name 
    strMessage = strMessage & vbCrLf & "    Partitions : " & w32dd.Partitions 
    strMessage = strMessage & vbCrLf & "    Signature : " & w32dd.Signature 
    strMessage = strMessage & vbCrLf & "    Size: " & w32dd.Size
    WScript.Echo strMessage
Next


strMessage = ""
Set myEnum = objWMI.ExecQuery("SELECT * FROM Win32_DiskPartition")
For Each w32ld In myEnum
    strMessage = ""
    strMessage = strMessage & vbCrLf & "Win32_DiskPartition:"
    strMessage = strMessage & vbCrLf & "  DeviceID: " & w32ld.DeviceID
    strMessage = strMessage & vbCrLf & "    Access: " & w32ld.Access
    strMessage = strMessage & vbCrLf & "    Availability: " & w32ld.Availability
    strMessage = strMessage & vbCrLf & "    Blocksize: " & w32ld.Blocksize
    strMessage = strMessage & vbCrLf & "    Bootable: " & w32ld.Bootable
    strMessage = strMessage & vbCrLf & "    BootPartition: " & w32ld.BootPartition
    strMessage = strMessage & vbCrLf & "    Caption: " & w32ld.Caption
    strMessage = strMessage & vbCrLf & "    ConfigManagerErrorCode: " & w32ld.ConfigManagerErrorCode
    strMessage = strMessage & vbCrLf & "    Description: " & w32ld.Description
    strMessage = strMessage & vbCrLf & "    DiskIndex: " & w32ld.DiskIndex
    strMessage = strMessage & vbCrLf & "    Index: " & w32ld.Index
    strMessage = strMessage & vbCrLf & "    InstallDate: " & w32ld.InstallDate
    strMessage = strMessage & vbCrLf & "    Name: " & w32ld.Name
    strMessage = strMessage & vbCrLf & "    PNPDeviceId: " & w32ld.PNPDeviceId
    strMessage = strMessage & vbCrLf & "    PrimaryPartition: " & w32ld.PrimaryPartition
    strMessage = strMessage & vbCrLf & "    Purpose: " & w32ld.Purpose
    strMessage = strMessage & vbCrLf & "    Size: " & w32ld.Size
    strMessage = strMessage & vbCrLf & "    Status: " & w32ld.Status
    strMessage = strMessage & vbCrLf & "    StatusInfo: " & w32ld.StatusInfo
    strMessage = strMessage & vbCrLf & "    Type: " & w32ld.Type
    WScript.Echo strMessage
Next

strMessage = ""
Set myEnum = objWMI.ExecQuery("SELECT * FROM Win32_CDROMDrive")
For Each w32dd In myEnum
    strMessage = ""
    strMessage = strMessage & vbCrLf & "Win32_CDROMDrive:"
    strMessage = strMessage & vbCrLf & "  DeviceID: " & w32dd.DeviceID
    strMessage = strMessage & vbCrLf & "    Caption: " & w32dd.Caption
    strMessage = strMessage & vbCrLf & "    Description: " & w32dd.Description
    strMessage = strMessage & vbCrLf & "    Drive: " & w32dd.Drive
    ' strMessage = strMessage & vbCrLf & "    Id: " & w32dd.Id
    strMessage = strMessage & vbCrLf & "    Manufacturer: " & w32dd.Manufacturer
    strMessage = strMessage & vbCrLf & "    MediaLoaded: " & w32dd.MediaLoaded
    strMessage = strMessage & vbCrLf & "    MediaType: " & w32dd.MediaType
    strMessage = strMessage & vbCrLf & "    Name : " & w32dd.Name 
    strMessage = strMessage & vbCrLf & "    RevisionLevel: " & w32dd.RevisionLevel
    strMessage = strMessage & vbCrLf & "    Size: " & w32dd.Size
    strMessage = strMessage & vbCrLf & "    VolumeName: " & w32dd.VolumeName
    strMessage = strMessage & vbCrLf & "    VolumeSerialNumber: " & w32dd.VolumeSerialNumber
    WScript.Echo strMessage
Next

strMessage = ""
strMessage = strMessage & vbCrLf & "Win32_LogicalDisk (non-network):"
Set myEnum = objWMI.ExecQuery("SELECT * FROM Win32_LogicalDisk WHERE DriveType <> 4")
For Each w32ld In myEnum
    strMessage = strMessage & vbCrLf & "  DeviceID: " & w32ld.DeviceID
    strMessage = strMessage & vbCrLf & "    DriveType: " & w32ld.DriveType
    strMessage = strMessage & vbCrLf & "    FileSystem: " & w32ld.FileSystem
    strMessage = strMessage & vbCrLf & "    Size: " & w32ld.Size
Next
WScript.Echo strMessage

' ***************************************************************************
' ***    N E T W O R K     I N F O R M A T I O N                          ***
' ***************************************************************************

'strMessage = ""
''Set myEnum = objWMI.ExecQuery("SELECT * FROM Win32_NetworkAdapter")
'Set myEnum = objWMI.ExecQuery("SELECT * FROM Win32_NetworkAdapter WHERE NetConnectionStatus IS NOT NULL")
''Set myEnum = objWMI.ExecQuery("SELECT * FROM Win32_NetworkAdapter WHERE MACAddress IS NOT NULL")
'For Each w32na In myEnum
'  strMessage = ""
'  strMessage = strMessage & vbCrLf & "Win32_NetworkAdapter (connected):"
'  strMessage = strMessage & vbCrLf & "  DeviceID: " & w32na.DeviceID
'  strMessage = strMessage & vbCrLf & "    AdapterType: " & w32na.AdapterType
'  strMessage = strMessage & vbCrLf & "    AdapterTypeID: " & w32na.AdapterTypeID
'  strMessage = strMessage & vbCrLf & "    AutoSense: " & w32na.AutoSense
'  strMessage = strMessage & vbCrLf & "    Availability: " & w32na.Availability
'  strMessage = strMessage & vbCrLf & "    Caption: " & w32na.Caption
'  strMessage = strMessage & vbCrLf & "    Description: " & w32na.Description 
'  strMessage = strMessage & vbCrLf & "    Index: " & w32na.Index
'  strMessage = strMessage & vbCrLf & "    Installed: " & w32na.Installed
'  strMessage = strMessage & vbCrLf & "    MACAddress: " & w32na.MACAddress
'  strMessage = strMessage & vbCrLf & "    Manufacturer: " & w32na.Manufacturer
'  strMessage = strMessage & vbCrLf & "    MaxSpeed: " & w32na.MaxSpeed
'  strMessage = strMessage & vbCrLf & "    Name: " & w32na.Name
'  strMessage = strMessage & vbCrLf & "    NetConnectionID: " & w32na.NetConnectionID
'  strMessage = strMessage & vbCrLf & "    NetConnectionStatus: " & w32na.NetConnectionStatus
'  strMessage = strMessage & vbCrLf & "    NetworkAddresses: " & w32na.NetworkAddresses
'  strMessage = strMessage & vbCrLf & "    PermanentAddress: " & w32na.PermanentAddress
'  strMessage = strMessage & vbCrLf & "    ProductName: " & w32na.ProductName
'  strMessage = strMessage & vbCrLf & "    ServiceName: " & w32na.ServiceName
'  strMessage = strMessage & vbCrLf & "    Speed: " & w32na.Speed
'  strMessage = strMessage & vbCrLf & "    StatusInfo: " & w32na.StatusInfo
'  strMessage = strMessage & vbCrLf & "    TimeOfLastReset: " & w32na.TimeOfLastReset
'  'strMessage = strMessage & vbCrLf & "  " & networkadapter.DeviceID  & "    " & networkadapter.ProductName & "    " & networkadapter.AdapterType & "    " & networkadapter.Speed
'  WScript.Echo strMessage
'Next


'strMessage = ""
''Set myEnum = objWMI.ExecQuery("SELECT * FROM Win32_NetworkAdapter")
'Set myEnum = objWMI.ExecQuery("SELECT * FROM Win32_NetworkAdapterConfiguration")
''Set myEnum = objWMI.ExecQuery("SELECT * FROM Win32_NetworkAdapter WHERE MACAddress IS NOT NULL")
'For Each w32nac In myEnum
'  strMessage = ""
'  strMessage = strMessage & vbCrLf & "Win32_NetworkAdapterConfiguration:"
'  strMessage = strMessage & vbCrLf & "  Index: " & w32nac.Index
'  strMessage = strMessage & vbCrLf & "    Caption: " & w32nac.Caption
'  strMessage = strMessage & vbCrLf & "    Description: " & w32nac.Description 
'  strMessage = strMessage & vbCrLf & "    DHCPEnabled: " & w32nac.DHCPEnabled
''  strMessage = strMessage & vbCrLf & "    Index: " & w32nac.Index
'  On Error Resume Next
'  strMessage = strMessage & vbCrLf & "    IPAddress: " & w32nac.IPAddress(0)
'  On Error Goto 0
'  strMessage = strMessage & vbCrLf & "    MACAddress: " & w32nac.MACAddress
'  strMessage = strMessage & vbCrLf & "    ServiceName: " & w32nac.ServiceName
'  WScript.Echo strMessage
'Next


strMessage = ""
Set myEnum = objWMI.ExecQuery("SELECT * FROM Win32_NetworkAdapterSetting")
For Each w32nas In myEnum
    'Set w32nac = objWMI.AssociatorsOf( w32nas.Setting, "Win32_NetworkAdapterConfiguration")
    Set w32na  = objWMI.get(w32nas.Element)
    strMessage = ""
    'strMessage = strMessage & vbCrLf & "ref Adapter: " & w32nas.Element
    'strMessage = strMessage & vbCrLf & "ref Configuration: " & w32nas.Setting
    'strMessage = strMessage & vbCrLf & "Type: " & TypeName(w32nac)
    If IsNumeric(w32na.NetConnectionStatus) Then
        Set w32nac = objWMI.Get(w32nas.Setting)
        strMessage = strMessage & vbCrLf & "Win32_NetworkAdapter (" & LookupNetworkConnectionStatus(w32na.NetConnectionStatus) & "):"
        strMessage = strMessage & vbCrLf & "  DeviceID: " & w32na.DeviceID
        strMessage = strMessage & vbCrLf & "    AdapterType: " & w32na.AdapterType
        strMessage = strMessage & vbCrLf & "    AdapterTypeID: " & w32na.AdapterTypeID
        strMessage = strMessage & vbCrLf & "    AutoSense: " & w32na.AutoSense
        strMessage = strMessage & vbCrLf & "    Availability: " & w32na.Availability
        strMessage = strMessage & vbCrLf & "    Caption: " & w32na.Caption
        strMessage = strMessage & vbCrLf & "    Description: " & w32na.Description 
        strMessage = strMessage & vbCrLf & "    Index: " & w32na.Index
        strMessage = strMessage & vbCrLf & "    Installed: " & w32na.Installed
        strMessage = strMessage & vbCrLf & "    MACAddress: " & w32na.MACAddress
        strMessage = strMessage & vbCrLf & "    Manufacturer: " & w32na.Manufacturer
        strMessage = strMessage & vbCrLf & "    MaxSpeed: " & w32na.MaxSpeed
        strMessage = strMessage & vbCrLf & "    Name: " & w32na.Name
        strMessage = strMessage & vbCrLf & "    NetConnectionID: " & w32na.NetConnectionID
        strMessage = strMessage & vbCrLf & "    NetConnectionStatus: " & w32na.NetConnectionStatus & "  " & LookupNetworkConnectionStatus(w32na.NetConnectionStatus)
        strMessage = strMessage & vbCrLf & "    NetworkAddresses: " & w32na.NetworkAddresses
        strMessage = strMessage & vbCrLf & "    PermanentAddress: " & w32na.PermanentAddress
        strMessage = strMessage & vbCrLf & "    ProductName: " & w32na.ProductName
        strMessage = strMessage & vbCrLf & "    ServiceName: " & w32na.ServiceName
        strMessage = strMessage & vbCrLf & "    Speed: " & w32na.Speed
        strMessage = strMessage & vbCrLf & "    StatusInfo: " & w32na.StatusInfo
        strMessage = strMessage & vbCrLf & "    TimeOfLastReset: " & w32na.TimeOfLastReset
        'strMessage = strMessage & vbCrLf & "  " & networkadapter.DeviceID  & "    " & networkadapter.ProductName & "    " & networkadapter.AdapterType & "    " & networkadapter.Speed
        'strMessage = strMessage & vbCrLf & ""
        strMessage = strMessage & vbCrLf & "  Win32_NetworkAdapterConfiguration:"
        strMessage = strMessage & vbCrLf & "    Index: " & w32nac.Index
        strMessage = strMessage & vbCrLf & "      Caption: " & w32nac.Caption
        strMessage = strMessage & vbCrLf & "      Description: " & w32nac.Description 
        strMessage = strMessage & vbCrLf & "      DefaultIPGateway(GatewayCostMetric): "
        If Not IsNull(w32nac.DefaultIPGateway) Then
            For i = LBound(w32nac.DefaultIPGateway) To UBound(w32nac.DefaultIPGateway)
                strMessage = strMessage & w32nac.DefaultIPGateway(i)
                strMessage = strMessage & "(" & w32nac.GatewayCostMetric(i) & ")"
                If i <> UBound(w32nac.DefaultIPGateway) Then
                    strMessage = strMessage & ", "
                End If
            Next
        End If
        strMessage = strMessage & vbCrLf & "      DHCPEnabled: " & w32nac.DHCPEnabled
        strMessage = strMessage & vbCrLf & "      DHCPLeaseExpires: " & w32nac.DHCPLeaseExpires
        strMessage = strMessage & vbCrLf & "      DHCPLeaseObtained: " & w32nac.DHCPLeaseObtained
        strMessage = strMessage & vbCrLf & "      DHCPServer: " & w32nac.DHCPServer
        strMessage = strMessage & vbCrLf & "      DNSDomain: " & w32nac.DNSDomain
        strMessage = strMessage & vbCrLf & "      DNSHostname: " & w32nac.DNSHostname
        strMessage = strMessage & vbCrLf & "      DNSServerSearchOrder: "
        If Not IsNull(w32nac.DNSServerSearchOrder) Then
            For i = LBound(w32nac.DNSServerSearchOrder) To UBound(w32nac.DNSServerSearchOrder)
                strMessage = strMessage & w32nac.DNSServerSearchOrder(i)
                If i <> UBound(w32nac.DNSServerSearchOrder) Then
                    strMessage = strMessage & ", "
                End If
            Next
        End If
        strMessage = strMessage & vbCrLf & "      IPAddress: "
        If Not IsNull(w32nac.IPAddress) Then
            For i = LBound(w32nac.IPAddress) To UBound(w32nac.IPAddress)
                strMessage = strMessage & w32nac.IPAddress(i)
                If i <> UBound(w32nac.IPAddress) Then
                    strMessage = strMessage & ", "
                End If
            Next
        End If
        strMessage = strMessage & vbCrLf & "      IPConnectionMetric: " & w32nac.IPConnectionMetric
        strMessage = strMessage & vbCrLf & "      IPEnabled: " & w32nac.IPEnabled
        strMessage = strMessage & vbCrLf & "      IPFilterSecurityEnabled: " & w32nac.IPFilterSecurityEnabled 
        strMessage = strMessage & vbCrLf & "      IPSubnet: "
        If Not IsNull(w32nac.IPSubnet) Then
            For i = LBound(w32nac.IPSubnet) To UBound(w32nac.IPSubnet)
                strMessage = strMessage & w32nac.IPSubnet(i)
                If i <> UBound(w32nac.IPSubnet) Then
                    strMessage = strMessage & ", "
                End If
            Next
        End If
        strMessage = strMessage & vbCrLf & "      MACAddress: " & w32nac.MACAddress
        strMessage = strMessage & vbCrLf & "      MTU: " & w32nac.MTU
        strMessage = strMessage & vbCrLf & "      WINSEnableLMHostsLookup: " & w32nac.WINSEnableLMHostsLookup
        strMessage = strMessage & vbCrLf & "      WINSHostLookupFile: " & w32nac.WINSHostLookupFile
        strMessage = strMessage & vbCrLf & "      WINSPrimaryServer: " & w32nac.WINSPrimaryServer
        strMessage = strMessage & vbCrLf & "      WINSSecondaryServer: " & w32nac.WINSSecondaryServer
        WScript.Echo strMessage
    End If
    WScript.Sleep 10 ' Stops the process using 100% CPU during loop
Next


' ***************************************************************************
' ***    W I F I       I N F O R M A T I O N                              ***
' ***************************************************************************

Set objWMI = GetObject("winmgmts:{impersonationlevel=impersonate}!\\" & strComputerName & "\root\wmi")
strMessage = ""
strMessage = GetWifiInfo()
WScript.Echo strMessage


' ***************************************************************************
' ***    S M B I O S     I N F O R M A T I O N                            ***
' ***************************************************************************

'strMessage = ""
'strMessage = strMessage & vbCrLf & "Product information:"
'Set myenum = objWMI.ExecQuery("select * from Win32_Product")
'For Each product In myenum
'  strMessage = strMessage & vbCrLf & "  " & product.Vendor & "    " & product.Name & "    " & product.Version
'Next

'strMessage = ""
'strMessage = strMessage & vbCrLf & ""
'WScript.Echo strMessage & "Change to NAMESPACE root\wmi"
Set objWMI = GetObject("winmgmts:{impersonationlevel=impersonate}!\\" & strComputerName & "\root\wmi")

strMessage = ""
strMessage = strMessage & vbCrLf & "MSSmBios_RawSMBiosTables:"
Set myEnum = objWMI.ExecQuery("SELECT * FROM MSSmBios_RawSMBiosTables")
For Each smbios In myEnum
    strMessage = ""
    strMessage = strMessage & vbCrLf & "MSSmBios_RawSMBiosTable:"
    strMessage = strMessage & vbCrLf & "  DMIRevision: " & smbios.DMIRevision
    strMessage = strMessage & vbCrLf & "  Size: " & smbios.Size
    strMessage = strMessage & vbCrLf & "  SmbiosMajorVersion: " & smbios.SmbiosMajorVersion
    strMessage = strMessage & vbCrLf & "  SmbiosMinorVersion: " & smbios.SmbiosMinorVersion
    strMessage = strMessage & vbCrLf & "  Used20CallingMethod: " & smbios.Used20CallingMethod
    'strMessage = strMessage & vbCrLf & "  SMBiosData: " & smbios.SMBiosData
    WScript.Echo strMessage
    
    Call ParseSmBios(smbios)
Next


' ***************************************************************************
' ***    . N e t   F r a m e w o r k                     ***
' ***************************************************************************

strMessage = ""
strMessage = strMessage & vbCrLf & ".Net Framework (via StrRegProv):"
strMessage = strMessage & vbCrLf & "  Framework name        |  Version         |  Other           "
strMessage = strMessage & vbCrLf & "  ----------------------+------------------+------------------"

Set objWMI = GetObject("winmgmts:{impersonationlevel=impersonate}!\\" & strComputerName & "\root\default:StdRegProv")
strBaseKey = "SOFTWARE\Microsoft\NET Framework Setup\NDP\"

Set rsDataList = CreateObject("ADODB.Recordset")
rsDataList.Fields.Append "MajorVersionName", adVarChar, 255
rsDataList.Fields.Append "Version", adVarChar, 255
rsDataList.Fields.Append "SP", adInteger 

rsDataList.Open


iRC = objWMI.EnumKey(HKLM, strBaseKey, arSubKeys)
For Each strKey In arSubKeys
    rsDataList.AddNew
    rsDataList("MajorVersionName") = strKey
    strValue = ""
    iRC = objWMI.GetStringValue(HKLM, strBaseKey & strKey, "Version", strValue)
    If Not IsNull(strValue) Then
        rsDataList("Version") = strValue
        strValue = ""
        iRC = objWMI.GetDWORDValue(HKLM, strBaseKey & strKey, "SP", strValue)
        If Not IsNull(strValue) Then
            rsDataList("SP") = strValue
        End If
    Else
        iRC = objWMI.GetStringValue(HKLM, strBaseKey & strKey & "\Client", "Version", strValue)
        If Not IsNull(strValue) Then
            rsDataList("Version") = strValue
            strValue = ""
            iRC = objWMI.GetDWORDValue(HKLM, strBaseKey & strKey & "\Client", "SP", strValue)
            If Not IsNull(strValue) Then
                rsDataList("SP") = strValue
            End If
        Else
        
        End If
    End If
    rsDataList.Update
    WScript.Sleep 10 ' Stops the process using 100% CPU during loop
Next

rsDataList.Sort = "MajorVersionName"
rsDataList.MoveFirst
Do Until rsDataList.EOF

    strMessage = strMessage & vbCrLf & "  " & Left(rsDataList.Fields.Item("MajorVersionName"), 19)
    strMessage = strMessage & Space(20 - Len(Left(rsDataList.Fields.Item("MajorVersionName"), 19)))
    strMessage = strMessage & "  |  "
    If rsDataList.Fields.Item("Version") <> "" Then
        strMessage = strMessage & Left(rsDataList.Fields.Item("Version"), 13)
        strMessage = strMessage & Space(14 - Len(Left(rsDataList.Fields.Item("Version"), 13)))
    Else
        strMessage = strMessage & Space(14)
    End If
    strMessage = strMessage & "  |  "
    If rsDataList.Fields.Item("SP") <> 0 Then
        strMessage = strMessage & Left("Service Pack " & rsDataList.Fields.Item("SP"), 15)
    Else
        strMessage = strMessage & Space(15)
    End If
    rsDataList.MoveNext
    WScript.Sleep 10 ' Stops the process using 100% CPU during loop
Loop
rsDataList.Close

WScript.Echo strMessage

' ***************************************************************************
' ***    I N S T A L L E D    A P P L I C A T I O N S                     ***
' ***************************************************************************

strMessage = ""
strMessage = strMessage & vbCrLf & "Installed Applications (via StrRegProv):"

Set objWMI = GetObject("winmgmts:{impersonationlevel=impersonate}!\\" & strComputerName & "\root\default:StdRegProv")
strBaseKey = "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\"

Set rsDataList = CreateObject("ADODB.Recordset")
rsDataList.Fields.Append "ApplicationName", adVarChar, 255
rsDataList.Fields.Append "InstallDate", adVarChar, 255
rsDataList.Fields.Append "Version", adVarChar, 255
rsDataList.Open


iRC = objWMI.EnumKey(HKLM, strBaseKey, arSubKeys)
For Each strKey In arSubKeys
    strValue = ""
    iRC = objWMI.GetStringValue(HKLM, strBaseKey & strKey, "DisplayName", strValue)
    If iRC <> 0 Then
        objWMI.GetStringValue HKLM, strBaseKey & strKey, "QuietDisplayName", strValue
    End If
    If Trim(strValue) <> "" Then
        rsDataList.AddNew
        rsDataList("ApplicationName") = strValue
        strValue = ""
        iRC = objWMI.GetStringValue(HKLM, strBaseKey & strKey, "ParentDisplayName", strValue)
        If iRC = 0 Then
            If Trim(strValue) <> "" Then
                rsDataList("ApplicationName") = strValue & " (" & rsDataList("ApplicationName") & ")"
            End If
        End If
        strValue = ""
        iRC = objWMI.GetStringValue(HKLM, strBaseKey & strKey, "InstallDate", strValue)
        If Not IsNull(strValue) Then
            rsDataList("InstallDate") = strValue
        End If
        strValue = ""
        iRC = objWMI.GetStringValue(HKLM, strBaseKey & strKey, "DisplayVersion", strValue)
        If Trim(strValue) <> "" Then
            rsDataList("Version") = Trim(strValue)
        End If
        
        rsDataList("ApplicationName") = Replace(rsDataList("ApplicationName"), "Microsoft", "MS")
        rsDataList("ApplicationName") = Replace(rsDataList("ApplicationName"), "Windows", "Win")
        rsDataList("ApplicationName") = Replace(rsDataList("ApplicationName"), "Security", "Sec")
        rsDataList("ApplicationName") = Replace(rsDataList("ApplicationName"), "Software", "SW")
        rsDataList("ApplicationName") = Replace(rsDataList("ApplicationName"), "Office", "Off")
        rsDataList("ApplicationName") = Replace(rsDataList("ApplicationName"), "Update", "Upd")
        rsDataList("ApplicationName") = Replace(rsDataList("ApplicationName"), "Internet Explorer", "IE")
        rsDataList.Update
    End If
    WScript.Sleep 10 ' Stops the process using 100% CPU during loop
Next

If Not rsDataList.EOF Then
	strMessage = strMessage & vbCrLf & "  Name                                                          |  Installed  "
	strMessage = strMessage & vbCrLf & "  --------------------------------------------------------------+-------------"

	rsDataList.Sort = "ApplicationName"
	rsDataList.MoveFirst
	Do Until rsDataList.EOF

		strMessage = strMessage & vbCrLf & "  " & Left(rsDataList.Fields.Item("ApplicationName"), 59)
		strMessage = strMessage & Space(60 - Len(Left(rsDataList.Fields.Item("ApplicationName"), 59)))
		strMessage = strMessage & "  |  "
		If rsDataList.Fields.Item("InstallDate") <> "" Then
			strMessage = strMessage & Left(rsDataList.Fields.Item("InstallDate"), 12)
		Else
			strMessage = strMessage & Space(12)
		End If
		rsDataList.MoveNext
		WScript.Sleep 10 ' Stops the process using 100% CPU during loop
	Loop

	strMessage = strMessage & vbCrLf
	strMessage = strMessage & vbCrLf & "  Name                                                     |  Version         "
	strMessage = strMessage & vbCrLf & "  ---------------------------------------------------------+------------------"

	rsDataList.Sort = "ApplicationName"
	rsDataList.MoveFirst
	Do Until rsDataList.EOF

		If rsDataList.Fields.Item("Version") <> "" Then
			strMessage = strMessage & vbCrLf & "  " & Left(rsDataList.Fields.Item("ApplicationName"), 54)
			strMessage = strMessage & Space(55 - Len(Left(rsDataList.Fields.Item("ApplicationName"), 54)))
			strMessage = strMessage & "  |  "
			strMessage = strMessage & Left(rsDataList.Fields.Item("Version"), 17)
		End If
		rsDataList.MoveNext
		WScript.Sleep 10 ' Stops the process using 100% CPU during loop
	Loop
End If

rsDataList.Close

WScript.Echo strMessage

' ***************************************************************************
' ***    W I N D O W S    X P    U P D A T E S / P A T C H E S            ***
' ***************************************************************************

strMessage = ""
strMessage = strMessage & vbCrLf & "Windows XP Updates and Patches (via StrRegProv):"

Set objWMI = GetObject("winmgmts:{impersonationlevel=impersonate}!\\" & strComputerName & "\root\default:StdRegProv")
strBaseKey = "SOFTWARE\Microsoft\Updates\Windows XP\"

Set rsDataList = CreateObject("ADODB.Recordset")
rsDataList.Fields.Append "UpdateName", adVarChar, 255
'rsDataList.Fields.Append "InstalledDate", adVarChar, 255
rsDataList.Fields.Append "InstalledDate", adDate
rsDataList.Fields.Append "InstalledBy", adVarChar, 255
rsDataList.Fields.Append "Description", adVarChar, 255
rsDataList.Open

Set rsKeyList = CreateObject("ADODB.Recordset")
rsKeyList.Fields.Append "KeyName", adVarChar, 255
rsKeyList.Open

iRC = objWMI.EnumKey(HKLM, strBaseKey, arSubKeys)
If iRC = 0 Then ' Successful
    For Each strKey In arSubKeys
       rsKeyList.AddNew
       rsKeyList("KeyName") = strKey
       rsKeyList.Update
       WScript.Sleep 10 ' Stops the process using 100% CPU during loop
    Next

    rsKeyList.Sort = "KeyName"
    rsKeyList.MoveFirst
    Do Until rsKeyList.EOF
       strBaseKeySP = strBasekey & rsKeyList.Fields.Item("KeyName") & "\"
       iRC = objWMI.EnumKey(HKLM, strBaseKeySP, arSubKeys)
    If Not IsNull(arSubKeys) Then
            For Each strKey In arSubKeys
                strValue = ""
                iRC = objWMI.GetStringValue(HKLM, strBaseKeySP & strKey, "Description", strValue)
                If iRC <> 0 Then
                    strValue = strKey
                End If
                If strValue <> "" Then
                    rsDataList.AddNew
                    rsDataList("UpdateName") = strKey
                    rsDataList("Description") = strValue
                    strValue = ""
                    iRC = objWMI.GetStringValue(HKLM, strBaseKeySP & strKey, "InstalledDate", strValue)
                    If Not IsNull(strValue) Then
                        Dim arDate
                        arDate = Split(strValue, "/", 3)
                        rsDataList("InstalledDate") = DateSerial(arDate(2), arDate(0), arDate(1))
                    End If
                    strValue = ""
                    iRC = objWMI.GetStringValue(HKLM, strBaseKeySP & strKey, "Installedby", strValue)
                    If Not IsNull(strValue) Then
                        rsDataList("InstalledBy") = strValue
                    End If
                    strValue = ""
                    rsDataList.Update
                End If
                WScript.Sleep 10 ' Stops the process using 100% CPU during loop
            Next
        End If
        rsKeyList.MoveNext
    Loop
    rsKeyList.Close

    strMessage = strMessage & vbCrLf & "  Name             |  Installed   |  Installed By              "
    strMessage = strMessage & vbCrLf & "  -----------------+--------------+----------------------------"

    rsDataList.Sort = "InstalledDate, UpdateName"
    rsDataList.MoveFirst
    Do Until rsDataList.EOF
        strMessage = strMessage & vbCrLf & "  " & Left(rsDataList.Fields.Item("UpdateName"), 14)
        strMessage = strMessage & Space(15 - Len(Left(rsDataList.Fields.Item("UpdateName"), 14)))
        strMessage = strMessage & "  |  "
        If rsDataList.Fields.Item("InstalledDate") <> "" Then
            strMessage = strMessage & Left(rsDataList.Fields.Item("InstalledDate"), 10)
        strMessage = strMessage & Space(10 - Len(Left(rsDataList.Fields.Item("InstalledDate"), 10)))
        Else
            strMessage = strMessage & Space(10)
        End If
        strMessage = strMessage & "  |  "
        If rsDataList.Fields.Item("InstalledBy") <> "" Then
            strMessage = strMessage & rsDataList.Fields.Item("InstalledBy")
        Else
            strMessage = strMessage & Space(20)
        End If
        rsDataList.MoveNext
        WScript.Sleep 10 ' Stops the process using 100% CPU during loop
    Loop

    strMessage = strMessage & vbCrLf
    strMessage = strMessage & vbCrLf & "  Name             |  Description                                            "
    strMessage = strMessage & vbCrLf & "  -----------------+---------------------------------------------------------"

    rsDataList.Sort = "InstalledDate, UpdateName"
    rsDataList.MoveFirst
    Do Until rsDataList.EOF
        strMessage = strMessage & vbCrLf & "  " & Left(rsDataList.Fields.Item("UpdateName"), 14)
        strMessage = strMessage & Space(15 - Len(Left(rsDataList.Fields.Item("UpdateName"), 14)))
        strMessage = strMessage & "  |  "
        If rsDataList.Fields.Item("Description") <> "" Then
            strMessage = strMessage & Left(rsDataList.Fields.Item("Description"), 50)
        End If
        rsDataList.MoveNext
        WScript.Sleep 10 ' Stops the process using 100% CPU during loop
    Loop
    rsDataList.Close

    End If

WScript.Echo strMessage

strMessage = ""
strMessage = strMessage & vbCrLf & "** Finished **"
WScript.Echo strMessage


' ***************************************************************************
' ***              * * *     F I N I S H E D     * * *                    ***
' ***************************************************************************

Function GetWifiInfo()

' There appears to be a bug in the current implementation of these Classes
' Virtual and Packet drivers also return instances so we filter them out

    const MAX_WIFI_STRENGTH = -30

    On Error Resume Next

    Set objWMI = GetObject("winmgmts:{impersonationlevel=impersonate}!\\" & strComputerName & "\root\wmi")

    strMessage = ""
    Set myEnum = objWMI.ExecQuery("Select * from MSNdis_80211_ServiceSetIdentifier Where active=true")
    strMessage = strMessage & vbCrLf & "MSNdis_80211_ServiceSetIdentifier:"
    For Each objMSNdis_80211_ServiceSetIdentifier In myEnum
        If Err Then
            GetWifiInfo = strMessage & vbCrLf & "  No active 802.11 adaptors found"
            Exit Function
        End If

        If Instr(LCase(objMSNdis_80211_ServiceSetIdentifier.InstanceName), "virtual") = 0 and Instr(LCase(objMSNdis_80211_ServiceSetIdentifier.InstanceName), "packet") = 0 Then
            strSSID = ""
            For i = 1 to objMSNdis_80211_ServiceSetIdentifier.Ndis80211Ssid(0)
                If objMSNdis_80211_ServiceSetIdentifier.Ndis80211Ssid(i + 3) <> 0 Then
                    strSSID = strSSID & Chr(objMSNdis_80211_ServiceSetIdentifier.Ndis80211Ssid(i + 3))
                Else
                    Exit For
                End If
            Next
            
            strMessage = strMessage & vbCrLf & "  InstanceName: " & objMSNdis_80211_ServiceSetIdentifier.InstanceName
            strMessage = strMessage & vbCrLf & "  SSID: " & strSSID
        End If
        ' Exit For        ' Only read the first instance
        Err.Clear
    Next
        
    Set myEnum = objWMI.ExecQuery("Select * from MSNdis_80211_ReceivedSignalStrength Where active=true")
    strMessage = strMessage & vbCrLf
    strMessage = strMessage & vbCrLf & "MSNdis_80211_ReceivedSignalStrength:"
    For Each objMSNdis_80211_ReceivedSignalStrength in myEnum
        If Err Then
            GetWifiInfo = trMessage & vbCrLf & "  No active 802.11 adaptors found"
            Exit Function
        End If
        If Instr(LCase(objMSNdis_80211_ReceivedSignalStrength.InstanceName), "virtual") = 0 and Instr(LCase(objMSNdis_80211_ReceivedSignalStrength.InstanceName), "packet") = 0 Then
            strMessage = strMessage & vbCrLf & "  InstanceName: " & objMSNdis_80211_ReceivedSignalStrength.InstanceName
            SigStrength = objMSNdis_80211_ReceivedSignalStrength.Ndis80211ReceivedSignalStrength
            strMessage = strMessage & vbCrLf & "  Ndis80211ReceivedSignalStrength: " & CStr(SigStrength)
            SigStrengthBar=0
            SigStrengthString=""
            If SigStrength > -57 Then 
                SigStrengthBar=5
                SigStrengthString="Excellent"
            ElseIf SigStrength > -68 Then 
                SigStrengthBar=4
                SigStrengthString="Very Good"
            ElseIf SigStrength > -72 Then 
                SigStrengthBar=3
                SigStrengthString="Good"
            ElseIf SigStrength > -80 Then 
                SigStrengthBar=2
                SigStrengthString="Low"
            ElseIf SigStrength > -90 Then
                SigStrengthBar=1
                SigStrengthString="Very Low"
            End If
            strMessage = strMessage & vbCrLf & "  Signal strength string: " & SigStrengthString
            strMessage = strMessage & vbCrLf & "  Signal strength bar: " & SigStrengthBar
            strMessage = strMessage & vbCrLf & "  Signal strength percent: " & (SigStrength + 100) * (100 / (MAX_WIFI_STRENGTH + 100))
        End If
        'Exit For        ' Only read the first instance
        Err.Clear
    Next

    GetWifiInfo = strMessage
        
End Function

Function ParseSmBios(RawSmBios)

    ' SMBIOS property offsets 
    '  DMI_hh_PropertyName
    '      hh = Table Type represented in hex
    '     (....SI == String Index)
    Const DMI_TableType = 0
    Const DMI_TableLength = 1
    Const DMI_TableHandle = 2

    Const DMI_00_VendorSI = 4
    Const DMI_00_BIOSVersionSI = 5
    Const DMI_00_BIOSStartingAddress = 6
    Const DMI_00_BIOSReleaseDateSI = 8
    Const DMI_00_BIOSRBIOSROMSize = 9
    Const DMI_00_SystemBIOSMajorRelease = 20
    Const DMI_00_SystemBIOSMinorRelease = 21

    Const DMI_01_ManufacturerSI = 4
    Const DMI_01_ProductNameSI = 5
    Const DMI_01_VersionSI = 6
    Const DMI_01_SerialNoSI = 7
    Const DMI_01_UUID = 8
    Const DMI_01_WakeupType = 24
    Const DMI_01_SKUNumberSI = 25
    Const DMI_01_FamilySI = 26

    Const DMI_02_ManufacturerSI = 4
    Const DMI_02_ProductNameSI = 5
    Const DMI_02_VersionSI = 6
    Const DMI_02_SerialNoSI = 7

    Const DMI_03_ManufacturerSI = 4
    Const DMI_03_ChassisType = 5
    Const DMI_03_VersionSI = 6
    Const DMI_03_SerialNoSI = 7
    Const DMI_03_AssetTagNoSI = 8

    Const DMI_04_SocketDesignationSI = 4
    Const DMI_04_ProcessorType = 5
    Const DMI_04_ProcessorFamily = 6
    Const DMI_04_ManufacturerSI = 7
    Const DMI_04_ProcessorId1 = 8
    Const DMI_04_ProcessorId2 =12
    Const DMI_04_VersionSI = 16
    Const DMI_04_MaxSpeed = 20
    Const DMI_04_ProcessorUpgrade = 25
    Const DMI_04_CurrentSpeed = 22
    Const DMI_04_SerialNoSI = 32
    Const DMI_04_AssetTagSI = 33
    Const DMI_04_PartNoSI = 34
    Const DMI_04_CoreCount = 35
    Const DMI_04_CoreEnabled = 36
    Const DMI_04_ThreadCount = 37

    Const DMI_11_Size = 12
    Const DMI_11_FormFactor = 14
    Const DMI_11_DeviceLocatorSI = 16
    Const DMI_11_BankLocatorSI = 17
    Const DMI_11_MemoryType = 18
    Const DMI_11_Speed = 21
    Const DMI_11_ManufacturerSI = 23
    Const DMI_11_SerialNoSI = 24
    Const DMI_11_AssetTagSI = 25
    Const DMI_11_PartNoSI = 26
    Const DMI_11_ConfiguredMemoryClockSpeed = 32
    Const DMI_11_MinimumVoltage = 34
    Const DMI_11_MaximumVoltage = 36
    Const DMI_11_ConfiguredVoltage = 38


    Const DMI_80_Signature = 4
    Const DMI_80_PCID = 6
    Const DMI_80_BIOSLetter = 7
    
    
    
    Dim pSmBiosData
    ' Padded arraySmBiosData because sometimes the size of the SMBIOS changes without the size being changed
    ' E.g - on my Toshiba Notebook adding the extra battery increased the table without smbios.size changing
    ReDim arraySmBiosData(smbios.Size + 1024) 
    Dim varX
    DIm intStringPointer
    Dim strString(50)
    Dim strT
    Dim i
    Dim TableType
    Dim TableLength
    Dim TableHandle
    Dim strMessage
    
    i = 0
    For Each varX in smbios.SmBiosData
        arraySmBiosData(i) = varX
        i = i + 1
    Next

    If smbios.SmbiosMajorVersion > 3 Then
        WScript.Echo "WARNING: This has only been tested on machines up to SMBIOS 3.x version"
    End If

    strMessage = vbCrLf & "Parsed SMBIOS Tables:"
    WScript.Echo strMessage

    pSmBiosData = 0
    
    While pSmBiosData < smbios.Size	

        TableType = arraySmBiosData(pSmBiosData + DMI_TableType)
        TableLength = arraySmBiosData(pSmBiosData + DMI_TableLength)
        TableHandle = arraySmBiosData(pSmBiosData + DMI_TableHandle) + (256 * arraySmBiosData(pSmBiosData + DMI_TableHandle + 1))
        
        strMessage = "  Table=" & BYTEToString(TableType)
        strMessage = strMessage & "  " & LookupSmBiosTableName(TableType)

        ' Load all strings from end of table		
        For i = LBound(strString) To UBound(strString)
            strString(i) = ""
        Next

        i = 1
        intStringPointer = pSmBiosData + TableLength
        Do 
            While arraySmBiosData(intStringPointer) <> 0
                strString(i) = strString(i) & Chr(arraySmBiosData(intStringPointer))
                intStringPointer = intStringPointer + 1
            Wend
            ' WScript.Echo "      " & strString(i)
            intStringPointer = intStringPointer + 1
            i = i + 1
        Loop Until arraySmBiosData(intStringPointer) = 0

        ' Output strings
        'For i = LBound(strString) To UBound(strString)
        '	If strString(i) <> "" Then
        '		strMessage = strMessage & vbCrLf & "    Strings: " & strString(i)
        '	End If
        'Next

        ' Output specific table values
        Select Case TableType
        Case 0
            strMessage = strMessage & vbCrLf & "    Vendor: " & strString(arraySmBiosData(pSmBiosData + DMI_00_VendorSI))
            strMessage = strMessage & vbCrLf & "    Bios Version: " & strString(arraySmBiosData(pSmBiosData + DMI_00_BIOSVersionSI))
            strMessage = strMessage & vbCrLf & "    Bios Release Date: " & strString(arraySmBiosData(pSmBiosData + DMI_00_BIOSReleaseDateSI))
            strMessage = strMessage & vbCrLf & "    Start Address: " & WORDToHexString(arraySmBiosData(pSmBiosData + DMI_00_BIOSStartingAddress), arraySmBiosData(pSmBiosData + DMI_00_BIOSStartingAddress + 1))
            strMessage = strMessage & vbCrLf & "    Rom Size: " & BYTEToString(arraySmBiosData(pSmBiosData + DMI_00_BIOSRBIOSROMSize))
            If TableLength > 18 Then
                strMessage = strMessage & vbCrLf & "    Bios Version Major: " & BYTEToString(arraySmBiosData(pSmBiosData + DMI_00_SystemBIOSMajorRelease))
                strMessage = strMessage & vbCrLf & "    Bios Version Minor: " & BYTEToString(arraySmBiosData(pSmBiosData + DMI_00_SystemBIOSMinorRelease))
            End If
        Case 1
            strMessage = strMessage & vbCrLf & "    Manufacturer: " & strString(arraySmBiosData(pSmBiosData + DMI_01_ManufacturerSI))
            strMessage = strMessage & vbCrLf & "    Product Name: " & strString(arraySmBiosData(pSmBiosData + DMI_01_ProductNameSI))
            strMessage = strMessage & vbCrLf & "    Version: " & strString(arraySmBiosData(pSmBiosData + DMI_01_VersionSI))
            strMessage = strMessage & vbCrLf & "    Serial No: " & strString(arraySmBiosData(pSmBiosData + DMI_01_SerialNoSI))
            If TableLength > 8 Then
                strMessage = strMessage & vbCrLf & "    UUID: " 
                For i = 0 To 15
                    strMessage = strMessage & BYTEToHexString(arraySmBiosData(pSmBiosData + DMI_01_UUID + i))
                Next
                strMessage = strMessage & vbCrLf & "    Wakeup Type: " & BYTEToHexString(arraySmBiosData(pSmBiosData + DMI_01_WakeupType)) & "h   " & LookupWakeUpType(arraySmBiosData(pSmBiosData + DMI_01_WakeupType))
            End If
            If TableLength > 25 Then ' 2.4+
                strMessage = strMessage & vbCrLf & "    SKU Number: " & strString(arraySmBiosData(pSmBiosData + DMI_01_SKUNumberSI))
                strMessage = strMessage & vbCrLf & "    Family: " & strString(arraySmBiosData(pSmBiosData + DMI_01_FamilySI))
            End If
            If Instr(strString(arraySmBiosData(pSmBiosData + DMI_01_SerialNoSI)), "HPPAV") <> 0 Then
                ' This is a Pavilion
                strMessage = strMessage & vbCrLf & "    Decoded HP Pavilion information:"
                strT = ""
                strT = strT &       Mid(strString(arraySmBiosData(pSmBiosData + DMI_01_ProductNameSI)), 1, 2)
                strT = strT & "-" & Mid(strString(arraySmBiosData(pSmBiosData + DMI_01_ProductNameSI)), 3, 4)
                strT = strT & "-" & Mid(strString(arraySmBiosData(pSmBiosData + DMI_01_ProductNameSI)), 7, 4)
                strT = strT & "-" & Mid(strString(arraySmBiosData(pSmBiosData + DMI_01_ProductNameSI)), 11, 4)
                strT = strT & "-" & Mid(strString(arraySmBiosData(pSmBiosData + DMI_01_SerialNoSI)), 1, 4)
                strMessage = strMessage & vbCrLf & "      Support Id: " & strT
                strT = ""
                strT = strT & Mid(strString(arraySmBiosData(pSmBiosData + DMI_01_ManufacturerSI)), 12, 4)
                strMessage = strMessage & vbCrLf & "      Model No: " & strT
                strT = ""
                strT = strT & "xx"
                strT = strT & Mid(strString(arraySmBiosData(pSmBiosData + DMI_01_ProductNameSI)), 11, 4)
                strT = strT & Mid(strString(arraySmBiosData(pSmBiosData + DMI_01_SerialNoSI)), 1, 4)
                strMessage = strMessage & vbCrLf & "      Serial No: " & strT
                strT = ""
                strT = strT & Mid(strString(arraySmBiosData(pSmBiosData + DMI_01_ManufacturerSI)), 3, 3)
                strMessage = strMessage & vbCrLf & "      Hardware BOM No: " & strT
                strT = ""
                strT = strT & Mid(strString(arraySmBiosData(pSmBiosData + DMI_01_ManufacturerSI)), 6, 2)
                strMessage = strMessage & vbCrLf & "      Software BOM No: " & strT
                
            End If
        Case 2
            strMessage = strMessage & vbCrLf & "    Manufacturer: " & strString(arraySmBiosData(pSmBiosData + DMI_02_ManufacturerSI))
            strMessage = strMessage & vbCrLf & "    Product Name: " & strString(arraySmBiosData(pSmBiosData + DMI_02_ProductNameSI))
            strMessage = strMessage & vbCrLf & "    Version: " & strString(arraySmBiosData(pSmBiosData + DMI_02_VersionSI))
            strMessage = strMessage & vbCrLf & "    Serial No: " & strString(arraySmBiosData(pSmBiosData + DMI_02_SerialNoSI))
        Case 3
            strMessage = strMessage & vbCrLf & "    Manufacturer: " & strString(arraySmBiosData(pSmBiosData + DMI_03_ManufacturerSI))
            strMessage = strMessage & vbCrLf & "    Version: " & strString(arraySmBiosData(pSmBiosData + DMI_03_VersionSI))
            strMessage = strMessage & vbCrLf & "    Serial No: " & strString(arraySmBiosData(pSmBiosData + DMI_03_SerialNoSI))
            strMessage = strMessage & vbCrLf & "    Asset Tag No: " & strString(arraySmBiosData(pSmBiosData + DMI_03_AssetTagNoSI))
            strMessage = strMessage & vbCrLf & "    Chassis Type: " & BYTEToHexString(arraySmBiosData(pSmBiosData + DMI_03_ChassisType)) & "h   " & LookupChassisType(arraySmBiosData(pSmBiosData + DMI_03_ChassisType))
        Case 4
            strMessage = strMessage & vbCrLf & "    Manufacturer: " & strString(arraySmBiosData(pSmBiosData + DMI_04_ManufacturerSI))
            strMessage = strMessage & vbCrLf & "    Version: " & strString(arraySmBiosData(pSmBiosData + DMI_04_VersionSI))
            strMessage = strMessage & vbCrLf & "    Socket Designation: " & strString(arraySmBiosData(pSmBiosData + DMI_04_SocketDesignationSI))
            strMessage = strMessage & vbCrLf & "    Processor Type: " & BYTEToHexString(arraySmBiosData(pSmBiosData + DMI_04_ProcessorType)) & "h   " & LookupProcessorType(arraySmBiosData(pSmBiosData + DMI_04_ProcessorType))
            strMessage = strMessage & vbCrLf & "    Processor Family: " & BYTEToHexString(arraySmBiosData(pSmBiosData + DMI_04_ProcessorFamily)) & "h   " & LookupProcessorFamily(arraySmBiosData(pSmBiosData + DMI_04_ProcessorFamily))
            strMessage = strMessage & vbCrLf & "    Maximum Speed: " & WORDToString(arraySmBiosData(pSmBiosData + DMI_04_MaxSpeed), arraySmBiosData(pSmBiosData + DMI_04_MaxSpeed + 1))
            strMessage = strMessage & vbCrLf & "    Current Speed: " & WORDToString(arraySmBiosData(pSmBiosData + DMI_04_CurrentSpeed), arraySmBiosData(pSmBiosData + DMI_04_CurrentSpeed + 1))
            strMessage = strMessage & vbCrLf & "    Processor Id: "
            strMessage = strMessage & DWORDToHexString(arraySmBiosData(pSmBiosData + DMI_04_ProcessorId2), arraySmBiosData(pSmBiosData + DMI_04_ProcessorId2 + 1), arraySmBiosData(pSmBiosData + DMI_04_ProcessorId2 + 2), arraySmBiosData(pSmBiosData + DMI_04_ProcessorId2 + 3))
            strMessage = strMessage & DWORDToHexString(arraySmBiosData(pSmBiosData + DMI_04_ProcessorId1), arraySmBiosData(pSmBiosData + DMI_04_ProcessorId1 + 1), arraySmBiosData(pSmBiosData + DMI_04_ProcessorId1 + 2), arraySmBiosData(pSmBiosData + DMI_04_ProcessorId1 + 3))
            strMessage = strMessage & vbCrLf & "    Processor Upgrade: " & BYTEToHexString(arraySmBiosData(pSmBiosData + DMI_04_ProcessorUpgrade)) & "h   " & LookupProcessorUpgrade(arraySmBiosData(pSmBiosData + DMI_04_ProcessorUpgrade))
            If TableLength > 32 Then
                strMessage = strMessage & vbCrLf & "    Serial No: " & strString(arraySmBiosData(pSmBiosData + DMI_04_SerialNoSI))
                strMessage = strMessage & vbCrLf & "    Asset Tag No: " & strString(arraySmBiosData(pSmBiosData + DMI_04_AssetTagNoSI))
                strMessage = strMessage & vbCrLf & "    Part No: " & strString(arraySmBiosData(pSmBiosData + DMI_04_PartNoSI))
            End If
            If TableLength > 35 Then
                strMessage = strMessage & vbCrLf & "    Core Count: " & BYTEToString(arraySmBiosData(pSmBiosData + DMI_04_CoreCount))
                strMessage = strMessage & vbCrLf & "    Core Enabled: " & BYTEToString(arraySmBiosData(pSmBiosData + DMI_04_CoreEnabled))
                strMessage = strMessage & vbCrLf & "    Thread Count: " & BYTEToString(arraySmBiosData(pSmBiosData + DMI_04_ThreadCount))
            End If
        Case 17
            strMessage = strMessage & vbCrLf & "    Device Locator: " & strString(arraySmBiosData(pSmBiosData + DMI_11_DeviceLocatorSI))
            strMessage = strMessage & vbCrLf & "    Bank Locator: " & strString(arraySmBiosData(pSmBiosData + DMI_11_BankLocatorSI))
            strMessage = strMessage & vbCrLf & "    Size (MBytes): " & WordToString(arraySmBiosData(pSmBiosData + DMI_11_Size), arraySmBiosData(pSmBiosData + DMI_11_Size + 1))
            strMessage = strMessage & vbCrLf & "    Form Factor: " & BYTEToHexString(arraySmBiosData(pSmBiosData + DMI_11_FormFactor)) & "h   " & LookupMemoryFormFactor(arraySmBiosData(pSmBiosData + DMI_11_FormFactor))
            strMessage = strMessage & vbCrLf & "    Memory Type: " & BYTEToHexString(arraySmBiosData(pSmBiosData + DMI_11_MemoryType)) & "h   " & LookupMemoryType(arraySmBiosData(pSmBiosData + DMI_11_MemoryType))
            If TableLength > 20 Then
				strMessage = strMessage & vbCrLf & "    Speed (MHz): " & WordToString(arraySmBiosData(pSmBiosData + DMI_11_Speed), arraySmBiosData(pSmBiosData + DMI_11_Speed + 1))
            End If
            If TableLength > 22 Then
                strMessage = strMessage & vbCrLf & "    Manufacturer: " & strString(arraySmBiosData(pSmBiosData + DMI_11_ManufacturerSI))
                strMessage = strMessage & vbCrLf & "    Serial No: " & strString(arraySmBiosData(pSmBiosData + DMI_11_SerialNoSI))
                strMessage = strMessage & vbCrLf & "    Asset Tag No: " & strString(arraySmBiosData(pSmBiosData + DMI_11_AssetTagNoSI))
                strMessage = strMessage & vbCrLf & "    Part No: " & strString(arraySmBiosData(pSmBiosData + DMI_11_PartNoSI))
            End If
            If TableLength > 32 Then
                strMessage = strMessage & vbCrLf & "    Configured Memory Clock Speed (MHz): " & WORDToString(arraySmBiosData(pSmBiosData + DMI_11_ConfiguredMemoryClockSpeed), arraySmBiosData(pSmBiosData + DMI_11_ConfiguredMemoryClockSpeed + 1))
            End If
            If TableLength > 34 Then
                strMessage = strMessage & vbCrLf & "    Minimum Voltage (mV): " & WORDToString(arraySmBiosData(pSmBiosData + DMI_11_MaximumVoltage), arraySmBiosData(pSmBiosData + DMI_11_MaximumVoltage + 1))
                strMessage = strMessage & vbCrLf & "    Maximum Voltage (mV): " & WORDToString(arraySmBiosData(pSmBiosData + DMI_11_MinimumVoltage), arraySmBiosData(pSmBiosData + DMI_11_MinimumVoltage + 1))
                strMessage = strMessage & vbCrLf & "    Configured Voltage (mV): " & WORDToString(arraySmBiosData(pSmBiosData + DMI_11_ConfiguredVoltage), arraySmBiosData(pSmBiosData + DMI_11_ConfiguredVoltage + 1))
            End If
        Case 128
            strMessage = strMessage & vbCrLf & "    PCID: " & BYTEToString(arraySmBiosData(pSmBiosData + DMI_80_PCID))
            strMessage = strMessage & vbCrLf & "    Signature: " & Chr(arraySmBiosData(pSmBiosData + DMI_80_Signature)) & Chr(arraySmBiosData(pSmBiosData + DMI_80_Signature + 1))
            strMessage = strMessage & vbCrLf & "    BIOS Letters: " & Chr(arraySmBiosData(pSmBiosData + DMI_80_BIOSLetter)) & Chr(arraySmBiosData(pSmBiosData + DMI_80_BIOSLetter + 1))
        Case Else
            For i = LBound(strString) To UBound(strString)
                If strString(i) <> "" Then
                    strMessage = strMessage & vbCrLf & "    Strings: " & strString(i)
                End If
            Next
            'If Len(strMessage ) > 0 Then
            '	strMessage = Mid(strMessage,3)
            'End If
    
        End Select

        WScript.Echo strMessage
        
        ' Find next table in array
        pSmBiosData = pSmBiosData + TableLength
        While (arraySmBiosData(pSmBiosData) <> 0) Or (arraySmBiosData(pSmBiosData + 1) <> 0)
            pSmBiosData = pSmBiosData + 1
        Wend
        pSmBiosData = pSmBiosData + 2
        'WScript.Echo CStr(pSmBiosData)

    Wend


End Function

Function BYTEToHexString(Part1)

    Dim strString
    
    strString = ""
    strString = CStr(Hex(Part1))
    If Len(strString) = 1 Then
        strString = "0" & strString
    End If
    
    BYTEToHexString = strString

End Function

Function BYTEToString(Part1)

    Dim strString
    
    strString = ""
    strString = CStr(Part1)
    
    BYTEToString = strString

End Function
Function DWORDToHexString(Part1, Part2, Part3, Part4)

    Dim strString
    
    strString = BYTEToHexString(Part4) & BYTEToHexString(Part3)
    strString = strString & BYTEToHexString(Part2) & BYTEToHexString(Part1)
    
    DWORDToHexString = strString

End Function

Function WORDToHexString(Part1, Part2)

    Dim strString
    
    strString = BYTEToHexString(Part2) & BYTEToHexString(Part1)
    'strString = CStr(Hex(Part1 + (256 * Part2)))
    
    WORDToHexString = strString

End Function

Function WORDToString(Part1, Part2)

    Dim strString
    
    strString = CStr(Part1 + (256 * Part2))
    
    WORDToString = strString

End Function

Function SWbemDateStringToDate(varT)
    Set DateTime = CreateObject("WbemScripting.SWbemDateTime")
    DateTime.Value = varT
    SwbemDateStringToDate = DateTime.GetVarDate
End Function

Function WMIDateStringToDateTime(strT)
    ' Convert WMI DateString into native Date format

    ' As usual MS Example only works in the US !!!!!
    '     WMIDateStringToDate = CDate(Mid(strT, 5, 2) & "/" & Mid(strT, 7, 2) & "/" & Left(strT, 4) & " " & Mid(strT, 9, 2) & ":" & Mid(strT, 11, 2) & ":" & Mid(strT,13, 2))
    
    WMIDateStringToDateTime = DateSerial(Left(strT, 4), Mid(strT, 5, 2), Mid(strT, 7, 2)) + TimeSerial(Mid(strT, 9, 2), Mid(strT, 11, 2), Mid(strT,13, 2))

End Function

Function DecodeVariant(varT)

    Dim strReturn
    Dim varX
    Dim objArrayConvert
    
    strReturn = ""

    'WScript.Echo CStr(VarType(varT))
    Select Case VarType(varT)
'    Case 8209
'        WScript.Echo "**8209**"
'        strReturn = "**8209** " & CStr(varT)
    Case vbEmpty
        strReturn = "**Empty**"
    Case vbNull
        strReturn = "**Null**"
    Case vbInteger, vbLong, vbSingle, vbDouble, vbCurrency
        strReturn = CStr(varT)
    Case vbDate
        strReturn = CStr(varT)
    Case vbString
        strReturn = CStr(varT)
    Case vbObject
        strReturn = "**Object**"
        strReturn = varT.Extension & Space(10-Len(Left(varT.Extension,9))) & varT.MimeType
    Case vbError
        strReturn = "Error: " & CStr(varT)
    Case vbBoolean
        strReturn = CStr(varT)
    Case vbVariant
        strReturn = DecodeVariant(varT)
    Case vbDataObject
        strReturn = "**DataObject**"
    Case vbByte		' 17
        strReturn = BYTEToHexString(varT)
        If varT > 31 AND varT < 127 Then
            strReturn = strReturn & "  " & Chr(varT) & " "
        Else
            strReturn = strReturn & "    "
        End If
    Case Else
        If VarType(varT) = 8204 Then       ' Array of Byte
            For Each varX in varT
                strReturn = strReturn & "  " & CStr(DecodeVariant(varX))
            Next
        ElseIf VarType(varT) = 8209 Then       ' Array of Byte
            Dim byteT, i
            For i = LBound(varT) To UBound(varT)
                'bByte(i) = CInt("&h" & Mid(strSID, (i * 2) + 1, 2))
                strReturn = strReturn & "-" & CStr(Hex(Asc(Mid(CStr(varT),i,1))))
                'WScript.Echo varT(i)
            Next
'            Set objArrayConvert = WScript.CreateObject("ADs.ArrayConvert")
'            varX = objArrayConvert.CvOctetStr2vHexStr(varT)
'            Set objArrayConvert = Nothing
'            strReturn = DecodeVariant(varX)
            'strReturn = varT(0)
            'strReturn = "**Ignored**"
        Else
            For Each varX in varT
                strReturn = strReturn & vbCrLf & "      " & CStr(DecodeVariant(varX))
            Next
        End If
    End Select

    DecodeVariant = strReturn

End Function

Function LookupChassisType(ChassisType)
    
    Dim strChassisType
    
    Select Case (ChassisType AND &h7F)
    Case &h01
        strChassisType = "Other"
    Case &h02
        strChassisType = "Unknown"
    Case &h03
        strChassisType = "Desktop"
    Case &h04
        strChassisType = "Low Profile Desktop"
    Case &h05
        strChassisType = "Pizza Box"
    Case &h06
        strChassisType = "Mini Tower"
    Case &h07
        strChassisType = "Tower"
    Case &h08
        strChassisType = "Portable"
    Case &h09
        strChassisType = "Laptop"
    Case &h0A
        strChassisType = "Notebook"
    Case &h0B
        strChassisType = "Hand Held"
    Case &h0C
        strChassisType = "Docking Station"
    Case &h0D
        strChassisType = "All in One"
    Case &h0E
        strChassisType = "Sub Notebook"
    Case &h0F
        strChassisType = "Space-saving"
    Case &h10
        strChassisType = "Lunch Box"
    Case &h11
        strChassisType = "Main Server Chassis"
    Case &h12
        strChassisType = "Expansion Chassis"
    Case &h13
        strChassisType = "SubChassis"
    Case &h14
        strChassisType = "Bus Expansion Chassis"
    Case &h15
        strChassisType = "Peripheral Chassis"
    Case &h16
        strChassisType = "RAID Chassis"
    Case &h17
        strChassisType = "Rack Mount Chassis"
    Case &h18
        strChassisType = "Sealed-case PC"
    Case &h19
        strChassisType = "Multi-system chassis."
    Case &h1A
        strChassisType = "Compact PCI"
    Case &h1B
        strChassisType = "Advanced TCA"
    Case &h1C
        strChassisType = "Blade"
    Case &h1D
        strChassisType = "Blade Enclosure"
    Case &h1E
        strChassisType = "Tablet"
    Case &h1F
        strChassisType = "Convertible"
    Case &h20
        strChassisType = "Detachable"
    Case &h21
        strChassisType = "IoT Gateway"
    Case &h22
        strChassisType = "Embedded PC"
    Case &h23
        strChassisType = "Mini PC"
    Case &h24
        strChassisType = "Stick PC"
    End Select
    
    If (ChassisType AND &h80) Then
        strChassisType = strChassisType & " with Chassis Lock"
    End If
    
    LookupChassisType = strChassisType
    
End Function

Function LookupMemoryFormFactor(MemoryFormFactor)
    
    Dim strMemoryFormFactor
    
    Select Case MemoryFormFactor
    Case &h01
        strMemoryFormFactor = "Other"
    Case &h02
        strMemoryFormFactor = "Unknown"
    Case &h03
        strMemoryFormFactor = "SIMM"
    Case &h04
        strMemoryFormFactor = "SIP"
    Case &h05
        strMemoryFormFactor = "Chip"
    Case &h06
        strMemoryFormFactor = "DIP"
    Case &h07
        strMemoryFormFactor = "ZIP"
    Case &h08
        strMemoryFormFactor = "Proprietary Card"
    Case &h09
        strMemoryFormFactor = "DIMM"
    Case &h0A
        strMemoryFormFactor = "TSOP"
    Case &h0B
        strMemoryFormFactor = "Row of chips"
    Case &h0C
        strMemoryFormFactor = "RIMM"
    Case &h0D
        strMemoryFormFactor = "SODIMM"
    Case &h0E
        strMemoryFormFactor = "SRIMM"
    Case &h0F
        strMemoryFormFactor = "FB-DIMM"
    End Select
    
    LookupMemoryFormFactor = strMemoryFormFactor
    
End Function

Function LookupMemoryType(MemoryType)
    
    Dim strMemoryType
    
    Select Case MemoryType
    Case &h01
        strMemoryType = "Other"
    Case &h02
        strMemoryType = "Unknown"
    Case &h03
        strMemoryType = "DRAM"
    Case &h04
        strMemoryType = "EDRAM"
    Case &h05
        strMemoryType = "VRAM"
    Case &h06
        strMemoryType = "SRAM"
    Case &h07
        strMemoryType = "RAM"
    Case &h08
        strMemoryType = "ROM"
    Case &h09
        strMemoryType = "FLASH"
    Case &h0A
        strMemoryType = "EEPROM"
    Case &h0B
        strMemoryType = "FEPROM"
    Case &h0C
        strMemoryType = "EPROM"
    Case &h0D
        strMemoryType = "CDRAM"
    Case &h0E
        strMemoryType = "3DRAM"
    Case &h0F
        strMemoryType = "SDRAM"
    Case &h10
        strMemoryType = "SGRAM"
    Case &h11
        strMemoryType = "RDRAM"
    Case &h12
        strMemoryType = "DDR"
    Case &h13
	    strMemoryType = "DDR2"
    Case &h14
        strMemoryType = "DDR2 FB-DIMM"
    Case &h15, &h16, &h17
        strMemoryType = "Reserved"
    Case &h18
        strMemoryType = "DDR3"
    Case &h19
        strMemoryType = "FBD2"
    Case &h1A
        strMemoryType = "DDR4"
    Case &h1B
        strMemoryType = "LPDDR"
    Case &h1C
        strMemoryType = "LPDDR2"
    Case &h1D
        strMemoryType = "LPDDR3"
    Case &h1E
        strMemoryType = "LPDDR4"
    End Select
    
    LookupMemoryType = strMemoryType
    
End Function

Function LookupProcessorFamily(ProcessorFamily)
    
    Dim strProcessorFamily
    
    Select Case ProcessorFamily
    Case &h01
        strProcessorFamily = "Other"
    Case &h02
        strProcessorFamily = "Unknown"
    Case &h03
        strProcessorFamily = "8086"
    Case &h04
        strProcessorFamily = "80286"
    Case &h05
        strProcessorFamily = "Intel386™ processor"
    Case &h06
        strProcessorFamily = "Intel486™ processor"
    Case &h07
        strProcessorFamily = "8087"
    Case &h08
        strProcessorFamily = "80287"
    Case &h09
        strProcessorFamily = "80387"
    Case &h0A
        strProcessorFamily = "80487"
    Case &h0B
        strProcessorFamily = "Intel® Pentium® processor"
    Case &h0C
        strProcessorFamily = "Pentium® Pro processor"
    Case &h0D
        strProcessorFamily = "Pentium® II processor"
    Case &h0E
        strProcessorFamily = "Pentium® processor with MMX™ technology"
    Case &h0F
        strProcessorFamily = "Intel® Celeron® processor"
    Case &h10
        strProcessorFamily = "Pentium® II Xeon™ processor"
    Case &h11
        strProcessorFamily = "Pentium® III processor"
    Case &h12
        strProcessorFamily = "M1 Family"
    Case &h13
        strProcessorFamily = "M2 Family"
    Case &h14
        strProcessorFamily = "Intel® Celeron® M processor"
    Case &h15
        strProcessorFamily = "Intel® Pentium® 4 HT processor"
    Case &h16
        strProcessorFamily = " 22-23 Available for assignment"
    Case &h18
        strProcessorFamily = "AMD Duron™ Processor Family [1]"
    Case &h19
        strProcessorFamily = "K5 Family [1]"
    Case &h1A
        strProcessorFamily = "K6 Family [1]"
    Case &h1B
        strProcessorFamily = "K6-2 [1]"
    Case &h1C
        strProcessorFamily = "K6-3 [1]"
    Case &h1D
        strProcessorFamily = "AMD Athlon™ Processor Family [1]"
    Case &h1E
        strProcessorFamily = "AMD29000 Family"
    Case &h1F
        strProcessorFamily = "K6-2+"
    Case &h20
        strProcessorFamily = "Power PC Family"
    Case &h21
        strProcessorFamily = "Power PC 601"
    Case &h22
        strProcessorFamily = "Power PC 603"
    Case &h23
        strProcessorFamily = "Power PC 603+"
    Case &h24
        strProcessorFamily = "Power PC 604"
    Case &h25
        strProcessorFamily = "Power PC 620"
    Case &h26
        strProcessorFamily = "Power PC x704"
    Case &h27
        strProcessorFamily = "Power PC 750"
    Case &h28
        strProcessorFamily = "Intel® Core™ Duo processor"
    Case &h29
        strProcessorFamily = "Intel® Core™ Duo mobile processor"
    Case &h2A
        strProcessorFamily = "Intel® Core™ Solo mobile processor"
    Case &h2B
        strProcessorFamily = "Intel® Atom™ processor"
    Case &h2C
        strProcessorFamily = "Intel® Core™ M processor"
    Case &h2D
        strProcessorFamily = "Intel(R) Core(TM) m3 processor"
    Case &h2E
        strProcessorFamily = "Intel(R) Core(TM) m5 processor"
    Case &h2F
        strProcessorFamily = "Intel(R) Core(TM) m7 processor"
    Case &h30
        strProcessorFamily = "Alpha Family [2]"
    Case &h31
        strProcessorFamily = "Alpha 21064"
    Case &h32
        strProcessorFamily = "Alpha 21066"
    Case &h33
        strProcessorFamily = "Alpha 21164"
    Case &h34
        strProcessorFamily = "Alpha 21164PC"
    Case &h35
        strProcessorFamily = "Alpha 21164a"
    Case &h36
        strProcessorFamily = "Alpha 21264"
    Case &h37
        strProcessorFamily = "Alpha 21364"
    Case &h38
        strProcessorFamily = "AMD Turion™ II Ultra Dual-Core Mobile M Processor Family"
    Case &h39
        strProcessorFamily = "AMD Turion™ II Dual-Core Mobile M Processor Family"
    Case &h3A
        strProcessorFamily = "AMD Athlon™ II Dual-Core M Processor Family"
    Case &h3B
        strProcessorFamily = "AMD Opteron™ 6100 Series Processor"
    Case &h3C
        strProcessorFamily = "AMD Opteron™ 4100 Series Processor"
    Case &h3D
        strProcessorFamily = "AMD Opteron™ 6200 Series Processor"
    Case &h3E
        strProcessorFamily = "AMD Opteron™ 4200 Series Processor"
    Case &h3F
        strProcessorFamily = "AMD FX™ Series Processor"
    Case &h40
        strProcessorFamily = "MIPS Family"
    Case &h41
        strProcessorFamily = "MIPS R4000"
    Case &h42
        strProcessorFamily = "MIPS R4200"
    Case &h43
        strProcessorFamily = "MIPS R4400"
    Case &h44
        strProcessorFamily = "MIPS R4600"
    Case &h45
        strProcessorFamily = "MIPS R10000"
    Case &h46
        strProcessorFamily = "AMD C-Series Processor"
    Case &h47
        strProcessorFamily = "AMD E-Series Processor"
    Case &h48
        strProcessorFamily = "AMD A-Series Processor"
    Case &h49
        strProcessorFamily = "AMD G-Series Processor"
    Case &h4A
        strProcessorFamily = "AMD Z-Series Processor"
    Case &h4B
        strProcessorFamily = "AMD R-Series Processor"
    Case &h4C
        strProcessorFamily = "AMD Opteron™ 4300 Series Processor"
    Case &h4D
        strProcessorFamily = "AMD Opteron™ 6300 Series Processor"
    Case &h4E
        strProcessorFamily = "AMD Opteron™ 3300 Series Processor"
    Case &h4F
        strProcessorFamily = "AMD FirePro™ Series Processor"
    Case &h50
        strProcessorFamily = "SPARC Family"
    Case &h51
        strProcessorFamily = "SuperSPARC"
    Case &h52
        strProcessorFamily = "microSPARC II"
    Case &h53
        strProcessorFamily = "microSPARC IIep"
    Case &h54
        strProcessorFamily = "UltraSPARC"
    Case &h55
        strProcessorFamily = "UltraSPARC II"
    Case &h56
        strProcessorFamily = "UltraSPARC Iii"
    Case &h57
        strProcessorFamily = "UltraSPARC III"
    Case &h58
        strProcessorFamily = "UltraSPARC IIIi"
    Case &h60
        strProcessorFamily = "68040 Family"
    Case &h61
        strProcessorFamily = "68xxx"
    Case &h62
        strProcessorFamily = "68000"
    Case &h63
        strProcessorFamily = "68010"
    Case &h64
        strProcessorFamily = "68020"
    Case &h65
        strProcessorFamily = "68030"
    Case &h66
        strProcessorFamily = "AMD Athlon(TM) X4 Quad-Core Processor Family"
    Case &h67
        strProcessorFamily = "AMD Opteron(TM) X1000 Series Processor"
    Case &h68
        strProcessorFamily = "AMD Opteron(TM) X2000 Series APU"
    Case &h69
        strProcessorFamily = "AMD Opteron(TM) A-Series Processor"
    Case &h6A
        strProcessorFamily = "AMD Opteron(TM) X3000 Series APU"
    Case &h6B
        strProcessorFamily = "AMD Zen Processor Family"
    Case &h70
        strProcessorFamily = "Hobbit Family"
    Case &h78
        strProcessorFamily = "Crusoe™ TM5000 Family"
    Case &h79
        strProcessorFamily = "Crusoe™ TM3000 Family"
    Case &h7A
        strProcessorFamily = "Efficeon™ TM8000 Family"
    Case &h80
        strProcessorFamily = "Weitek"
    Case &h81
        strProcessorFamily = "Available for assignment"
    Case &h82
        strProcessorFamily = "Itanium™ processor"
    Case &h83
        strProcessorFamily = "AMD Athlon™ 64 Processor Family"
    Case &h84
        strProcessorFamily = "AMD Opteron™ Processor Family"
    Case &h85
        strProcessorFamily = "AMD Sempron™ Processor Family"
    Case &h86
        strProcessorFamily = "AMD Turion™ 64 Mobile Technology"
    Case &h87
        strProcessorFamily = "Dual-Core AMD Opteron™ Processor Family"
    Case &h88
        strProcessorFamily = "AMD Athlon™ 64 X2 Dual-Core Processor Family"
    Case &h89
        strProcessorFamily = "AMD Turion™ 64 X2 Mobile Technology"
    Case &h8A
        strProcessorFamily = "Quad-Core AMD Opteron™ Processor Family"
    Case &h8B
        strProcessorFamily = "Third-Generation AMD Opteron™ Processor Family"
    Case &h8C
        strProcessorFamily = "AMD Phenom™ FX Quad-Core Processor Family"
    Case &h8D
        strProcessorFamily = "AMD Phenom™ X4 Quad-Core Processor Family"
    Case &h8E
        strProcessorFamily = "AMD Phenom™ X2 Dual-Core Processor Family"
    Case &h8F
        strProcessorFamily = "AMD Athlon™ X2 Dual-Core Processor Family"
    Case &h90
        strProcessorFamily = "PA-RISC Family"
    Case &h91
        strProcessorFamily = "PA-RISC 8500"
    Case &h92
        strProcessorFamily = "PA-RISC 8000"
    Case &h93
        strProcessorFamily = "PA-RISC 7300LC"
    Case &h94
        strProcessorFamily = "PA-RISC 7200"
    Case &h95
        strProcessorFamily = "PA-RISC 7100LC"
    Case &h96
        strProcessorFamily = "PA-RISC 7100"
    Case &hA0
        strProcessorFamily = "V30 Family"
    Case &hA1
        strProcessorFamily = "Quad-Core Intel® Xeon® processor 3200 Series"
    Case &hA2
        strProcessorFamily = "Dual-Core Intel® Xeon® processor 3000 Series"
    Case &hA3
        strProcessorFamily = "Quad-Core Intel® Xeon® processor 5300 Series"
    Case &hA4
        strProcessorFamily = "Dual-Core Intel® Xeon® processor 5100 Series"
    Case &hA5
        strProcessorFamily = "Dual-Core Intel® Xeon® processor 5000 Series"
    Case &hA6
        strProcessorFamily = "Dual-Core Intel® Xeon® processor LV"
    Case &hA7
        strProcessorFamily = "Dual-Core Intel® Xeon® processor ULV"
    Case &hA8
        strProcessorFamily = "Dual-Core Intel® Xeon® processor 7100 Series"
    Case &hA9
        strProcessorFamily = "Quad-Core Intel® Xeon® processor 5400 Series"
    Case &hAA
        strProcessorFamily = "Quad-Core Intel® Xeon® processor"
    Case &hAB
        strProcessorFamily = "Dual-Core Intel® Xeon® processor 5200 Series"
    Case &hAC
        strProcessorFamily = "Dual-Core Intel® Xeon® processor 7200 Series"
    Case &hAD
        strProcessorFamily = "Quad-Core Intel® Xeon® processor 7300 Series"
    Case &hAE
        strProcessorFamily = "Quad-Core Intel® Xeon® processor 7400 Series"
    Case &hAF
        strProcessorFamily = "Multi-Core Intel® Xeon® processor 7400 Series"
    Case &hB0
        strProcessorFamily = "Pentium® III Xeon™ processor"
    Case &hB1
        strProcessorFamily = "Pentium® III Processor with Intel® SpeedStep™ Technology"
    Case &hB2
        strProcessorFamily = "Pentium® 4 Processor"
    Case &hB3
        strProcessorFamily = "Intel® Xeon® processor"
    Case &hB4
        strProcessorFamily = "AS400 Family"
    Case &hB5
        strProcessorFamily = "Intel® Xeon™ processor MP"
    Case &hB6
        strProcessorFamily = "AMD Athlon™ XP Processor Family"
    Case &hB7
        strProcessorFamily = "AMD Athlon™ MP Processor Family"
    Case &hB8
        strProcessorFamily = "Intel® Itanium® 2 processor"
    Case &hB9
        strProcessorFamily = "Intel® Pentium® M processor"
    Case &hBA
        strProcessorFamily = "Intel® Celeron® D processor"
    Case &hBB
        strProcessorFamily = "Intel® Pentium® D processor"
    Case &hBC
        strProcessorFamily = "Intel® Pentium® Processor Extreme Edition"
    Case &hBD
        strProcessorFamily = "Intel® Core™ Solo Processor"
    Case &hBE
        strProcessorFamily = "Reserved [3]"
    Case &hBF
        strProcessorFamily = "Intel® Core™ 2 Duo Processor"
    Case &hC0
        strProcessorFamily = "Intel® Core™ 2 Solo processor"
    Case &hC1
        strProcessorFamily = "Intel® Core™ 2 Extreme processor"
    Case &hC2
        strProcessorFamily = "Intel® Core™ 2 Quad processor"
    Case &hC3
        strProcessorFamily = "Intel® Core™ 2 Extreme mobile processor"
    Case &hC4
        strProcessorFamily = "Intel® Core™ 2 Duo mobile processor"
    Case &hC5
        strProcessorFamily = "Intel® Core™ 2 Solo mobile processor"
    Case &hC6
        strProcessorFamily = "Intel® Core™ i7 processor"
    Case &hC7
        strProcessorFamily = "Dual-Core Intel® Celeron® processor"
    Case &hC8
        strProcessorFamily = "IBM390 Family"
    Case &hC9
        strProcessorFamily = "G4"
    Case &hCA
        strProcessorFamily = "G5"
    Case &hCB
        strProcessorFamily = "ESA/390 G6"
    Case &hCC
        strProcessorFamily = "z/Architecture base"
    Case &hCD
        strProcessorFamily = "Intel® Core™ i5 processor"
    Case &hCE
        strProcessorFamily = "Intel® Core™ i3 processor"
    Case &hD2
        strProcessorFamily = "VIA C7™-M Processor Family"
    Case &hD3
        strProcessorFamily = "VIA C7™-D Processor Family"
    Case &hD4
        strProcessorFamily = "VIA C7™ Processor Family"
    Case &hD5
        strProcessorFamily = "VIA Eden™ Processor Family"
    Case &hD6
        strProcessorFamily = "Multi-Core Intel® Xeon® processor"
    Case &hD7
        strProcessorFamily = "Dual-Core Intel® Xeon® processor 3xxx Series"
    Case &hD8
        strProcessorFamily = "Quad-Core Intel® Xeon® processor 3xxx Series"
    Case &hD9
        strProcessorFamily = "VIA Nano™ Processor Family"
    Case &hDA
        strProcessorFamily = "Dual-Core Intel® Xeon® processor 5xxx Series"
    Case &hDB
        strProcessorFamily = "Quad-Core Intel® Xeon® processor 5xxx Series"
    Case &hDC
        strProcessorFamily = "Available for assignment"
    Case &hDD
        strProcessorFamily = "Dual-Core Intel® Xeon® processor 7xxx Series"
    Case &hDE
        strProcessorFamily = "Quad-Core Intel® Xeon® processor 7xxx Series"
    Case &hDF
        strProcessorFamily = "Multi-Core Intel® Xeon® processor 7xxx Series"
    Case &hE0
        strProcessorFamily = "Multi-Core Intel® Xeon® processor 3400 Series"
    Case &hE1
        strProcessorFamily = "225-227 Available for assignment"
    Case &hE4
        strProcessorFamily = "AMD Opteron™ 3000 Series Processor"
    Case &hE5
        strProcessorFamily = "AMD Sempron™ II Processor"
    Case &hE6
        strProcessorFamily = "Embedded AMD Opteron™ Quad-Core Processor Family"
    Case &hE7
        strProcessorFamily = "AMD Phenom™ Triple-Core Processor Family"
    Case &hE8
        strProcessorFamily = "AMD Turion™ Ultra Dual-Core Mobile Processor Family"
    Case &hE9
        strProcessorFamily = "AMD Turion™ Dual-Core Mobile Processor Family"
    Case &hEA
        strProcessorFamily = "AMD Athlon™ Dual-Core Processor Family"
    Case &hEB
        strProcessorFamily = "AMD Sempron™ SI Processor Family"
    Case &hEC
        strProcessorFamily = "AMD Phenom™ II Processor Family"
    Case &hED
        strProcessorFamily = "AMD Athlon™ II Processor Family"
    Case &hEE
        strProcessorFamily = "Six-Core AMD Opteron™ Processor Family"
    Case &hEF
        strProcessorFamily = "AMD Sempron™ M Processor Family"
    Case &hF0
        strProcessorFamily = "240-249 Available for assignment"
    Case &hFA
        strProcessorFamily = "i860"
    Case &hFB
        strProcessorFamily = "i960"
    Case &hFE
        strProcessorFamily = "Indicator to obtain the processor family from the Processor Family 2 field"
    Case &hFF
        strProcessorFamily = "Reserved"
    Case &h100
        strProcessorFamily = "ARMv7"
    Case &h101
        strProcessorFamily = "ARMv8"
    Case &h104
        strProcessorFamily = "SH-3"
    Case &h105
        strProcessorFamily = "SH-4"
    Case &h118
        strProcessorFamily = "ARM"
    Case &h119
        strProcessorFamily = "StrongARM"
    Case &h12C
        strProcessorFamily = "6x86"
    Case &h12D
        strProcessorFamily = "MediaGX"
    Case &h12E
        strProcessorFamily = "MII"
    Case &h140
        strProcessorFamily = "WinChip"
    Case &h15E
        strProcessorFamily = "DSP"
    Case &h1F4
        strProcessorFamily = "500 Video Processor"
    End Select
    
    LookupProcessorFamily = strProcessorFamily
    
End Function

Function LookupProcessorType(ProcessorType)
    
    Dim strProcessorType
    
    Select Case ProcessorType
    Case &h01
        strProcessorType = "Other"
    Case &h02
        strProcessorType = "Unknown"
    Case &h03
        strProcessorType = "Central Processor"
    Case &h04
        strProcessorType = "Math Processor"
    Case &h05
        strProcessorType = "DSP Processor"
    Case &h06
        strProcessorType = "Video Processor"
    End Select
    
    LookupProcessorType = strProcessorType
    
End Function

Function LookupProcessorUpgrade(ProcessorUpgrade)
    
    Dim strProcessorUpgrade
    
    Select Case ProcessorUpgrade
    Case &h01
        strProcessorUpgrade = "Other"
    Case &h02
        strProcessorUpgrade = "Unknown"
    Case &h03
        strProcessorUpgrade = "Daughter Board"
    Case &h04
        strProcessorUpgrade = "ZIF Socket"
    Case &h05
        strProcessorUpgrade = "Replaceable Piggy Back"
    Case &h06
        strProcessorUpgrade = "None"
    Case &h07
        strProcessorUpgrade = "LIF Socket"
    Case &h08
        strProcessorUpgrade = "Slot 1"
    Case &h09
        strProcessorUpgrade = "Slot 2"
    Case &h0A
        strProcessorUpgrade = "370-pin socket"
    Case &h0B
        strProcessorUpgrade = "Slot A"
    Case &h0C
        strProcessorUpgrade = "Slot M"
    Case &h0D
        strProcessorUpgrade = "Socket 423"
    Case &h0E
        strProcessorUpgrade = "Socket A (Socket 462)"
    Case &h0F
        strProcessorUpgrade = "Socket 478"
    Case &h10
        strProcessorUpgrade = "Socket 754"
    Case &h11
        strProcessorUpgrade = "Socket 940"
    Case &h12
        strProcessorUpgrade = "Socket 939"
    Case &h13
        strProcessorUpgrade = "Socket mPGA604"
    Case &h14
        strProcessorUpgrade = "Socket LGA771"
    Case &h15
        strProcessorUpgrade = "Socket LGA775"
    Case &h16
        strProcessorUpgrade = "Socket S1"
    Case &h17
        strProcessorUpgrade = "Socket AM2"
    Case &h18
        strProcessorUpgrade = "Socket F (1207)"
    Case &h19
        strProcessorUpgrade = "Socket LGA1366"
    Case &h1A
        strProcessorUpgrade = "Socket G34"
    Case &h1B
        strProcessorUpgrade = "Socket AM3"
    Case &h1C
        strProcessorUpgrade = "Socket C32"
    Case &h1D
        strProcessorUpgrade = "Socket LGA1156"
    Case &h1E
        strProcessorUpgrade = "Socket LGA1567"
    Case &h1F
        strProcessorUpgrade = "Socket PGA988A"
    Case &h20
        strProcessorUpgrade = "Socket BGA1288"
    Case &h21
        strProcessorUpgrade = "Socket rPGA988B"
    Case &h22
        strProcessorUpgrade = "Socket BGA1023"
    Case &h23
        strProcessorUpgrade = "Socket BGA1224"
    Case &h24
        strProcessorUpgrade = "Socket LGA1155"
    Case &h25
        strProcessorUpgrade = "Socket LGA1356"
    Case &h26
        strProcessorUpgrade = "Socket LGA2011"
    Case &h27
        strProcessorUpgrade = "Socket FS1"
    Case &h28
        strProcessorUpgrade = "Socket FS2"
    Case &h29
        strProcessorUpgrade = "Socket FM1"
    Case &h2A
        strProcessorUpgrade = "Socket FM2"
    Case &h2B
        strProcessorUpgrade = "Socket LGA2011-3"
    Case &h2C
        strProcessorUpgrade = "Socket LGA1356-3"
    Case &h2D
        strProcessorUpgrade = "Socket LGA1150"
    Case &h2E
        strProcessorUpgrade = "Socket BGA1168"
    Case &h2F
        strProcessorUpgrade = "Socket BGA1234"
    Case &h30
        strProcessorUpgrade = "Socket BGA1364"
    Case &h31
        strProcessorUpgrade = "Socket AM4"
    Case &h32
        strProcessorUpgrade = "Socket LGA1151"
    Case &h33
        strProcessorUpgrade = "Socket BGA1356"
    Case &h34
        strProcessorUpgrade = "Socket BGA1440"
    Case &h35
        strProcessorUpgrade = "Socket BGA1515"
    Case &h36
        strProcessorUpgrade = "Socket LGA3647-1"
    Case &h37
        strProcessorUpgrade = "Socket SP3"
    Case &h38
        strProcessorUpgrade = "Socket SP3r2"
    End Select
   
    LookupProcessorUpgrade = strProcessorUpgrade
    
End Function

Function LookupSmBiosTableName(TableType)
    Dim strTableName
    
    Select Case TableType
    Case 0
        strTableName = "BIOS Information"
    Case 1
        strTableName = "System Information"
    Case 2
        strTableName = "Base Board Information"
    Case 3
        strTableName = "System Enclosure or Chassis"
    Case 4
        strTableName = "Processor Information"
    Case 5
        strTableName = "Memory Controller Information (obsolete)"
    Case 6
        strTableName = "Memory Module Information (obsolete)"
    Case 7
        strTableName = "Cache Information"
    Case 8
        strTableName = "Port Connector Information"
    Case 9
        strTableName = "System Slots"
    Case 10
        strTableName = "On Board Devices"
    Case 11
        strTableName = "OEM Strings"
    Case 12
        strTableName = "System Configuration Options"
    Case 13
        strTableName = "BIOS Language Information"
    Case 14
        strTableName = "Group Associations"
    Case 15
        strTableName = "System Event Log"
    Case 16
        strTableName = "Physical Memory Array"
    Case 17
        strTableName = "Memory Device"
    Case 18
        strTableName = "Memory Error Information"
    Case 19
        strTableName = "Memory Array Mapped Address"
    Case 20
        strTableName = "Memory Device Mapped Address"
    Case 21
        strTableName = "Built-in Pointing Device"
    Case 22
        strTableName = "Portable Battery"
    Case 23
        strTableName = "System Reset"
    Case 24
        strTableName = "Hardware Security"
    Case 25
        strTableName = "System Power Controls"
    Case 26
        strTableName = "Voltage Probe"
    Case 27
        strTableName = "Cooling Device"
    Case 28
        strTableName = "Temperature Probe"
    Case 29
        strTableName = "Electrical Current Probe"
    Case 30
        strTableName = "Out-of-Band Remote Access"
    Case 31
        strTableName = "Boot Integrity Services (BIS) Entry Point"
    Case 32
        strTableName = "System Boot Information"
    Case 33
        strTableName = "64-bit Memory Error Information"
    Case 34
        strTableName = "Management Device"
    Case 35
        strTableName = "Management Device Component"
    Case 36
        strTableName = "Management Device Threshold Data"
    Case 37
        strTableName = "Memory Channel"
    Case 38
        strTableName = "IPMI Device Information"
    Case 39
        strTableName = "System Power Supply"
	Case 40
        strTableName = "Additional Information"
	Case 41
		strTableName = "Onboard Devices Extended Information"
	Case 42
		strTableName = "Management Controller Host Interface"
    Case 43
        strTableName = "TPM Device"
    Case 126
        strTableName = "Inactive"
    Case 127
        strTableName = "End-of-Table"
    Case 128
        strTableName = "HP Platform Information"
    Case 129
        strTableName = "Mechanical Information"
    Case 130
        strTableName = "Motherboard Switches Information"
    Case 131
        strTableName = "Mass Storage Device"
    Case 132
        strTableName = "Front Panel Information"
    Case 133
        strTableName = "LAN/SCSI Information"
    Case 134
        strTableName = "Monitored Parameter"
    Case 135
        strTableName = "Hardware Monitoring Flags Information"
    Case 136
        strTableName = "Post Errors"
    Case 137
        strTableName = "Video Information"
    Case 138
        strTableName = "Boot Information"
    Case 139
        strTableName = "Mailbox Information"
    Case 140
        strTableName = "MCD Post Information"
    Case Else	
        strTableName = "<Unknown>"
    End Select

    LookupSmBiosTableName = strTableName

End Function


Function LookupWakeUpType(WakeUpType)
    
    Dim strWakeUpType
    
    Select Case WakeUpType
    Case &h00
        strWakeUpType = "Reserved"
    Case &h01
        strWakeUpType = "Other"
    Case &h02
        strWakeUpType = "Unknown"
    Case &h03
        strWakeUpType = "APM Timer"
    Case &h04
        strWakeUpType = "Modem Ring"
    Case &h05
        strWakeUpType = "LAN Remote"
    Case &h06
        strWakeUpType = "Power Switch"
    Case &h07
        strWakeUpType = "PCI PME#"
    Case &h08
        strWakeUpType = "AC Power Restored"
    End Select
    
    LookupWakeUpType = strWakeUpType
    
End Function


Function LookupNetworkConnectionStatus(NetworkConnectionStatus)
    
    Dim strNetworkConnectionStatus
    
    Select Case NetworkConnectionStatus
    Case 0
        strNetworkConnectionStatus = "Disconnected"
    Case 1
        strNetworkConnectionStatus = "Connecting"
    Case 2
        strNetworkConnectionStatus = "Connected"
    Case 3
        strNetworkConnectionStatus = "Disconnecting"
    Case 4
        strNetworkConnectionStatus = "Hardware not present"
    Case 5
        strNetworkConnectionStatus = "Hardware disabled"
    Case 6
        strNetworkConnectionStatus = "Hardware malfunction"
    Case 7
        strNetworkConnectionStatus = "Media disconnected"
    Case 8
        strNetworkConnectionStatus = "Authenticating"
    Case 9
        strNetworkConnectionStatus = "Authentication succeeded"
    Case 10
        strNetworkConnectionStatus = "Authentication failed"
    Case Else
        strNetworkConnectionStatus = "Unknown"
    End Select

    LookupNetworkConnectionStatus = strNetworkConnectionStatus
    
End Function
