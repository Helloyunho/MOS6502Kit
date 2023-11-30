import Foundation

public extension MOS6502 {
    /// Loads the value at the specified address into the accumulator.
    mutating func LDA(_ mode: AddressingMode) {
        let addr = getAddressAndMovePC(mode)
        let data = self[addr]
        self[.A] = data
        self[.N] = data & 0b1000_0000 != 0
        self[.Z] = data == 0
    }

    /// Loads the value at the specified address into the X register.
    mutating func LDX(_ mode: AddressingMode) {
        let addr = getAddressAndMovePC(mode)
        let data = self[addr]
        self[.X] = data
        self[.N] = data & 0b1000_0000 != 0
        self[.Z] = data == 0
    }

    /// Loads the value at the specified address into the Y register.
    mutating func LDY(_ mode: AddressingMode) {
        let addr = getAddressAndMovePC(mode)
        let data = self[addr]
        self[.Y] = data
        self[.N] = data & 0b1000_0000 != 0
        self[.Z] = data == 0
    }

    /// Stores the value in the accumulator at the specified address.
    mutating func STA(_ mode: AddressingMode) {
        let addr = getAddressAndMovePC(mode)
        self[addr] = self[.A]
    }

    /// Stores the value in the X register at the specified address.
    mutating func STX(_ mode: AddressingMode) {
        let addr = getAddressAndMovePC(mode)
        self[addr] = self[.X]
    }

    /// Stores the value in the Y register at the specified address.
    mutating func STY(_ mode: AddressingMode) {
        let addr = getAddressAndMovePC(mode)
        self[addr] = self[.Y]
    }
}
