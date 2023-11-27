import Foundation

public extension MOS6502 {
    mutating func PHA() {
        pushStack(self[.A])
    }

    mutating func PLA() {
        self[.A] = popStack()
        self[.Z] = self[.A] == 0
        self[.N] = self[.A] & 0b1000_0000 != 0
    }

    mutating func PHP() {
        pushStack(self[.P])
    }

    mutating func PLP() {
        self[.P] = popStack()
    }
}
