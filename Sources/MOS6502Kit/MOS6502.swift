// infix operator <-: DefaultPrecedence

public struct MOS6502 {
    // MARK: Variables

    /// Dictionary based set of registers.
    public var registers: [AccessableRegisters: UInt8] = [
        .A: 0,
        .X: 0,
        .Y: 0,
        .S: 0xFD,
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
            registers[.P]!
        }
        set {
            registers[.P] = newValue
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
        return status & 1 << flag.rawValue != 0
    }

    /**
     Sets(or toggles) specific flag.
     - Parameters:
        - flag: Flag position you want to set.
        - to: The value in boolean. Leave it blank(or set it to `nil`) to toggle the value.
     - Returns: The changed status.
     */
    @discardableResult
    public mutating func setFlag(_ flag: Flags, to: Bool? = nil) -> UInt8 {
        status = (
            status & ~(
                1 << flag.rawValue
            )
        ) | (
            (
                (to ?? !getFlag(flag)) ? 1 : 0
            ) << flag.rawValue
        )

        return status
    }

    public func getAddress(_ mode: AddressingMode) -> UInt16 {
        switch mode {
        case .immediate:
            return PC
        case .absolute:
            return memory[twoBytes: PC]
        case .zeroPage:
            return UInt16(memory[PC])
        case .relative:
            let offset = memory[PC]
            // We first convert offset to a **signed** integer, 8-bit.
            // Then we convert it to 32-bit integer and add it to PC (casted as 32-bit integer).
            // This is to support negative offsets, otherwise signed integers
            // would not be needed.
            let signedOffset = Int8(bitPattern: offset)
            return UInt16(Int(PC) &+ Int(signedOffset))
        case .absoluteIndirect:
            return memory[twoBytes: PC]
        case .absoluteIndexedX:
            return memory[twoBytes: PC] &+ UInt16(registers[.X]!)
        case .absoluteIndexedY:
            return memory[twoBytes: PC] &+ UInt16(registers[.Y]!)
        case .zeroPageIndexedX:
            return UInt16(memory[PC] &+ registers[.X]!)
        case .zeroPageIndexedY:
            return UInt16(memory[PC] &+ registers[.Y]!)
        case .zeroPageIndexedIndirectX:
            let base = memory[PC]
            let pointer = base &+ registers[.X]!
            return memory[twoBytes: UInt16(pointer)]
        case .zeroPageIndexedIndirectY:
            let base = memory[PC]
            let pointer = memory[twoBytes: UInt16(base)]
            return pointer &+ UInt16(registers[.Y]!)
        default:
            // TODO: Make a proper error
            fatalError("Register addressing mode detected.")
        }
    }

    public subscript(register: AccessableRegisters) -> UInt8 {
        get {
            registers[register]!
        }
        set {
            registers[register] = newValue
        }
    }

    public subscript(addr: UInt16) -> UInt8 {
        get {
            memory[addr]
        }
        set {
            memory[addr] = newValue
        }
    }

    public subscript(twoBytes addr: UInt16) -> UInt16 {
        get {
            memory[twoBytes: addr]
        }
        set {
            memory[twoBytes: addr] = newValue
        }
    }

    public subscript(flag: Flags) -> Bool {
        get {
            getFlag(flag)
        } set {
            setFlag(flag, to: newValue)
        }
    }

    public subscript(addressingMode: AddressingMode) -> UInt16 {
        get {
            getAddress(addressingMode)
        }
    }

//    public static func <- (lhs: MOS6502Kit, rhs: Registers) -> UInt8 {
//        return lhs.registers[rhs]!
//    }
}
