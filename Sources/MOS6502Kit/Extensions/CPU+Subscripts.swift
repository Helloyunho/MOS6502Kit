import Foundation

public extension MOS6502 {
    subscript(register: AccessableRegisters) -> UInt8 {
        get {
            registers[register]!
        }
        set {
            registers[register] = newValue
        }
    }

    subscript(addr: UInt16) -> UInt8 {
        get {
            memory[addr]
        }
        set {
            memory[addr] = newValue
        }
    }

    subscript(twoBytes addr: UInt16) -> UInt16 {
        get {
            memory[twoBytes: addr]
        }
        set {
            memory[twoBytes: addr] = newValue
        }
    }

    subscript(flag: Flags) -> Bool {
        get {
            getFlag(flag)
        } set {
            setFlag(flag, to: newValue)
        }
    }

    subscript(addressingMode: AddressingMode) -> UInt16 {
        getAddress(addressingMode)
    }
}
