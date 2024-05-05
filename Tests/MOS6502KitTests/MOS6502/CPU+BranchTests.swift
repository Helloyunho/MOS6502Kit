@testable import MOS6502Kit
import XCTest

final class CPUBranchTests: XCTestCase {
    func testBCC() async {
        let mem = BasicMemory(memory: Data([0x90, 0x02, 0x00]))
        var cpu = MOS6502(memory: mem)
        cpu[.C] = false
        await cpu.step()
        XCTAssertEqual(cpu.PC, 0x03, "BCC test")
    }

    func testBCS() async {
        let mem = BasicMemory(memory: Data([0xb0, 0x02, 0x00]))
        var cpu = MOS6502(memory: mem)
        cpu[.C] = true
        await cpu.step()
        XCTAssertEqual(cpu.PC, 0x03, "BCS test")
    }

    func testBNE() async {
        let mem = BasicMemory(memory: Data([0xd0, 0x02, 0x00]))
        var cpu = MOS6502(memory: mem)
        cpu[.Z] = false
        await cpu.step()
        XCTAssertEqual(cpu.PC, 0x03, "BNE test")
    }

    func testBEQ() async {
        let mem = BasicMemory(memory: Data([0xf0, 0x02, 0x00]))
        var cpu = MOS6502(memory: mem)
        cpu[.Z] = true
        await cpu.step()
        XCTAssertEqual(cpu.PC, 0x03, "BEQ test")
    }

    func testBPL() async {
        let mem = BasicMemory(memory: Data([0x10, 0x02, 0x00]))
        var cpu = MOS6502(memory: mem)
        cpu[.N] = false
        await cpu.step()
        XCTAssertEqual(cpu.PC, 0x03, "BPL test")
    }

    func testBMI() async {
        let mem = BasicMemory(memory: Data([0x30, 0x02, 0x00]))
        var cpu = MOS6502(memory: mem)
        cpu[.N] = true
        await cpu.step()
        XCTAssertEqual(cpu.PC, 0x03, "BMI test")
    }

    func testBVC() async {
        let mem = BasicMemory(memory: Data([0x50, 0x02, 0x00]))
        var cpu = MOS6502(memory: mem)
        cpu[.V] = false
        await cpu.step()
        XCTAssertEqual(cpu.PC, 0x03, "BVC test")
    }

    func testBVS() async {
        let mem = BasicMemory(memory: Data([0x70, 0x02, 0x00]))
        var cpu = MOS6502(memory: mem)
        cpu[.V] = true
        await cpu.step()
        XCTAssertEqual(cpu.PC, 0x03, "BVS test")
    }
}
