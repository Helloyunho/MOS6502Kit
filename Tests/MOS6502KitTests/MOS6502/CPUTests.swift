import XCTest
@testable import MOS6502Kit

final class CPUTests: XCTestCase {
    func testCPUInitialization() {
        let mem = BasicMemory()
        let cpu = MOS6502(memory: mem)
        XCTAssertEqual(cpu.status, 0b0010_0000, "Initial CPU status test")
        
        // MARK: Registers test
        
        XCTAssertEqual(cpu.registers[.A], 0, "Initial CPU register test")
        XCTAssertEqual(cpu[.X], 0, "Initial CPU register test")
        XCTAssertEqual(cpu.registers[.Y], 0, "Initial CPU register test")
        XCTAssertEqual(cpu[.S], 0, "Initial CPU register test")
        XCTAssertEqual(cpu.registers[.P], cpu.status, "Initial CPU register test")
    }
    
    func testCPUFlagIO() {
        let mem = BasicMemory()
        let cpu = MOS6502(memory: mem)
        XCTAssertEqual(cpu.status, 0b0010_0000, "Initial CPU status test")
        
        XCTAssertEqual(cpu.getFlag(._), true, "Initial CPU flag test")
        XCTAssertEqual(cpu.getFlag(.Z), false, "Initial CPU flag test")
        
        cpu.setFlag(.Z, to: true)
        cpu.setFlag(.V)
        XCTAssertEqual(cpu.getFlag(.Z), true, "Updated CPU flag test")
        XCTAssertEqual(cpu.getFlag(.V), true, "Updated CPU flag test")
        cpu.setFlag(.Z, to: false)
        XCTAssertEqual(cpu.status, 0b0110_0000)
    }
    
    func testCPURegisterIO() {
        let mem = BasicMemory()
        let cpu = MOS6502(memory: mem)

        XCTAssertEqual(cpu.registers[.A], 0, "Initial CPU register test")
        cpu[.A] = 0xEA
        XCTAssertEqual(cpu[.A], 0xEA, "CPU register IO test")
    }
}
