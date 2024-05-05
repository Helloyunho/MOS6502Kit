@testable import MOS6502Kit
import XCTest

final class CPULogicTests: XCTestCase {
    func testAND() async {
        let mem = BasicMemory(memory: Data([0x29, 0x01, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.A] = 0x01
        await cpu.step()
        XCTAssertEqual(cpu[.A], 0x01, "AND immediate test")
    }

    func testEOR() async {
        let mem = BasicMemory(memory: Data([0x49, 0x01, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.A] = 0x01
        await cpu.step()
        XCTAssertEqual(cpu[.A], 0x00, "EOR immediate test")
    }

    func testORA() async {
        let mem = BasicMemory(memory: Data([0x09, 0x01, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.A] = 0x01
        await cpu.step()
        XCTAssertEqual(cpu[.A], 0x01, "ORA immediate test")
    }
}
