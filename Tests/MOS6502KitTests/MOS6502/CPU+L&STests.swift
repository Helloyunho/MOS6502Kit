@testable import MOS6502Kit
import XCTest

final class CPUL_STests: XCTestCase {
    func testLDA() async {
        let mem = BasicMemory(memory: Data([0xa9, 0xea, 0x00]))
        var cpu = MOS6502(memory: mem)

        await cpu.step()
        XCTAssertEqual(cpu[.A], 0xea, "LDA immediate test")
    }

    func testLDX() async {
        let mem = BasicMemory(memory: Data([0xa2, 0xea, 0x00]))
        var cpu = MOS6502(memory: mem)

        await cpu.step()
        XCTAssertEqual(cpu[.X], 0xea, "LDX immediate test")
    }

    func testLDY() async {
        let mem = BasicMemory(memory: Data([0xa0, 0xea, 0x00]))
        var cpu = MOS6502(memory: mem)

        await cpu.step()
        XCTAssertEqual(cpu[.Y], 0xea, "LDY immediate test")
    }

    func testSTA() async {
        let mem = BasicMemory(memory: Data([0x85, 0x0, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.A] = 0xea
        await cpu.step()
        XCTAssertEqual(cpu.memory[0x0], 0xea, "STA zero page test")
    }

    func testSTX() async {
        let mem = BasicMemory(memory: Data([0x86, 0x0, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.X] = 0xea
        await cpu.step()
        XCTAssertEqual(cpu.memory[0x0], 0xea, "STX zero page test")
    }

    func testSTY() async {
        let mem = BasicMemory(memory: Data([0x84, 0x0, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.Y] = 0xea
        await cpu.step()
        XCTAssertEqual(cpu.memory[0x0], 0xea, "STY zero page test")
    }
}
