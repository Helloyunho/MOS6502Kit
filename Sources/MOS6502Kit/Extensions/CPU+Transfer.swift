import Foundation

public extension MOS6502 {
    mutating func TAX() {
        let value = self[.A]

        self[.X] = value
        self[.Z] = self[.X] == 0
        self[.N] = self[.X] & 0b1000_0000 != 0
    }

    mutating func TXA() {
        let value = self[.X]

        self[.A] = value
        self[.Z] = self[.A] == 0
        self[.N] = self[.A] & 0b1000_0000 != 0
    }

    mutating func TAY() {
        let value = self[.A]

        self[.Y] = value
        self[.Z] = self[.Y] == 0
        self[.N] = self[.Y] & 0b1000_0000 != 0
    }

    mutating func TYA() {
        let value = self[.Y]

        self[.A] = value
        self[.Z] = self[.A] == 0
        self[.N] = self[.A] & 0b1000_0000 != 0
    }

    mutating func TSX() {
        let value = self[.S]

        self[.X] = value
        self[.Z] = self[.X] == 0
        self[.N] = self[.X] & 0b1000_0000 != 0
    }

    mutating func TXS() {
        let value = self[.X]

        self[.S] = value
        self[.Z] = self[.S] == 0
        self[.N] = self[.S] & 0b1000_0000 != 0
    }
}
