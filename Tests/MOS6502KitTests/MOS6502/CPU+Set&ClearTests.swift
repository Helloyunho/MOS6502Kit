@testable import MOS6502Kit
import XCTest

final class CPUSet_ClearTests: XCTestCase {
    func testSEC() {
        let mem = BasicMemory(memory: Data([0x38, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.C] = false
        cpu.step()
        XCTAssertTrue(cpu[.C], "SEC test")
    }

    func testCLC() {
        let mem = BasicMemory(memory: Data([0x18, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.C] = true
        cpu.step()
        XCTAssertFalse(cpu[.C], "CLC test")
    }

    func testSEI() {
        let mem = BasicMemory(memory: Data([0x78, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.I] = false
        cpu.step()
        XCTAssertTrue(cpu[.I], "SEI test")
    }

    func testCLI() {
        let mem = BasicMemory(memory: Data([0x58, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.I] = true
        cpu.step()
        XCTAssertFalse(cpu[.I], "CLI test")
    }

    func testSED() {
        let mem = BasicMemory(memory: Data([0xf8, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.D] = false
        cpu.step()
        XCTAssertTrue(cpu[.D], "SED test")
    }

    func testCLD() {
        let mem = BasicMemory(memory: Data([0xd8, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.D] = true
        cpu.step()
        XCTAssertFalse(cpu[.D], "CLD test")
    }

    func testCLV() {
        let mem = BasicMemory(memory: Data([0xb8, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.V] = true
        cpu.step()
        XCTAssertFalse(cpu[.V], "CLV test")
    }
}
