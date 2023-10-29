// infix operator <-: DefaultPrecedence

public class MOS6502Kit {
    /// Dictionary based set of registers.
    public var registers: [Registers: UInt8] = [
        .A: 0,
        .X: 0,
        .Y: 0,
        .S: 0
        // P register is status flag
        // PC has separated register
    ]

    /**
     Represents the status (or register P) value.

     Do not use this variable directly unless you know what you're doing.
     I strongly recommend you to use ``getFlag(_:)-nzwp`` instead.
     */
    public var status: UInt8 = 0

    /// Represents program counter (or register PC).
    public var PC: UInt16 = 0

    /**
     - Parameters:
        - flag: Flag position you want to get.
     - Returns: The result of flag in boolean.
     */
    public func getFlag(_ flag: Flags) -> Bool {
        return status & 1 << flag.rawValue != 0
    }

    public func getFlag(_ flag: FullNameFlags) -> Bool {
        return status & 1 << flag.rawValue != 0
    }

//    public static func <- (lhs: MOS6502Kit, rhs: Registers) -> UInt8 {
//        return lhs.registers[rhs]!
//    }
}
