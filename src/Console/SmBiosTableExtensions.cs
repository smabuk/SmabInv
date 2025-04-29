using Smab.SmBiosInfo.Structures;

using Spectre.Console;

namespace SmabInv;
public static class SmBiosTableExtensions
{
	extension(SmBiosTable smBiosTable)
	{
		public void DumpAsTable()
		{

			Table table = new()
			{
				Title = new($"{smBiosTable.TableType,3}: {smBiosTable.Description}"),
				ShowHeaders = false,
			};

			_ = table.AddColumns(["Property", "Value          "]);

			switch (smBiosTable) {
				case Type000 type000:
					table.ShowHeaders = true;
					_ = table
						.AddRow("Vendor",                            $"{type000.Vendor}")
						.AddRow("BIOS Version",                      $"{type000.BiosVersion}")
						.AddRow("BIOS Release Date",                 $"{type000.BiosReleaseDate}")
						.AddRow("StartAddress",                      $"{type000.BiosStartAddress}")
						.AddRow("Rom Size",                          $"{type000.RomSize}")
						.AddRow("Platform Version Major",            $"{type000.PlatformFirmwareMajorRelease}")
						.AddRow("Platform Version Minor",            $"{type000.PlatformFirmwareMinorRelease}")
						.AddRow("Embedded Controller Version Major", $"{type000.EmbeddedControllerFirmwareMajorRelease}")
						.AddRow("Embedded Controller Version Minor", $"{type000.EmbeddedControllerFirmwareMinorRelease}")
						;
					break;
				case Type001 type001:
					_ = table
						.AddRow("Manufacturer",  $"{type001.Manufacturer}")
						.AddRow("Product Name",  $"{type001.ProductName}")
						.AddRow("Version",       $"{type001.Version}")
						.AddRow("Serial Number", $"{type001.SerialNumber}")
						.AddRow("UUID",          $"{type001.UUID}")
						.AddRow("Wakeup Type",   $"{type001.WakeupType}")
						.AddRow("SKU Number",    $"{type001.SKUNumber}")
						.AddRow("Family",        $"{type001.Family}")
						;
					break;
				case Type002 type002:
					_ = table
						.AddRow("Manufacturer",        $"{type002.Manufacturer}")
						.AddRow("Product Name",        $"{type002.ProductName}")
						.AddRow("Version",             $"{type002.Version}")
						.AddRow("Serial Number",       $"{type002.SerialNumber}")
						.AddRow("AssetTag",            $"{type002.AssetTag}")
						.AddRow("Feature Flags",       $"{type002.FeatureFlags}")
						.AddRow("Location in Chassis", $"{type002.LocationInChassis}")
						.AddRow("Chassis Handle",      $"{type002.ChassisHandle}")
						.AddRow("Board Type",          $"{type002.BoardType}")
						;
					break;
				case Type003 type003:
					_ = table
						.AddRow("Manufacturer",          $"{type003.Manufacturer}")
						.AddRow("Chassis Type",          $"{type003.ChassisType}")
						.AddRow("Version",               $"{type003.Version}")
						.AddRow("Serial Number",         $"{type003.SerialNumber}")
						.AddRow("Asset Tag Number",      $"{type003.AssetTagNumber}")
						.AddRow("Boot-up State",         $"{type003.BootupState}")
						.AddRow("Power Supply State",    $"{type003.PowerSupplyState}")
						.AddRow("Thermal State",         $"{type003.ThermalState}")
						.AddRow("Security Status",       $"{type003.SecurityStatus}")
						.AddRow("Number of Power Cords", $"{type003.NoOfPowerCords}")
						;
					break;
				case Type004 type004:
					_ = table
						.AddRow("Socket Designation",       $"{type004.SocketDesignation}")
						.AddRow("Processor Type",           $"{type004.ProcessorType}")
						.AddRow("Processor Family",         $"{type004.ProcessorFamily}")
						.AddRow("Manufacturer",             $"{type004.Manufacturer}")
						.AddRow("Max Speed",                $"{type004.MaxSpeed}")
						.AddRow("Current Speed",            $"{type004.CurrentSpeed}")
						.AddRow("Processor Upgrade",        $"{type004.ProcessorUpgrade}")
						.AddRow("Serial Number",            $"{type004.SerialNumber}")
						.AddRow("Asset Tag",                $"{type004.AssetTag}")
						.AddRow("Part Number",              $"{type004.PartNumber}")
						.AddRow("No of Cores",              $"{type004.CoreCount}")
						.AddRow("No of Enabled Cores",      $"{type004.CoreEnabled}")
						.AddRow("Thread Count",             $"{type004.ThreadCount}")
						.AddRow("ProcessorCharacteristics", $"{type004.ProcessorCharacteristics}")
						;
					break;
				case Type007 type007:
					_ = table
						.AddRow("Socket Designation",    $"{type007.SocketDesignation}")
						.AddRow("Cache Configuration",   $"{type007.CacheConfiguration}")
						.AddRow("Maximum Cache Size",    $"{type007.MaximumCacheSize}")
						.AddRow("Installed Size",        $"{type007.InstalledSize}")
						.AddRow("Supported SRAM Type",   $"{type007.SupportedSRAMType}")
						.AddRow("Current SRAM Type",     $"{type007.CurrentSRAMType}")
						.AddRow("Cache Speed",           $"{type007.CacheSpeed}")
						.AddRow("Error Correction Type", $"{type007.ErrorCorrectionType}")
						.AddRow("System Cache Type",     $"{type007.SystemCacheType}")
						.AddRow("Associativity",         $"{type007.Associativity}")
						;
					break;
				case Type009 type009:
					_ = table
						.AddRow("Slot Designation",    $"{type009.SlotDesignation}")
						.AddRow("Slot Type",           $"{type009.SlotType}")
						.AddRow("Slot Data Bus Width", $"{type009.SlotDataBusWidth}")
						.AddRow("Current Usage"      , $"{type009.CurrentUsage}")
						.AddRow("Slot Length"      ,   $"{type009.SlotLength}")
						;
					break;
				case Type011 type011:
					_ = table.AddRow("Count",    $"{type011.Count}");

					foreach (string str in type011.Strings) {
						_ = table.AddRow("", $"{str.CleanMarkup()}");
					}

					break;
				case Type012 type012:
					table.Width = 40;
					_ = table.AddRow("Count",    $"{type012.Count}");

					foreach (string str in type012.Strings) {
						_ = table.AddRow("", $"{str.CleanMarkup()}");
					}

					break;
				case Type080 type080:
					_ = table
						.AddRow("PCID",         $"{type080.PCID}")
						.AddRow("Signature",    $"{type080.Signature}")
						.AddRow("BIOS Letters", $"{type080.BIOSLetters}")
						;
					break;
				default:
					table = new()
					{
						Title = new($"{smBiosTable.TableType,3}: {smBiosTable.Description}"),
						ShowHeaders = false,
					};

					_ = table.AddColumns(["String          "]);
					foreach (string str in smBiosTable.Strings) {
						_ = table.AddRow([str.CleanMarkup()]);
					}

					table.Width ??= table.Width is null or < 40 ? 40 : table.Width;
					break;
			}

			if (table.Rows.Count > 0) {
				AnsiConsole.WriteLine();
				AnsiConsole.Write(table);
			} else {
				AnsiConsole.WriteLine();
				AnsiConsole.WriteLine($"{smBiosTable.TableType,3}: {smBiosTable.Description}");
			}
		}
	}
}
