@testable import MOS6502Kit
import XCTest

final class CPUTransferTests: XCTestCase {
    func testTAX() {
        let mem = BasicMemory(memory: Data([0xaa, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.A] = 0x01
        cpu.step()
        XCTAssertEqual(cpu[.X], 0x01, "TAX test")
    }

    func testTAY() {
        let mem = BasicMemory(memory: Data([0xa8, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.A] = 0x01
        cpu.step()
        XCTAssertEqual(cpu[.Y], 0x01, "TAY test")
    }

    func testTXA() {
        let mem = BasicMemory(memory: Data([0x8a, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.X] = 0x01
        cpu.step()
        XCTAssertEqual(cpu[.A], 0x01, "TXA test")
    }

    func testTYA() {
        let mem = BasicMemory(memory: Data([0x98, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.Y] = 0x01
        cpu.step()
        XCTAssertEqual(cpu[.A], 0x01, "TYA test")
    }

    func testTSX() {
        let mem = BasicMemory(memory: Data([0xba, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.S] = 0x01
        cpu.step()
        XCTAssertEqual(cpu[.X], 0x01, "TSX test")
    }

    func testTXS() {
        let mem = BasicMemory(memory: Data([0x9a, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.X] = 0x01
        cpu.step()
        XCTAssertEqual(cpu[.S], 0x01, "TXS test")
    }
}
