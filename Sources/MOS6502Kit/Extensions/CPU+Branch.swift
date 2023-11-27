import Foundation

public extension MOS6502 {
    mutating func BCC(_ mode: AddressingMode) {
        if !self[.C] {
            let addr = getAddressAndMovePC(mode)
            self.PC = addr
        }
    }

    mutating func BCS(_ mode: AddressingMode) {
        if self[.C] {
            let addr = getAddressAndMovePC(mode)
            self.PC = addr
        }
    }

    mutating func BNE(_ mode: AddressingMode) {
        if !self[.Z] {
            let addr = getAddressAndMovePC(mode)
            self.PC = addr
        }
    }

    mutating func BEQ(_ mode: AddressingMode) {
        if self[.Z] {
            let addr = getAddressAndMovePC(mode)
            self.PC = addr
        }
    }

    mutating func BPL(_ mode: AddressingMode) {
        if !self[.N] {
            let addr = getAddressAndMovePC(mode)
            self.PC = addr
        }
    }

    mutating func BMI(_ mode: AddressingMode) {
        if self[.N] {
            let addr = getAddressAndMovePC(mode)
            self.PC = addr
        }
    }

    mutating func BVC(_ mode: AddressingMode) {
        if !self[.V] {
            let addr = getAddressAndMovePC(mode)
            self.PC = addr
        }
    }

    mutating func BVS(_ mode: AddressingMode) {
        if self[.V] {
            let addr = getAddressAndMovePC(mode)
            self.PC = addr
        }
    }
}
