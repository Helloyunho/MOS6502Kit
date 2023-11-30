import Foundation

public extension MOS6502 {
    /// Branches to the specified address if the carry flag is clear.
    mutating func BCC(_ mode: AddressingMode) {
        if !self[.C] {
            let addr = getAddressAndMovePC(mode)
            self.PC = addr
        }
    }

    /// Branches to the specified address if the carry flag is set.
    mutating func BCS(_ mode: AddressingMode) {
        if self[.C] {
            let addr = getAddressAndMovePC(mode)
            self.PC = addr
        }
    }

    /// Branches to the specified address if the zero flag is set.
    mutating func BNE(_ mode: AddressingMode) {
        if !self[.Z] {
            let addr = getAddressAndMovePC(mode)
            self.PC = addr
        }
    }

    /// Branches to the specified address if the zero flag is clear.
    mutating func BEQ(_ mode: AddressingMode) {
        if self[.Z] {
            let addr = getAddressAndMovePC(mode)
            self.PC = addr
        }
    }

    /// Branches to the specified address if the negative flag is clear.
    mutating func BPL(_ mode: AddressingMode) {
        if !self[.N] {
            let addr = getAddressAndMovePC(mode)
            self.PC = addr
        }
    }

    /// Branches to the specified address if the negative flag is set.
    mutating func BMI(_ mode: AddressingMode) {
        if self[.N] {
            let addr = getAddressAndMovePC(mode)
            self.PC = addr
        }
    }

    /// Branches to the specified address if the overflow flag is clear.
    mutating func BVC(_ mode: AddressingMode) {
        if !self[.V] {
            let addr = getAddressAndMovePC(mode)
            self.PC = addr
        }
    }

    /// Branches to the specified address if the overflow flag is set.
    mutating func BVS(_ mode: AddressingMode) {
        if self[.V] {
            let addr = getAddressAndMovePC(mode)
            self.PC = addr
        }
    }
}
