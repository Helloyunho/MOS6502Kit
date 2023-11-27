import Foundation

public extension MOS6502 {
    mutating func CMP(_ mode: AddressingMode) {
        let addr = getAddressAndMovePC(mode)
        let value = memory[addr]
        let a = self[.A]

        self[.N] = a < value
        self[.Z] = value == a
        self[.C] = a >= value
    }

    mutating func CPX(_ mode: AddressingMode) {
        let addr = getAddressAndMovePC(mode)
        let value = memory[addr]
        let x = self[.X]

        self[.N] = x < value
        self[.Z] = value == x
        self[.C] = x >= value
    }

    mutating func CPY(_ mode: AddressingMode) {
        let addr = getAddressAndMovePC(mode)
        let value = memory[addr]
        let y = self[.Y]

        self[.N] = y < value
        self[.Z] = value == y
        self[.C] = y >= value
    }

    mutating func BIT(_ mode: AddressingMode) {
        let addr = getAddressAndMovePC(mode)
        let value = memory[addr]
        let result = self[.A] & value

        self[.Z] = result == 0
        self[.N] = result & 0b1000_0000 != 0
        self[.V] = result & 0b0100_0000 != 0
    }
}
