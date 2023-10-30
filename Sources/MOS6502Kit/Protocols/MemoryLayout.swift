import Foundation

public protocol MemoryLayout {
    /**
     Reads single byte at specific address.

     - Parameters:
        - addr: Specific address to get the value.
     - Returns: The requested value.
     */
    func read(_ addr: UInt16) -> UInt8
    /**
     Reads two bytes at specific address.

     - Parameters:
        - addr: Specific address to get the value.
     - Returns: The requested value.

     > Important: If you're implementing this function by yourself, please note that 6502 memory is stored in
     > [little-endian](https://en.wikipedia.org/wiki/Endianness).
     > For example, if address `0x0` has `0xFF` and `0x1` has `0x00`, the value for ``read2Bytes(_:)`` is `0x00FF`.
     
     > Important: It's also worth noting that the address like `0xFFFF` can cause overflow since
     > `0xFFFF + 1` is above 16-bit. When this happens, read the value on `0x0` instead.
     > Surprisingly this is excepted behaviour and some 6502 code uses this.
     */
    func read2Bytes(_ addr: UInt16) -> UInt16

    /**
     Writes single byte at specific address.

     - Parameters:
        - addr: Specific address to set the value.
        - value: A single byte value.
     - Returns: The same value.
     */
    mutating func write(_ addr: UInt16, _ value: UInt8) -> UInt8
    /**
     Writes two bytes at specific address.

     - Parameters:
        - addr: Specific address to set the value.
        - value: A two bytes value.
     - Returns: The same value.
     > Important: If you're implementing this function by yourself, please note that 6502 memory is stored in
     > [little-endian](https://en.wikipedia.org/wiki/Endianness).
     > For example, if the value is `0x00FF` and the address is `0x0`,
     > ``write(_:_:)-6gcym`` writes `0xFF` to `0x0` and `0x00` to `0x1`.
     
     > Important: It's also worth noting that the address like `0xFFFF` can cause overflow since
     > `0xFFFF + 1` is above 16-bit. When this happens, write the value on `0x0` instead.
     > Surprisingly this is excepted behaviour and some 6502 code uses this.
     */
    mutating func write(_ addr: UInt16, _ value: UInt16) -> UInt16

    subscript(_ addr: UInt16) -> UInt8 { get set }
    subscript(twoBytes addr: UInt16) -> UInt16 { get set }
}
