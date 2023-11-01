// swiftlint:disable identifier_name
public enum Registers {
    // P register is status flag
    // PC is 16 bit and everything else is 8 bit
    /**
     Accumulator register.
     
     Usually used to calculate with data.
     */
    case A
    /**
     X register.
     
     This can be used for indexing.
     */
    case X
    /**
     Y register.
     
     This can be used for indexing.
     */
    case Y
    /**
     Program Counter register.
     
     This represents the current execution address.
     
     > Note: This register uses 16 bit instead of 8 bit.
     */
    case PC
    /**
     Stack Pointer register.
     
     As the name suggests, this register is the index of current stack.
     
     > Note: The default, initialized value for this register is `0xFD`.
     */
    case S
    /**
     Status register.
     
     This is the register that contains all the CPU flags.
     */
    case P
}

public enum AccessableRegisters {
    // PC alone has dedicated variable for it
    /**
     Accumulator register.
     
     Usually used to calculate with data.
     */
    case A
    /**
     X register.
     
     This can be used for indexing.
     */
    case X
    /**
     Y register.
     
     This can be used for indexing.
     */
    case Y
    /**
     Stack Pointer register.
     
     As the name suggests, this register is the index of current stack.
     
     > Note: The default, initialized value for this register is `0xFD`.
     */
    case S
    /**
     Status register.
     
     This is the register that contains all the CPU flags.
     */
    case P
}
// swiftlint:enable identifier_name
