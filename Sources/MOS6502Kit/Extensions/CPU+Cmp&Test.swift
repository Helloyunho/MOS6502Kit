import Foundation

public extension MOS6502 {
    /**
     Compares the value at the specified address with the accumulator.
     
     Sets the zero flag if the values are equal,
     the negative flag if the value in the accumulator is less than the value at the specified address,
     and the carry flag if the value in the accumulator is greater than or equal to the value at the specified address.

     TL;DR:
     |Condition|N|Z|C|
     |---------|-|-|-|
     |A < M    |1|0|0|
     |A = M    |0|1|1|
     |A > M    |0|0|1|
    */
    mutating func CMP(_ mode: AddressingMode) {
        let addr = getAddressAndMovePC(mode)
        let value = memory[addr]
        let a = self[.A]

        self[.N] = a < value
        self[.Z] = value == a
        self[.C] = a >= value
    }

    /**
     Compares the value at the specified address with the X register.
     
     Sets the zero flag if the values are equal,
     the negative flag if the value in the X register is less than the value at the specified address,
     and the carry flag if the value in the X register is greater than or equal to the value at the specified address.

     TL;DR:
     |Condition|N|Z|C|
     |---------|-|-|-|
     |A < M    |1|0|0|
     |A = M    |0|1|1|
     |A > M    |0|0|1|
     */
    mutating func CPX(_ mode: AddressingMode) {
        let addr = getAddressAndMovePC(mode)
        let value = memory[addr]
        let x = self[.X]

        self[.N] = x < value
        self[.Z] = value == x
        self[.C] = x >= value
    }

    /**
     Compares the value at the specified address with the X register.

     Sets the zero flag if the values are equal,
     the negative flag if the value in the X register is less than the value at the specified address,
     and the carry flag if the value in the X register is greater than or equal to the value at the specified address.

     TL;DR:
     |Condition|N|Z|C|
     |---------|-|-|-|
     |A < M    |1|0|0|
     |A = M    |0|1|1|
     |A > M    |0|0|1|
     */
    mutating func CPY(_ mode: AddressingMode) {
        let addr = getAddressAndMovePC(mode)
        let value = memory[addr]
        let y = self[.Y]

        self[.N] = y < value
        self[.Z] = value == y
        self[.C] = y >= value
    }

    /**
     Tests the bits of the value at the specified address against the accumulator.
     
     Sets the zero flag if the result of the AND operation is zero,
     the negative flag if bit 7 of the value at the specified address is set,
     and the overflow flag if bit 6 of the value at the specified address is set.

     TL;DR:
     |Condition|N|Z|V|
     |---------|-|-|-|
     |A & M = 0|0|1|0|
     |A & M != 0|M7|0|M6|
     */
    mutating func BIT(_ mode: AddressingMode) {
        let addr = getAddressAndMovePC(mode)
        let value = memory[addr]
        let result = self[.A] & value

        self[.Z] = result == 0
        self[.N] = value & 0b1000_0000 != 0
        self[.V] = value & 0b0100_0000 != 0
    }
}
