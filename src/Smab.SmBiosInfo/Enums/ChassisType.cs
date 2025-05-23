﻿namespace Smab.SmBiosInfo.Enums;

/// <summary>
/// Represents the type of chassis or enclosure for a computer system.
/// </summary>
/// <remarks>This enumeration provides a standardized set of chassis types, as defined by the SMBIOS (System
/// Management BIOS) specification. It can be used to identify the physical form factor or enclosure type of a system,
/// such as a desktop, laptop, server, or embedded device.</remarks>
public enum ChassisType
{
    Other               = 0x01,
    Unknown             = 0x02,
    Desktop             = 0x03,
    LowProfileDesktop   = 0x04,
    PizzaBox            = 0x05,
    MiniTower           = 0x06,
    Tower               = 0x07,
    Portable            = 0x08,
    Laptop              = 0x09,
    Notebook            = 0x0A,
    HandHeld            = 0x0B,
    DockingStation      = 0x0C,
    AllInOne            = 0x0D,
    SubNotebook         = 0x0E,
    SpaceSaving         = 0x0F,
    LunchBox            = 0x10,
    MainServerChassis   = 0x11,
    ExpansionChassis    = 0x12,
    SubChassis          = 0x13,
    BusExpansionChassis = 0x14,
    PeripheralChassis   = 0x15,
    RAIDChassis         = 0x16,
    RackMountChassis    = 0x17,
    SealedCasePC        = 0x18,
    MultiSystemChassis  = 0x19,
    CompactPCI          = 0x1A,
    AdvancedTCA         = 0x1B,
    Blade               = 0x1C,
    BladeEnclosure      = 0x1D,
    Tablet              = 0x1E,
    Convertible         = 0x1F,
    Detachable          = 0x20,
    IoTGateway          = 0x21,
    EmbeddedPC          = 0x22,
    MiniPC              = 0x23,
    StickPC             = 0x24,
}
