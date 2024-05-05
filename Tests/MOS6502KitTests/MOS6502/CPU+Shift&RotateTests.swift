@testable import MOS6502Kit
import XCTest

final class CPUS_RTests: XCTestCase {
    func testASL() async {
        let mem = BasicMemory(memory: Data([0x0a, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.A] = 0x01
        await cpu.step()
        XCTAssertEqual(cpu[.A], 0x02, "ASL accumulator test")
    }

    func testLSR() async {
        let mem = BasicMemory(memory: Data([0x4a, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.A] = 0x01
        await cpu.step()
        XCTAssertEqual(cpu[.A], 0x00, "LSR accumulator test")
    }

    func testROL() async {
        let mem = BasicMemory(memory: Data([0x2a, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.A] = 0x01
        await cpu.step()
        XCTAssertEqual(cpu[.A], 0x02, "ROL accumulator test")
    }

    func testROR() async {
        let mem = BasicMemory(memory: Data([0x6a, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.A] = 0x01
        await cpu.step()
        XCTAssertEqual(cpu[.A], 0x80, "ROR accumulator test")
    }
}
