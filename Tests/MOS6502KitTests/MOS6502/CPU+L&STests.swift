@testable import MOS6502Kit
import XCTest

final class CPUL_STests: XCTestCase {
    func testLDA() {
        let mem = BasicMemory(memory: Data([ 0xa9, 0xEA, 0x00 ]))
        var cpu = MOS6502(memory: mem)

        cpu.step()
        XCTAssertEqual(cpu[.A], 0xEA, "LDA immediate test")
    }

    func testLDX() {
        let mem = BasicMemory(memory: Data([ 0xa2, 0xEA, 0x00 ]))
        var cpu = MOS6502(memory: mem)

        cpu.step()
        XCTAssertEqual(cpu[.X], 0xEA, "LDX immediate test")
    }

    func testLDY() {
        let mem = BasicMemory(memory: Data([ 0xa0, 0xEA, 0x00 ]))
        var cpu = MOS6502(memory: mem)

        cpu.step()
        XCTAssertEqual(cpu[.Y], 0xEA, "LDY immediate test")
    }

    func testSTA() {
        let mem = BasicMemory(memory: Data([ 0x85, 0x0, 0x00 ]))
        var cpu = MOS6502(memory: mem)

        cpu[.A] = 0xEA
        cpu.step()
        XCTAssertEqual(cpu.memory[0x0], 0xEA, "STA zero page test")
    }
    
    func testSTX() {
        let mem = BasicMemory(memory: Data([ 0x86, 0x0, 0x00 ]))
        var cpu = MOS6502(memory: mem)

        cpu[.X] = 0xEA
        cpu.step()
        XCTAssertEqual(cpu.memory[0x0], 0xEA, "STX zero page test")
    }

    func testSTY() {
        let mem = BasicMemory(memory: Data([ 0x84, 0x0, 0x00 ]))
        var cpu = MOS6502(memory: mem)

        cpu[.Y] = 0xEA
        cpu.step()
        XCTAssertEqual(cpu.memory[0x0], 0xEA, "STY zero page test")
    }
}
