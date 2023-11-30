import Foundation

public extension MOS6502 {
    /// Pushes the value in the accumulator onto the stack.
    mutating func PHA() {
        pushStack(self[.A])
    }

    /// Pulls the value from the stack into the accumulator.
    mutating func PLA() {
        self[.A] = popStack()
        self[.Z] = self[.A] == 0
        self[.N] = self[.A] & 0b1000_0000 != 0
    }

    /// Pushes the value in the status register onto the stack.
    mutating func PHP() {
        pushStack(self[.P])
    }

    /// Pulls the value from the stack into the status register.
    mutating func PLP() {
        self[.P] = popStack()
    }
}
