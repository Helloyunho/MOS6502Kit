import Foundation

public struct BasicMemory: MemoryLayout {
    /// DONT ACCESS THIS DIRECTLY PLEASE GOD
    var memory: Data

    var count: Int {
        memory.count
    }

    /**
     Uses the provided data as memory.

     - Parameters:
        - memory: Memory representation in Data.
     */
    public init(memory: Data) {
        self.memory = memory
    }

    /**
     Initializes memory for limited count.

     - Parameters:
        - count: Memory size to initialize.
     */
    public init(count: UInt16) {
        memory = Data(count: Int(count))
    }

    /// Initializes all the available memory (0xFFFF or 65535 bytes).
    public init() {
        self.init(count: 0xFFFF)
    }

    public func read(_ addr: UInt16) -> UInt8 {
        memory[Data.Index(addr)]
    }

    public func read2Bytes(_ addr: UInt16) -> UInt16 {
        UInt16(read(addr)) | UInt16(read(addr &+ 1)) << 8
    }

    @discardableResult
    public mutating func write(_ addr: UInt16, _ value: UInt8) -> UInt8 {
        memory[Data.Index(addr)] = value
        return value
    }

    /**
     Writes two bytes at specific address.

     - Parameters:
        - addr: Specific address to set the value.
        - value: A two bytes value.
     - Returns: The same value.
     > Important: If you're implementing this function by yourself, please note that 6502 memory is stored in
     > [little-endian](https://en.wikipedia.org/wiki/Endianness).
     > For example, if the value is `0x00FF` and the address is `0x0`,
     > ``write(_:_:)-3h84e`` writes `0xFF` to `0x0` and `0x00` to `0x1`.

     > Important: It's also worth noting that the address like `0xFFFF` can cause overflow since
     > `0xFFFF + 1` is above 16-bit. When this happens, write the value on `0x0` instead.
     > Surprisingly this is excepted behaviour and some 6502 code uses this.
     */
    @discardableResult
    public mutating func write(_ addr: UInt16, _ value: UInt16) -> UInt16 {
        write(addr, UInt8(value & 0xFF))
        write(addr &+ 1, UInt8(value >> 8))
        return value
    }

    /// Reads and writes single byte at specific address.
    public subscript(addr: UInt16) -> UInt8 {
        get {
            read(addr)
        }
        set {
            write(addr, newValue)
        }
    }

    /// Reads and writes two bytes at specific address.
    public subscript(twoBytes addr: UInt16) -> UInt16 {
        get {
            read2Bytes(addr)
        }
        set {
            write(addr, newValue)
        }
    }
}
