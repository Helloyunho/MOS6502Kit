//
//  File.swift
//  
//
//  Created by Helloyunho on 5/6/24.
//

import Foundation

public extension MOS6502 {
    static let cycleLists: [UInt8: (Int, Bool, AddressingMode)] = [
        0xAD: (4, false, .absolute),
        0xBD: (4, true, .absoluteIndexedX),
        0xB9: (4, true, .absoluteIndexedY),
        0xA9: (2, false, .immediate),
        0xA5: (3, false, .zeroPage),
        0xA1: (6, false, .zeroPageIndexedIndirectX),
        0xB5: (4, false, .zeroPageIndexedX),
        0xB1: (5, true, .zeroPageIndexedIndirectY),
        0xAE: (4, false, .absolute),
        0xBE: (4, true, .absoluteIndexedY),
        0xA2: (2, false, .immediate),
        0xA6: (3, false, .zeroPage),
        0xB6: (4, false, .zeroPageIndexedY),
        0xAC: (4, false, .absolute),
        0xBC: (4, true, .absoluteIndexedX),
        0xA0: (2, false, .immediate),
        0xA4: (3, false, .zeroPage),
        0xB4: (4, false, .zeroPageIndexedX),
        0x8D: (4, false, .absolute),
        0x9D: (5, false, .absoluteIndexedX),
        0x99: (5, true, .absoluteIndexedY),
        0x85: (3, false, .zeroPage),
        0x81: (6, false, .zeroPageIndexedIndirectX),
        0x95: (4, false, .zeroPageIndexedX),
        0x91: (5, true, .zeroPageIndexedIndirectY),
        0x8E: (4, false, .absolute),
        0x86: (3, false, .zeroPage),
        0x96: (4, false, .zeroPageIndexedY),
        0x8C: (4, false, .absolute),
        0x84: (3, false, .zeroPage),
        0x94: (4, false, .zeroPageIndexedX),
        0x6D: (4, false, .absolute),
        0x7D: (4, true, .absoluteIndexedX),
        0x79: (4, true, .absoluteIndexedY),
        0x69: (2, false, .immediate),
        0x65: (3, false, .zeroPage),
        0x61: (6, false, .zeroPageIndexedIndirectX),
        0x75: (4, false, .zeroPageIndexedX),
        0x71: (5, true, .zeroPageIndexedIndirectY),
        0xED: (4, false, .absolute),
        0xFD: (4, true, .absoluteIndexedX),
        0xF9: (4, true, .absoluteIndexedY),
        0xE9: (2, false, .immediate),
        0xE5: (3, false, .zeroPage),
        0xE1: (6, false, .zeroPageIndexedIndirectX),
        0xF5: (4, false, .zeroPageIndexedX),
        0xF1: (5, true, .zeroPageIndexedIndirectY),
        0xEE: (6, false, .absolute),
        0xFE: (7, true, .absoluteIndexedX),
        0xE6: (5, false, .zeroPage),
        0xF6: (6, false, .zeroPageIndexedX),
        0xE8: (2, false, .immediate),
        0xC8: (2, false, .immediate),
        0xCE: (6, false, .zeroPage),
        0xDE: (7, true, .zeroPageIndexedX),
        0xC6: (5, false, .zeroPage),
        0xD6: (6, false, .zeroPageIndexedX),
        0xCA: (2, false, .immediate),
        0x88: (2, false, .immediate),
        0x0A: (2, false, .immediate),
        0x0E: (6, false, .zeroPage),
        0x1E: (7, true, .zeroPageIndexedX),
        0x06: (5, false, .zeroPage),
        0x16: (6, false, .zeroPageIndexedX),
        0x4A: (2, false, .immediate),
        0x4E: (6, false, .zeroPage),
        0x5E: (7, true, .zeroPageIndexedX),
        0x46: (5, false, .zeroPage),
        0x56: (6, false, .zeroPageIndexedX),
        0x2A: (2, false, .immediate),
        0x2E: (6, false, .zeroPage),
        0x3E: (7, true, .zeroPageIndexedX),
        0x26: (5, false, .zeroPage),
        0x36: (6, false, .zeroPageIndexedX),
        0x6A: (2, false, .immediate),
        0x6E: (6, false, .zeroPage),
        0x7E: (7, true, .zeroPageIndexedX),
        0x66: (5, false, .zeroPage),
        0x76: (6, false, .zeroPageIndexedX),
        0x2D: (4, false, .absolute),
        0x3D: (4, true, .absoluteIndexedX),
        0x39: (4, true, .absoluteIndexedY),
        0x29: (2, false, .immediate),
        0x25: (3, false, .zeroPage),
        0x21: (6, false, .zeroPageIndexedIndirectX),
        0x35: (4, false, .zeroPageIndexedX),
        0x31: (5, true, .zeroPageIndexedIndirectY),
        0x0D: (4, false, .absolute),
        0x1D: (4, true, .absoluteIndexedX),
        0x19: (4, true, .absoluteIndexedY),
        0x09: (2, false, .immediate),
        0x05: (3, false, .zeroPage),
        0x01: (6, false, .zeroPageIndexedIndirectX),
        0x15: (4, false, .zeroPageIndexedX),
        0x11: (5, true, .zeroPageIndexedIndirectY),
        0x4D: (4, false, .absolute),
        0x5D: (4, true, .absoluteIndexedX),
        0x59: (4, true, .absoluteIndexedY),
        0x49: (2, false, .immediate),
        0x45: (3, false, .zeroPage),
        0x41: (6, false, .zeroPageIndexedIndirectX),
        0x55: (4, false, .zeroPageIndexedX),
        0x51: (5, true, .zeroPageIndexedIndirectY),
        0xCD: (4, false, .absolute),
        0xDD: (4, true, .absoluteIndexedX),
        0xD9: (4, true, .absoluteIndexedY),
        0xC9: (2, false, .immediate),
        0xC5: (3, false, .zeroPage),
        0xC1: (6, false, .zeroPageIndexedIndirectX),
        0xD5: (4, false, .zeroPageIndexedX),
        0xD1: (5, true, .zeroPageIndexedIndirectY),
        0xEC: (4, false, .absolute),
        0xE0: (2, false, .immediate),
        0xE4: (3, false, .zeroPage),
        0xCC: (4, false, .absolute),
        0xC0: (2, false, .immediate),
        0xC4: (3, false, .zeroPage),
        0x24: (3, false, .zeroPage),
        0x2C: (4, false, .absolute),
        0x89: (2, false, .immediate),
        0x90: (2, true, .relative),
        0xB0: (2, true, .relative),
        0xD0: (2, true, .relative),
        0xF0: (2, true, .relative),
        0x10: (2, true, .relative),
        0x30: (2, true, .relative),
        0x50: (2, true, .relative),
        0x70: (2, true, .relative),
        0x4C: (3, false, .absolute),
        0x6C: (5, false, .absoluteIndirect),
        0x20: (6, false, .absolute),
        0x60: (6, false, .implied),
        0x40: (6, false, .implied),
        0x18: (2, false, .implied),
        0x38: (2, false, .implied),
        0x58: (2, false, .implied),
        0x78: (2, false, .implied),
        0xB8: (2, false, .implied),
        0xD8: (2, false, .implied),
        0xF8: (2, false, .implied),
        0x48: (3, false, .implied),
        0x68: (4, false, .implied),
        0x08: (3, false, .implied),
        0x28: (4, false, .implied),
        0xAA: (2, false, .implied),
        0x8A: (2, false, .implied),
        0xA8: (2, false, .implied),
        0x98: (2, false, .implied),
        0xBA: (2, false, .implied),
        0x9A: (2, false, .implied),
        0xEA: (2, false, .implied),
        0x00: (7, false, .implied)
    ]
}
