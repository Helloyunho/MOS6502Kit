@testable import MOS6502Kit
import XCTest

final class CPUSet_ClearTests: XCTestCase {
    func testSEC() async {
        let mem = BasicMemory(memory: Data([0x38, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.C] = false
        await cpu.step()
        XCTAssertTrue(cpu[.C], "SEC test")
    }

    func testCLC() async {
        let mem = BasicMemory(memory: Data([0x18, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.C] = true
        await cpu.step()
        XCTAssertFalse(cpu[.C], "CLC test")
    }

    func testSEI() async {
        let mem = BasicMemory(memory: Data([0x78, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.I] = false
        await cpu.step()
        XCTAssertTrue(cpu[.I], "SEI test")
    }

    func testCLI() async {
        let mem = BasicMemory(memory: Data([0x58, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.I] = true
        await cpu.step()
        XCTAssertFalse(cpu[.I], "CLI test")
    }

    func testSED() async {
        let mem = BasicMemory(memory: Data([0xf8, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.D] = false
        await cpu.step()
        XCTAssertTrue(cpu[.D], "SED test")
    }

    func testCLD() async {
        let mem = BasicMemory(memory: Data([0xd8, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.D] = true
        await cpu.step()
        XCTAssertFalse(cpu[.D], "CLD test")
    }

    func testCLV() async {
        let mem = BasicMemory(memory: Data([0xb8, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.V] = true
        await cpu.step()
        XCTAssertFalse(cpu[.V], "CLV test")
    }
}
