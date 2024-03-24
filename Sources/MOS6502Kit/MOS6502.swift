// infix operator <-: DefaultPrecedence]

// swiftlint:disable type_body_length
public struct MOS6502 {
    // MARK: Variables

    public static var opHandlers = [UInt8: () -> Void]()

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

    /**
     Gets the address with specified addressing mode.
     
     - Parameters:
        - mode: Desired way to get the address.
     - Returns: The address with specified addressing mode.
     */
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

    /**
     Gets the address with specified addressing mode and moves PC register accordingly.
     
     - Parameters:
        - mode: Desired way to get the address.
     - Returns: The address with specified addressing mode.
     */
    public mutating func getAddressAndMovePC(_ mode: AddressingMode) -> UInt16 {
        let data = getAddress(mode)
        switch mode {
        case .immediate, .zeroPage,
             .relative, .zeroPageIndexedX,
             .zeroPageIndexedY, .zeroPageIndexedIndirectX,
             .zeroPageIndexedIndirectY:
            PC += 1
        case .absolute, .absoluteIndirect, .absoluteIndexedX, .absoluteIndexedY:
            PC += 2
        default:
            // TODO: Make a proper error
            fatalError("Register addressing mode detected.")
        }

        return data
    }

    /**
     Pushs the value into the stack.
     
     - Parameters:
        - value: A single byte value.
     */
    public mutating func pushStack(_ value: UInt8) {
        memory[0x100 + UInt16(self[.S])] = value
        self[.S] -= 1
    }

    // public mutating func pushStack(_ value: UInt16) {
    //     pushStack(UInt8(value >> 8))
    //     pushStack(UInt8(value & 0xFF))
    // }

    /**
     Pops the value from the stack.
     
     - Returns: The last value that was in the stack.
     */
    public mutating func popStack() -> UInt8 {
        self[.S] += 1
        return memory[0x100 + UInt16(self[.S])]
    }

    // public mutating func popStack() -> UInt16 {
    //     let low = UInt16(popStack())
    //     let high = UInt16(popStack())
    //     return (high << 8) | low
    // }

    // swiftlint:disable function_body_length
    /**
     Reads the current op code and interprets accordingly.
     
     > Note: This function automatically increases the PC register.
     */
    public mutating func step() async {
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
        case 0xE8:
            INX()
        case 0xC8:
            INY()
        case 0xCE:
            DEC(.absolute)
        case 0xDE:
            DEC(.absoluteIndexedX)
        case 0xC6:
            DEC(.zeroPage)
        case 0xD6:
            DEC(.zeroPageIndexedX)
        case 0xCA:
            DEX()
        case 0x88:
            DEY()
        case 0x0A:
            ASL()
        case 0x0E:
            ASL(.absolute)
        case 0x1E:
            ASL(.absoluteIndexedX)
        case 0x06:
            ASL(.zeroPage)
        case 0x16:
            ASL(.zeroPageIndexedX)
        case 0x4A:
            LSR()
        case 0x4E:
            LSR(.absolute)
        case 0x5E:
            LSR(.absoluteIndexedX)
        case 0x46:
            LSR(.zeroPage)
        case 0x56:
            LSR(.zeroPageIndexedX)
        case 0x2A:
            ROL()
        case 0x2E:
            ROL(.absolute)
        case 0x3E:
            ROL(.absoluteIndexedX)
        case 0x26:
            ROL(.zeroPage)
        case 0x36:
            ROL(.zeroPageIndexedX)
        case 0x6A:
            ROR()
        case 0x6E:
            ROR(.absolute)
        case 0x7E:
            ROR(.absoluteIndexedX)
        case 0x66:
            ROR(.zeroPage)
        case 0x76:
            ROR(.zeroPageIndexedX)
        case 0x2D:
            AND(.absolute)
        case 0x3D:
            AND(.absoluteIndexedX)
        case 0x39:
            AND(.absoluteIndexedY)
        case 0x29:
            AND(.immediate)
        case 0x25:
            AND(.zeroPage)
        case 0x21:
            AND(.zeroPageIndexedIndirectX)
        case 0x35:
            AND(.zeroPageIndexedX)
        case 0x31:
            AND(.zeroPageIndexedIndirectY)
        case 0x0D:
            ORA(.absolute)
        case 0x1D:
            ORA(.absoluteIndexedX)
        case 0x19:
            ORA(.absoluteIndexedY)
        case 0x09:
            ORA(.immediate)
        case 0x05:
            ORA(.zeroPage)
        case 0x01:
            ORA(.zeroPageIndexedIndirectX)
        case 0x15:
            ORA(.zeroPageIndexedX)
        case 0x11:
            ORA(.zeroPageIndexedIndirectY)
        case 0x4D:
            EOR(.absolute)
        case 0x5D:
            EOR(.absoluteIndexedX)
        case 0x59:
            EOR(.absoluteIndexedY)
        case 0x49:
            EOR(.immediate)
        case 0x45:
            EOR(.zeroPage)
        case 0x41:
            EOR(.zeroPageIndexedIndirectX)
        case 0x55:
            EOR(.zeroPageIndexedX)
        case 0x51:
            EOR(.zeroPageIndexedIndirectY)
        case 0xCD:
            CMP(.absolute)
        case 0xDD:
            CMP(.absoluteIndexedX)
        case 0xD9:
            CMP(.absoluteIndexedY)
        case 0xC9:
            CMP(.immediate)
        case 0xC5:
            CMP(.zeroPage)
        case 0xC1:
            CMP(.zeroPageIndexedIndirectX)
        case 0xD5:
            CMP(.zeroPageIndexedX)
        case 0xD1:
            CMP(.zeroPageIndexedIndirectY)
        case 0xEC:
            CPX(.absolute)
        case 0xE0:
            CPX(.immediate)
        case 0xE4:
            CPX(.zeroPage)
        case 0xCC:
            CPY(.absolute)
        case 0xC0:
            CPY(.immediate)
        case 0xC4:
            CPY(.zeroPage)
        case 0x24:
            BIT(.zeroPage)
        case 0x2C:
            BIT(.absolute)
        case 0x89:
            BIT(.immediate)
        case 0x90:
            BCC(.relative)
        case 0xB0:
            BCS(.relative)
        case 0xD0:
            BNE(.relative)
        case 0xF0:
            BEQ(.relative)
        case 0x10:
            BPL(.relative)
        case 0x30:
            BMI(.relative)
        case 0x50:
            BVC(.relative)
        case 0x70:
            BVS(.relative)
        case 0x4C:
            JMP(.absolute)
        case 0x6C:
            JMP(.absoluteIndirect)
        case 0x20:
            JSR(.absolute)
        case 0x60:
            RTS(.implied)
        case 0x40:
            RTI(.implied)
        case 0x18:
            CLC()
        case 0x38:
            SEC()
        case 0x58:
            CLI()
        case 0x78:
            SEI()
        case 0xB8:
            CLV()
        case 0xD8:
            CLD()
        case 0xF8:
            SED()
        case 0x48:
            PHA()
        case 0x68:
            PLA()
        case 0x08:
            PHP()
        case 0x28:
            PLP()
        case 0xAA:
            TAX()
        case 0x8A:
            TXA()
        case 0xA8:
            TAY()
        case 0x98:
            TYA()
        case 0xBA:
            TSX()
        case 0x9A:
            TXS()
        case 0xEA:
            // NOP
            break
        case 0x00:
            self[.B] = true
            self[.I] = true
        default:
            fatalError("Unknown OP code \(op) detected.")
        }
    }
    // swiftlint:enable function_body_length
//    public static func <- (lhs: MOS6502Kit, rhs: Registers) -> UInt8 {
//        return lhs.registers[rhs]!
//    }
}

// swiftlint:enable type_body_length
