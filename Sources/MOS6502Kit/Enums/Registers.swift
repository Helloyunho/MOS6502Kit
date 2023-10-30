public enum Registers {
    // P register is status flag
    // PC is 16 bit and everything else is 8 bit
    case A, X, Y, PC, S, P // swiftlint:disable:this identifier_name
}

public enum AccessableRegisters {
    // PC alone has dedicated variable for it
    case A, X, Y, S, P // swiftlint:disable:this identifier_name
}
