// infix operator <-: DefaultPrecedence]

public struct MOS6502 {
    // MARK: Variables

    public static var opHandlers = [UInt8: () -> ()]()

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

    public mutating func getAddressAndMovePC(_ mode: AddressingMode) -> UInt16 {
        let data = getAddress(mode)
        switch mode {
        case .immediate, .zeroPage, .relative, .zeroPageIndexedX, .zeroPageIndexedY, .zeroPageIndexedIndirectX, .zeroPageIndexedIndirectY:
            PC += 1
        case .absolute, .absoluteIndirect, .absoluteIndexedX, .absoluteIndexedY:
            PC += 2
        default:
            // TODO: Make a proper error
            fatalError("Register addressing mode detected.")
        }

        return data
    }

    public mutating func step() {
        let op = memory[PC]
        PC += 1
        
        switch op {
        case 0xAD:
            LDA(.absolute)
        case 0xBD:
            LDA(.absoluteIndexedX)
        case 0xB9:
            LDA(.absoluteIndexedY)
        case 0xA9:
            LDA(.immediate)
        case 0xA5:
            LDA(.zeroPage)
        case 0xA1:
            LDA(.zeroPageIndexedIndirectX)
        case 0xB5:
            LDA(.zeroPageIndexedX)
        case 0xB1:
            LDA(.zeroPageIndexedIndirectY)
        case 0xAE:
            LDX(.absolute)
        case 0xBE:
            LDX(.absoluteIndexedY)
        case 0xA2:
            LDX(.immediate)
        case 0xA6:
            LDX(.zeroPage)
        case 0xB6:
            LDX(.zeroPageIndexedY)
        case 0xAC:
            LDY(.absolute)
        case 0xBC:
            LDY(.absoluteIndexedX)
        case 0xA0:
            LDY(.immediate)
        case 0xA4:
            LDY(.zeroPage)
        case 0xB4:
            LDY(.zeroPageIndexedX)
        case 0x8D:
            STA(.absolute)
        case 0x9D:
            STA(.absoluteIndexedX)
        case 0x99:
            STA(.absoluteIndexedY)
        case 0x85:
            STA(.zeroPage)
        case 0x81:
            STA(.zeroPageIndexedIndirectX)
        case 0x95:
            STA(.zeroPageIndexedX)
        case 0x91:
            STA(.zeroPageIndexedIndirectY)
        case 0x8E:
            STX(.absolute)
        case 0x86:
            STX(.zeroPage)
        case 0x96:
            STX(.zeroPageIndexedY)
        case 0x8C:
            STY(.absolute)
        case 0x84:
            STY(.zeroPage)
        case 0x94:
            STY(.zeroPageIndexedX)
        case 0x6D:
            ADC(.absolute)
        case 0x7D:
            ADC(.absoluteIndexedX)
        case 0x79:
            ADC(.absoluteIndexedY)
        case 0x69:
            ADC(.immediate)
        case 0x65:
            ADC(.zeroPage)
        case 0x61:
            ADC(.zeroPageIndexedIndirectX)
        case 0x75:
            ADC(.zeroPageIndexedX)
        case 0x71:
            ADC(.zeroPageIndexedIndirectY)
        case 0xED:
            SBC(.absolute)
        case 0xFD:
            SBC(.absoluteIndexedX)
        case 0xF9:
            SBC(.absoluteIndexedY)
        case 0xE9:
            SBC(.immediate)
        case 0xE5:
            SBC(.zeroPage)
        case 0xE1:
            SBC(.zeroPageIndexedIndirectX)
        case 0xF5:
            SBC(.zeroPageIndexedX)
        case 0xF1:
            SBC(.zeroPageIndexedIndirectY)
        case 0xEE:
            INC(.absolute)
        case 0xFE:
            INC(.absoluteIndexedX)
        case 0xE6:
            INC(.zeroPage)
        case 0xF6:
            INC(.zeroPageIndexedX)
        case 0xCA:
            DEX()
        case 0x88:
            DEY()
        case 0xC6:
            DEC(.zeroPage)
        case 0xD6:
            DEC(.zeroPageIndexedX)
        case 0xCE:
            DEC(.absolute)
        case 0xDE:
            DEC(.absoluteIndexedX)
        case 0xE8:
            INX()
        case 0xC8:
            INY()
        default:
            fatalError("Unknown OP code \(op) detected.")
        }
    }
//    public static func <- (lhs: MOS6502Kit, rhs: Registers) -> UInt8 {
//        return lhs.registers[rhs]!
//    }
}
