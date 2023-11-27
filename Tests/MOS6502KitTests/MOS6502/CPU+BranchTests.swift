@testable import MOS6502Kit
import XCTest

final class CPUBranchTests: XCTestCase {
    func testBCC() {
        let mem = BasicMemory(memory: Data([0x90, 0x02, 0x00]))
        var cpu = MOS6502(memory: mem)
        cpu[.C] = false
        cpu.step()
        XCTAssertEqual(cpu.PC, 0x03, "BCC test")
    }

    func testBCS() {
        let mem = BasicMemory(memory: Data([0xb0, 0x02, 0x00]))
        var cpu = MOS6502(memory: mem)
        cpu[.C] = true
        cpu.step()
        XCTAssertEqual(cpu.PC, 0x03, "BCS test")
    }

    func testBNE() {
        let mem = BasicMemory(memory: Data([0xd0, 0x02, 0x00]))
        var cpu = MOS6502(memory: mem)
        cpu[.Z] = false
        cpu.step()
        XCTAssertEqual(cpu.PC, 0x03, "BNE test")
    }

    func testBEQ() {
        let mem = BasicMemory(memory: Data([0xf0, 0x02, 0x00]))
        var cpu = MOS6502(memory: mem)
        cpu[.Z] = true
        cpu.step()
        XCTAssertEqual(cpu.PC, 0x03, "BEQ test")
    }

    func testBPL() {
        let mem = BasicMemory(memory: Data([0x10, 0x02, 0x00]))
        var cpu = MOS6502(memory: mem)
        cpu[.N] = false
        cpu.step()
        XCTAssertEqual(cpu.PC, 0x03, "BPL test")
    }

    func testBMI() {
        let mem = BasicMemory(memory: Data([0x30, 0x02, 0x00]))
        var cpu = MOS6502(memory: mem)
        cpu[.N] = true
        cpu.step()
        XCTAssertEqual(cpu.PC, 0x03, "BMI test")
    }

    func testBVC() {
        let mem = BasicMemory(memory: Data([0x50, 0x02, 0x00]))
        var cpu = MOS6502(memory: mem)
        cpu[.V] = false
        cpu.step()
        XCTAssertEqual(cpu.PC, 0x03, "BVC test")
    }

    func testBVS() {
        let mem = BasicMemory(memory: Data([0x70, 0x02, 0x00]))
        var cpu = MOS6502(memory: mem)
        cpu[.V] = true
        cpu.step()
        XCTAssertEqual(cpu.PC, 0x03, "BVS test")
    }
}
