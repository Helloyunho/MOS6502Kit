@testable import MOS6502Kit
import XCTest

final class CPUCmp_TestTests: XCTestCase {
    func testCMP() async {
        let mem = BasicMemory(memory: Data([0xc9, 0x01, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.A] = 0x01
        await cpu.step()
        XCTAssertEqual(cpu[.A], 0x01, "CMP immediate test")
    }

    func testCPX() async {
        let mem = BasicMemory(memory: Data([0xe0, 0x01, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.X] = 0x01
        await cpu.step()
        XCTAssertEqual(cpu[.X], 0x01, "CPX immediate test")
    }

    func testCPY() async {
        let mem = BasicMemory(memory: Data([0xc0, 0x01, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.Y] = 0x01
        await cpu.step()
        XCTAssertEqual(cpu[.Y], 0x01, "CPY immediate test")
    }

    func testBIT() async {
        let mem = BasicMemory(memory: Data([0x24, 0x01, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.A] = 0x01
        await cpu.step()
        XCTAssertEqual(cpu[.A], 0x01, "BIT zero page test")
    }
}
