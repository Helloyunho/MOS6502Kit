import Foundation

public extension MOS6502 {
    mutating func CLC() {
        self[.C] = false
    }

    mutating func SEC() {
        self[.C] = true
    }

    mutating func CLI() {
        self[.I] = false
    }

    mutating func SEI() {
        self[.I] = true
    }

    mutating func CLV() {
        self[.V] = false
    }

    mutating func CLD() {
        self[.D] = false
    }

    mutating func SED() {
        self[.D] = true
    }
}