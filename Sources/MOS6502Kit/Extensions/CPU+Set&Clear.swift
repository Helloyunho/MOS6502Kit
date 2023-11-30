import Foundation

public extension MOS6502 {
    /// Clears the Carry flag.
    mutating func CLC() {
        self[.C] = false
    }

    /// Sets the Carry flag.
    mutating func SEC() {
        self[.C] = true
    }

    /// Clears the Interrupt Disable flag.
    mutating func CLI() {
        self[.I] = false
    }

    /// Sets the Interrupt Disable flag.
    mutating func SEI() {
        self[.I] = true
    }

    /// Clears the Overflow flag.
    mutating func CLV() {
        self[.V] = false
    }

    /// Clears the Decimal flag.
    mutating func CLD() {
        self[.D] = false
    }

    /// Sets the Decimal flag.
    mutating func SED() {
        self[.D] = true
    }
}