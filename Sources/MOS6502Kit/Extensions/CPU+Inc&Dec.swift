import Foundation

public extension MOS6502 {
    mutating func INC(_ mode: AddressingMode) {
        let addr = getAddressAndMovePC(mode)
        let value = memory[addr] &+ 1

        self[.N] = value & 0b1000_0000 != 0
        self[.Z] = value == 0

        memory[addr] = value
    }
    
    mutating func INX() {
        let value = self[.X] &+ 1

        self[.N] = value & 0b1000_0000 != 0
        self[.Z] = value == 0

        self[.X] = value
    }
    
    mutating func INY() {
        let value = self[.Y] &+ 1

        self[.N] = value & 0b1000_0000 != 0
        self[.Z] = value == 0

        self[.Y] = value
    }
    
    mutating func DEC(_ mode: AddressingMode) {
        let addr = getAddressAndMovePC(mode)
        let value = memory[addr] &- 1

        self[.N] = value & 0b1000_0000 != 0
        self[.Z] = value == 0

        memory[addr] = value
    }
    
    mutating func DEX() {
        let value = self[.X] &- 1

        self[.N] = value & 0b1000_0000 != 0
        self[.Z] = value == 0

        self[.X] = value
    }
    
    mutating func DEY() {
        let value = self[.Y] &- 1

        self[.N] = value & 0b1000_0000 != 0
        self[.Z] = value == 0

        self[.Y] = value
    }
}
