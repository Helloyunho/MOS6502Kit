@testable import MOS6502Kit
import XCTest

final class CPUSubroutineTests: XCTestCase {
    func testJMP() {
        let mem = BasicMemory(memory: Data([0x4c, 0x00, 0x00]) + Data(count: 0x200))
        var cpu = MOS6502(memory: mem)

        cpu.step()
        XCTAssertEqual(cpu.PC, 0x0000, "JMP test")
    }

    func testJSR() {
        let mem = BasicMemory(memory: Data([0x20, 0x00, 0x00]) + Data(count: 0x200))
        var cpu = MOS6502(memory: mem)

        cpu.step()
        XCTAssertEqual(cpu.PC, 0x0000, "JSR test")
    }

    func testRTS() {
        let mem = BasicMemory(memory: Data([0x60, 0x00]) + Data(count: 0x200))
        var cpu = MOS6502(memory: mem)

        cpu.pushStack(0x0)
        cpu.pushStack(0x0)

        cpu.step()
        XCTAssertEqual(cpu.PC, 0x0001, "RTS test")
    }

    func testRTI() {
        let mem = BasicMemory(memory: Data([0x40, 0x00]) + Data(count: 0x200))
        var cpu = MOS6502(memory: mem)

        cpu.pushStack(0x0)
        cpu.pushStack(0x0)
        cpu.pushStack(0x0)

        cpu.step()
        XCTAssertEqual(cpu.PC, 0x0000, "RTI test")
    }
}
