// infix operator <-: DefaultPrecedence

public class MOS6502 {
    // MARK: Variables

    /// Dictionary based set of registers.
    public var registers: [AccessableRegisters: UInt8] = [
        .A: 0,
        .X: 0,
        .Y: 0,
        .S: 0,
        .P: 0b0010_0000
        // PC has separated variable
    ]

    /**
     Represents the status (or register P) value.

     Do not use this variable directly unless you know what you're doing.
     I strongly recommend you to use ``getFlag(_:)-nzwp`` instead.
     */
    public var status: UInt8 {
        get {
            self.registers[.P]!
        }
        set {
            self.registers[.P] = newValue
        }
    }

    /// Represents program counter (or register PC).
    public var PC: UInt16 = 0

    public var memory: MemoryLayout

    // MARK: Initializer

    public init(memory: MemoryLayout) {
        self.memory = memory
    }

    // MARK: Functions

    /**
     Gets whether the specific flag is enabled or not.

     - Parameters:
        - flag: Flag position you want to get.
     - Returns: The result of flag in boolean.
     */
    public func getFlag(_ flag: Flags) -> Bool {
        return self.status & 1 << flag.rawValue != 0
    }

    /**
     Sets(or toggles) specific flag.
     - Parameters:
        - flag: Flag position you want to set.
        - to: The value in boolean. Leave it blank(or set it to `nil`) to toggle the value.
     - Returns: The changed status.
     */
    @discardableResult
    public func setFlag(_ flag: Flags, to: Bool? = nil) -> UInt8 {
        self.status = (
            self.status & ~(
                1 << flag.rawValue
            )
        ) | (
            (
                (to ?? !self.getFlag(flag)) ? 1 : 0
            ) << flag.rawValue
        )

        return self.status
    }

    public subscript(register: AccessableRegisters) -> UInt8 {
        get {
            self.registers[register]!
        }
        set {
            self.registers[register] = newValue
        }
    }

    public subscript(addr: UInt16) -> UInt8 {
        get {
            self.memory[addr]
        }
        set {
            self.memory[addr] = newValue
        }
    }

    public subscript(flag: Flags) -> Bool {
        get {
            self.getFlag(flag)
        } set {
            self.setFlag(flag, to: newValue)
        }
    }

//    public static func <- (lhs: MOS6502Kit, rhs: Registers) -> UInt8 {
//        return lhs.registers[rhs]!
//    }
}
