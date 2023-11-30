import Foundation

public extension MOS6502 {
    /// Shifts the bits of the value at the specified address left by one bit.
    mutating func ASL(_ mode: AddressingMode? = nil) {
        let addr: UInt16?
        let value: UInt8
        if let mode {
            addr = getAddressAndMovePC(mode)
            value = memory[addr!]
        } else {
            addr = nil
            value = self[.A]
        }

        let result = value << 1
        let carry = value >> 7

        self[.C] = carry != 0
        self[.Z] = result == 0
        self[.N] = result & 0b1000_0000 != 0
        if let addr {
            memory[addr] = result
        } else {
            self[.A] = result
        }
    }

    /// Shifts the bits of the value at the specified address right by one bit.
    mutating func LSR(_ mode: AddressingMode? = nil) {
        let addr: UInt16?
        let value: UInt8
        if let mode {
            addr = getAddressAndMovePC(mode)
            value = memory[addr!]
        } else {
            addr = nil
            value = self[.A]
        }

        let result = value >> 1
        let carry = value << 7

        self[.C] = carry != 0
        self[.Z] = result == 0
        self[.N] = result & 0b1000_0000 != 0
        if let addr {
            memory[addr] = result
        } else {
            self[.A] = result
        }
    }

    /// Rotates the bits of the value at the specified address left by one bit.
    mutating func ROL(_ mode: AddressingMode? = nil) {
        let addr: UInt16?
        let value: UInt8
        if let mode {
            addr = getAddressAndMovePC(mode)
            value = memory[addr!]
        } else {
            addr = nil
            value = self[.A]
        }

        let carry = value >> 7
        let result = value << 1 | carry

        self[.C] = carry != 0
        self[.Z] = result == 0
        self[.N] = result & 0b1000_0000 != 0
        if let addr {
            memory[addr] = result
        } else {
            self[.A] = result
        }
    }

    /// Rotates the bits of the value at the specified address right by one bit.
    mutating func ROR(_ mode: AddressingMode? = nil) {
        let addr: UInt16?
        let value: UInt8
        if let mode {
            addr = getAddressAndMovePC(mode)
            value = memory[addr!]
        } else {
            addr = nil
            value = self[.A]
        }

        let carry = value << 7
        let result = value >> 1 | carry

        self[.C] = carry != 0
        self[.Z] = result == 0
        self[.N] = result & 0b1000_0000 != 0
        if let addr {
            memory[addr] = result
        } else {
            self[.A] = result
        }
    }
}
