import Foundation

public extension MOS6502 {
    mutating func LDA(_ mode: AddressingMode) {
        let addr = getAddressAndMovePC(mode)
        let data = self[addr]
        self[.A] = data
        self[.N] = data & 0b1000_0000 != 0
        self[.Z] = data == 0
    }
    
    mutating func LDX(_ mode: AddressingMode) {
        let addr = getAddressAndMovePC(mode)
        let data = self[addr]
        self[.X] = data
        self[.N] = data & 0b1000_0000 != 0
        self[.Z] = data == 0
    }
    
    mutating func LDY(_ mode: AddressingMode) {
        let addr = getAddressAndMovePC(mode)
        let data = self[addr]
        self[.Y] = data
        self[.N] = data & 0b1000_0000 != 0
        self[.Z] = data == 0
    }
    
    mutating func STA(_ mode: AddressingMode) {
        let addr = getAddressAndMovePC(mode)
        self[addr] = self[.A]
    }
    
    mutating func STX(_ mode: AddressingMode) {
        let addr = getAddressAndMovePC(mode)
        let data = self[addr]
        self[addr] = self[.X]
    }
    
    mutating func STY(_ mode: AddressingMode) {
        let addr = getAddressAndMovePC(mode)
        let data = self[addr]
        self[addr] = self[.Y]
    }
}
