namespace Smab.SmBiosInfo.Enums;

/// <summary>
/// Represents the length or form factor of a slot, such as its physical size or type.
/// </summary>
/// <remarks>This enumeration provides predefined values for identifying the length or form factor of a slot.  It
/// includes options for common sizes, such as 2.5-inch and 3.5-inch form factors, as well as  generic categories like
/// <see cref="None"/>, <see cref="Other"/>, and <see cref="Unknown"/>.</remarks>
public enum SlotLength
{
	None             = 0,
	Other            = 0x01,
	Unknown          = 0x02,
	Short            = 0x03,
	Long             = 0x04,
	FormFactor25Inch = 0x05,
	FormFactor35Inch = 0x06,
}
