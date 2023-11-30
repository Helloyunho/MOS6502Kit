import Foundation

public extension MOS6502 {
    /// Transfers the value in the accumulator to the X register.
    mutating func TAX() {
        let value = self[.A]

        self[.X] = value
        self[.Z] = self[.X] == 0
        self[.N] = self[.X] & 0b1000_0000 != 0
    }

    /// Transfers the value in the X register to the accumulator.
    mutating func TXA() {
        let value = self[.X]

        self[.A] = value
        self[.Z] = self[.A] == 0
        self[.N] = self[.A] & 0b1000_0000 != 0
    }

    /// Transfers the value in the accumulator to the Y register.
    mutating func TAY() {
        let value = self[.A]

        self[.Y] = value
        self[.Z] = self[.Y] == 0
        self[.N] = self[.Y] & 0b1000_0000 != 0
    }

    /// Transfers the value in the Y register to the accumulator.
    mutating func TYA() {
        let value = self[.Y]

        self[.A] = value
        self[.Z] = self[.A] == 0
        self[.N] = self[.A] & 0b1000_0000 != 0
    }

    /// Transfers the value in the stack pointer to the X register.
    mutating func TSX() {
        let value = self[.S]

        self[.X] = value
        self[.Z] = self[.X] == 0
        self[.N] = self[.X] & 0b1000_0000 != 0
    }

    /// Transfers the value in the X register to the stack pointer.
    mutating func TXS() {
        let value = self[.X]

        self[.S] = value
        self[.Z] = self[.S] == 0
        self[.N] = self[.S] & 0b1000_0000 != 0
    }
}
