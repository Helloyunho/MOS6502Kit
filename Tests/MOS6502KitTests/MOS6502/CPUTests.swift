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
        var cpu = MOS6502(memory: mem)
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
        var cpu = MOS6502(memory: mem)

        XCTAssertEqual(cpu.registers[.A], 0, "Initial CPU register test")
        cpu[.A] = 0xEA
        XCTAssertEqual(cpu[.A], 0xEA, "CPU register IO test")
    }
    
    func testGetAddress() {
        let mem = BasicMemory(memory: Data([
            0x2, 0x0, 0x4, 0x0, 0xEA, 0xAE, 0xCA, 0xFE
        ]))
        var cpu = MOS6502(memory: mem)
        
        XCTAssertEqual(cpu.getAddress(.immediate), 0x0, "Immediate addressing mode test")
        XCTAssertEqual(cpu.getAddress(.absolute), 0x2, "Absolute addressing mode test")
        XCTAssertEqual(cpu.getAddress(.zeroPage), 0x2, "Zero page addressing mode test")
        cpu.PC = 0x2
        XCTAssertEqual(cpu.getAddress(.relative), 0x6, "Relative addressing mode test")
        XCTAssertEqual(cpu.getAddress(.absoluteIndirect), 0x4, "Absolute indirect addressing mode test")
        cpu.PC = 0x4
        cpu[.X] = 0x4
        cpu[.Y] = 0x2
        XCTAssertEqual(cpu.getAddress(.absoluteIndexedX), 0xAEEE, "Absolute indexed with X addressing mode test")
        XCTAssertEqual(cpu.getAddress(.absoluteIndexedY), 0xAEEC, "Absolute indexed with Y addressing mode test")
        XCTAssertEqual(cpu.getAddress(.zeroPageIndexedX), 0xEE, "Zero page indexed with X addressing mode test")
        XCTAssertEqual(cpu.getAddress(.zeroPageIndexedY), 0xEC, "Zero page indexed with Y addressing mode test")
        cpu.PC = 0x0
        XCTAssertEqual(cpu.getAddress(.zeroPageIndexedIndirectX), 0xFECA, "Zero page indirect indexed with X addressing mode test")
        XCTAssertEqual(cpu.getAddress(.zeroPageIndexedIndirectY), 0x6, "Zero page indirect indexed with Y addressing mode test")
    }
}
