import Foundation

public extension MOS6502 {
    mutating func ADC(_ mode: AddressingMode) {
        let addr = getAddressAndMovePC(mode)
        let value = memory[addr]
        let uint16sum = UInt16(self[.A]) &+ UInt16(value) &+ (self[.C] ? 1 : 0)
        let uint8sum = UInt8(uint16sum & 0xFF)

        self[.N] = uint16sum & 0b1000_0000 != 0
        self[.V] = (self[.A] ^ uint8sum) & (value ^ uint8sum) & 0b1000_0000 != 0
        self[.Z] = uint8sum == 0
        self[.C] = uint16sum > 0xFF

        self[.A] = uint8sum
    }

    mutating func SBC(_ mode: AddressingMode) {
        let addr = getAddressAndMovePC(mode)
        let value = memory[addr]
        let uint16sum = UInt16(self[.A]) &- UInt16(value) &- (self[.C] ? 0 : 1)
        let uint8sum = UInt8(uint16sum & 0xFF)

        self[.N] = uint16sum & 0b1000_0000 != 0
        self[.V] = (self[.A] ^ uint8sum) & (~value ^ uint8sum) & 0b1000_0000 != 0
        self[.Z] = uint8sum == 0
        self[.C] = uint16sum > 0xFF

        self[.A] = uint8sum
    }
}
