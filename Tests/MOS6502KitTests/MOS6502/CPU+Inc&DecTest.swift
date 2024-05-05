@testable import MOS6502Kit
import XCTest

final class CPUIncDecTests: XCTestCase {
    func testINC() async {
        let mem = BasicMemory(memory: Data([0xee, 0x03, 0x00, 0x03]))
        var cpu = MOS6502(memory: mem)

        await cpu.step()
        XCTAssertEqual(cpu.memory[0x3], 0x04, "INC absolute test")
    }

    func testINX() async {
        let mem = BasicMemory(memory: Data([0xe8, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.X] = 0x01
        await cpu.step()
        XCTAssertEqual(cpu[.X], 0x02, "INX test")
    }

    func testINY() async {
        let mem = BasicMemory(memory: Data([0xc8, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.Y] = 0x01
        await cpu.step()
        XCTAssertEqual(cpu[.Y], 0x02, "INY test")
    }

    func testDEC() async {
        let mem = BasicMemory(memory: Data([0xce, 0x03, 0x00, 0x01]))
        var cpu = MOS6502(memory: mem)

        await cpu.step()
        XCTAssertEqual(cpu.memory[0x3], 0x00, "DEC absolute test")
    }

    func testDEX() async {
        let mem = BasicMemory(memory: Data([0xca, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.X] = 0x01
        await cpu.step()
        XCTAssertEqual(cpu[.X], 0x00, "DEX test")
    }

    func testDEY() async {
        let mem = BasicMemory(memory: Data([0x88, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.Y] = 0x01
        await cpu.step()
        XCTAssertEqual(cpu[.Y], 0x00, "DEY test")
    }
}
