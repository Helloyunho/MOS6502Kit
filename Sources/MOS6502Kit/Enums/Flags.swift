public enum Flags: UInt8 {
    // Flags Bit Order: NV_BDIZC
    // _(Underscore) means it's unused, and always be HIGH
    case N, V, `_`, B, D, I, Z, C
}
