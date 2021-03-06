/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20160108-64
 * Copyright (c) 2000 - 2016 Intel Corporation
 * 
 * Disassembly of WAET.aml, Sat Apr 29 16:39:43 2017
 *
 * ACPI Data Table [WAET]
 *
 * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
 */

[000h 0000   4]                    Signature : "WAET"    [Windows ACPI Emulated Devices Table]
[004h 0004   4]                 Table Length : 00000028
[008h 0008   1]                     Revision : 01
[009h 0009   1]                     Checksum : 62
[00Ah 0010   6]                       Oem ID : "VMWARE"
[010h 0016   8]                 Oem Table ID : "VMW WAET"
[018h 0024   4]                 Oem Revision : 06040000
[01Ch 0028   4]              Asl Compiler ID : "VMW "
[020h 0032   4]        Asl Compiler Revision : 00000001

[024h 0036   4]        Flags (decoded below) : 00000002
                        RTC needs no INT ack : 0
                     PM timer, one read only : 1

Raw Table Data: Length 40 (0x28)

  0000: 57 41 45 54 28 00 00 00 01 62 56 4D 57 41 52 45  // WAET(....bVMWARE
  0010: 56 4D 57 20 57 41 45 54 00 00 04 06 56 4D 57 20  // VMW WAET....VMW 
  0020: 01 00 00 00 02 00 00 00                          // ........
