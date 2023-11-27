@testable import MOS6502Kit
import XCTest

final class CPUIncDecTests: XCTestCase {
    func testINC() {
        let mem = BasicMemory(memory: Data([0xee, 0x03, 0x00, 0x03]))
        var cpu = MOS6502(memory: mem)

        cpu.step()
        XCTAssertEqual(cpu.memory[0x3], 0x04, "INC absolute test")
    }

    func testINX() {
        let mem = BasicMemory(memory: Data([0xe8, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.X] = 0x01
        cpu.step()
        XCTAssertEqual(cpu[.X], 0x02, "INX test")
    }

    func testINY() {
        let mem = BasicMemory(memory: Data([0xc8, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.Y] = 0x01
        cpu.step()
        XCTAssertEqual(cpu[.Y], 0x02, "INY test")
    }

    func testDEC() {
        let mem = BasicMemory(memory: Data([0xce, 0x03, 0x00, 0x01]))
        var cpu = MOS6502(memory: mem)

        cpu.step()
        XCTAssertEqual(cpu.memory[0x3], 0x00, "DEC absolute test")
    }

    func testDEX() {
        let mem = BasicMemory(memory: Data([0xca, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.X] = 0x01
        cpu.step()
        XCTAssertEqual(cpu[.X], 0x00, "DEX test")
    }

    func testDEY() {
        let mem = BasicMemory(memory: Data([0x88, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.Y] = 0x01
        cpu.step()
        XCTAssertEqual(cpu[.Y], 0x00, "DEY test")
    }
}
