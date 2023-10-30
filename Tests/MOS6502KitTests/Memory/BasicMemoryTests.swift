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
}
