import Foundation

public extension MOS6502 {
    /// Jumps to the specified address.
    mutating func JMP(_ mode: AddressingMode) {
        let addr = getAddressAndMovePC(mode)
        self.PC = addr
    }

    /// Jumps to the specified address and saves the return address on the stack.
    mutating func JSR(_ mode: AddressingMode) {
        let addr = getAddressAndMovePC(mode)
        pushStack(UInt8((self.PC - 1) >> 8))
        pushStack(UInt8((self.PC - 1) & 0xFF))
        self.PC = addr
    }

    /// Returns from a subroutine.
    mutating func RTS(_ mode: AddressingMode) {
        let low = popStack()
        let high = popStack()
        self.PC = UInt16(high) << 8 | UInt16(low) + 1
    }

    /// Returns from an interrupt.
    mutating func RTI(_ mode: AddressingMode) {
        status = popStack()
        setFlag(.B, to: false)
        let low = popStack()
        let high = popStack()
        self.PC = UInt16(high) << 8 | UInt16(low)
    }
}
