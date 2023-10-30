public enum Flags: UInt8 {
    // Flags Bit Order: NV_BDIZC
    // _(Underscore) means it's unused, and always be HIGH
    case N, V, `_`, B, D, I, Z, C // swiftlint:disable:this identifier_name
}

public enum FullNameFlags: UInt8 {
    // Exact same as ``Flags`` but with full names
    case negative, overflow, unused, `break`, decimal, interruptDisable, zero, carry
}
