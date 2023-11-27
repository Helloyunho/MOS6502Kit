@testable import MOS6502Kit
import XCTest

final class CPUStackTests: XCTestCase {
    func testPHA() {
        let mem = BasicMemory(memory: Data([0x48, 0x00]) + Data(count: 0x200))
        var cpu = MOS6502(memory: mem)

        cpu[.A] = 0x01
        cpu.step()
        XCTAssertEqual(cpu.popStack(), 0x01, "PHA test")
    }

    func testPHP() {
        let mem = BasicMemory(memory: Data([0x08, 0x00]) + Data(count: 0x200))
        var cpu = MOS6502(memory: mem)

        cpu[.P] = 0x01
        cpu.step()
        XCTAssertEqual(cpu.popStack(), 0x01, "PHP test")
    }

    func testPLA() {
        let mem = BasicMemory(memory: Data([0x68, 0x00]) + Data(count: 0x200))
        var cpu = MOS6502(memory: mem)

        cpu.pushStack(0x01)
        cpu.step()
        XCTAssertEqual(cpu[.A], 0x01, "PLA test")
    }

    func testPLP() {
        let mem = BasicMemory(memory: Data([0x28, 0x00]) + Data(count: 0x200))
        var cpu = MOS6502(memory: mem)

        cpu.pushStack(0x01)
        cpu.step()
        XCTAssertEqual(cpu[.P], 0x01, "PLP test")
    }
}
