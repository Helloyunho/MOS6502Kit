import Foundation

public extension MOS6502 {
    mutating func JMP(_ mode: AddressingMode) {
        let addr = getAddressAndMovePC(mode)
        self.PC = addr
    }

    mutating func JSR(_ mode: AddressingMode) {
        let addr = getAddressAndMovePC(mode)
        pushStack(UInt8((self.PC - 1) >> 8))
        pushStack(UInt8((self.PC - 1) & 0xFF))
        self.PC = addr
    }

    mutating func RTS(_ mode: AddressingMode) {
        let low = popStack()
        let high = popStack()
        self.PC = UInt16(high) << 8 | UInt16(low) + 1
    }

    mutating func RTI(_ mode: AddressingMode) {
        self[.P] = popStack()
        let low = popStack()
        let high = popStack()
        self.PC = UInt16(high) << 8 | UInt16(low)
    }
}
