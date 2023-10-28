// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MOS6502Kit",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "MOS6502Kit",
            targets: ["MOS6502Kit"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "MOS6502Kit"),
        .testTarget(
            name: "MOS6502KitTests",
            dependencies: ["MOS6502Kit"]),
    ]
)
