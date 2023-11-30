import Foundation

public extension MOS6502 {
    /// ANDs the value at the specified address with the accumulator.
    mutating func AND(_ mode: AddressingMode) {
        let addr = getAddressAndMovePC(mode)
        let value = memory[addr]

        self[.A] &= value
        self[.Z] = self[.A] == 0
        self[.N] = self[.A] & 0b1000_0000 != 0
    }

    /// ORs the value at the specified address with the accumulator.
    mutating func ORA(_ mode: AddressingMode) {
        let addr = getAddressAndMovePC(mode)
        let value = memory[addr]

        self[.A] |= value
        self[.Z] = self[.A] == 0
        self[.N] = self[.A] & 0b1000_0000 != 0
    }

    /// XORs the value at the specified address with the accumulator.
    mutating func EOR(_ mode: AddressingMode) { // shouldnt it be xor lol
        let addr = getAddressAndMovePC(mode)
        let value = memory[addr]

        self[.A] ^= value
        self[.Z] = self[.A] == 0
        self[.N] = self[.A] & 0b1000_0000 != 0
    }
}
