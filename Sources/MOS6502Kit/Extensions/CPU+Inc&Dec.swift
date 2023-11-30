import Foundation

public extension MOS6502 {
    /// Increments the value at the specified address by one.
    mutating func INC(_ mode: AddressingMode) {
        let addr = getAddressAndMovePC(mode)
        let value = memory[addr] &+ 1

        self[.N] = value & 0b1000_0000 != 0
        self[.Z] = value == 0

        memory[addr] = value
    }

    /// Increments the X register by one.
    mutating func INX() {
        let value = self[.X] &+ 1

        self[.N] = value & 0b1000_0000 != 0
        self[.Z] = value == 0

        self[.X] = value
    }

    /// Increments the Y register by one.
    mutating func INY() {
        let value = self[.Y] &+ 1

        self[.N] = value & 0b1000_0000 != 0
        self[.Z] = value == 0

        self[.Y] = value
    }

    /// Decrements the value at the specified address by one.
    mutating func DEC(_ mode: AddressingMode) {
        let addr = getAddressAndMovePC(mode)
        let value = memory[addr] &- 1

        self[.N] = value & 0b1000_0000 != 0
        self[.Z] = value == 0

        memory[addr] = value
    }

    /// Decrements the X register by one.
    mutating func DEX() {
        let value = self[.X] &- 1

        self[.N] = value & 0b1000_0000 != 0
        self[.Z] = value == 0

        self[.X] = value
    }

    /// Decrements the Y register by one.
    mutating func DEY() {
        let value = self[.Y] &- 1

        self[.N] = value & 0b1000_0000 != 0
        self[.Z] = value == 0

        self[.Y] = value
    }
}
