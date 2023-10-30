public enum Flags: UInt8 {
    // Flags Bit Order: NV_BDIZC
    // swiftlint:disable identifier_name
    /**
     Negative flag.
     
     Usually same as bit 7(Negative bit),
     but when compare, it indicates whether
     the input value is smaller than the register value.
     */
    case N = 7
    /**
     Overflow flag.
     
     When performing arithmetic operations,
     this will indicate whether the result has overflowed.
     
     > Note: Overflow here means signed overflow.
     > For unsigned overflow, use ``C`` flag instead.
     */
    case V = 6
    /**
     Unused flag.
     
     > Warning: Please do not use this as it's unused flag and needs to be always set to HIGH.
     */
    case `_` = 5
    /**
     Break flag.
     
     This flag is turned on when `BRK` instruction was called.
     */
    case B = 4
    /**
     Decimal flag.
     
     Enabling this makes the emulator to read values in decimal instead of hex.
     For example, `0x09 + 0x01` is `0x10`.
     */
    case D = 3
    /**
     Interrupt Disable flag.
     */
    case I = 2
    /**
     Zero flag.
     
     When compare, this flag indicates whether
     the value is equal.
     
     Otherwise it literally means whether
     the value is zero or not.
     */
    case Z = 1
    /**
     Carry flag.
     
     When performing arithmetic operations, this flag basically means
     an unsigned overflow.
     
     When compare, it indicates whether the register's value is greater than or equal to
     the input value.
     
     When shifting, the eliminated bit is set to this flag.
     */
    case C = 0
    // swiftlint:enable identifier_name
}
