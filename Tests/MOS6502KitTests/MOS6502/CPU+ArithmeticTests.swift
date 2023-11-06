@testable import MOS6502Kit
import XCTest

final class CPUArithmeticTests: XCTestCase {
    func testADC() {
        let mem = BasicMemory(memory: Data([0x69, 0x01, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.A] = 0x01
        cpu.step()
        XCTAssertEqual(cpu[.A], 0x02, "ADC immediate test")
    }

    func testSBC() {
        let mem = BasicMemory(memory: Data([0xe9, 0x01, 0x00]))
        var cpu = MOS6502(memory: mem)

        cpu[.A] = 0x01
        cpu[.C] = true
        cpu.step()
        XCTAssertEqual(cpu[.A], 0x00, "SBC immediate test")
    }
}
