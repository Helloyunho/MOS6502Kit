import XCTest
@testable import MOS6502Kit

final class BasicMemoryTests: XCTestCase {
    func testBasicMemoryInitialization() {
        // maximum size
        let allMem = BasicMemory()
        XCTAssertEqual(allMem.count, 0xFFFF, "Maximum sized memory count test")
        
        // limited size
        let limitMem = BasicMemory(count: 0xFFF)
        XCTAssertEqual(limitMem.count, 0xFFF, "Limited size memory count test")
        
        // custom data
        var data = Data(count: 0x4)
        data[0] = 0xCA
        data[1] = 0xFE
        data[2] = 0xBA
        data[3] = 0xBE // 0xCAFEBABE lol
        var customMem = BasicMemory(memory: data)

        XCTAssertEqual(data.count, customMem.count, "Memory with custom data count test")
        XCTAssertEqual(data[0], customMem[0], "Memory with custom data equality test")
        XCTAssertEqual(data[1], customMem.read(1), "Memory with custom data equality test")
        XCTAssertEqual(data[2], customMem[2], "Memory with custom data equality test")
        XCTAssertEqual(data[3], customMem[3], "Memory with custom data equality test")
    }
    
    func testBasicMemoryModification() {
        var mem = BasicMemory(count: 0x4)
        mem[0] = 0xAA
        XCTAssertEqual(mem[0], 0xAA, "Memory value test")
        
        mem.write(0, UInt8(0xEA))
        XCTAssertEqual(mem[0], 0xEA, "Memory value test (after mod)")
    }
    
    func testBasicMemory16BitIO() {
        var data = Data(count: 0x4)
        data[0] = 0xEA
        data[1] = 0xAA
        data[2] = 0x10
        data[3] = 0x01
        var mem = BasicMemory(memory: data)

        XCTAssertEqual(mem.read2Bytes(0x0), 0xAAEA, "Memory 16 bit read test")
        XCTAssertEqual(mem.read2Bytes(0x2), 0x0110, "Memory 16 bit read test")
        
        mem.write(0x1, UInt16(0xAEDA)) // dont try this tho cuz the address is not an even number
        XCTAssertEqual(mem.read(0x1), 0xDA, "Memory 16 bit value conversion test")
        XCTAssertEqual(mem.read(0x2), 0xAE, "Memory 16 bit value conversion test")
        
        XCTAssertEqual(mem[twoBytes: 0x0], 0xDAEA, "Memory 16 bit subscript read test")
        mem[twoBytes: 0x0] = 0xAEEA
        XCTAssertEqual(mem[twoBytes: 0x0], 0xAEEA, "Memory 16 bit subscript rw test")
    }
}
