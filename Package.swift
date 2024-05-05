// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MOS6502Kit",
//    platforms: [.iOS(.v16), .macOS(.v13), .macCatalyst(.v16), .watchOS(.v9), .tvOS(.v16), .visionOS(.v1)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "MOS6502Kit",
            targets: ["MOS6502Kit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Helloyunho/SwiftLintPlugin", .upToNextMajor(from: "0.53.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "MOS6502Kit",
            plugins: [
                .plugin(name: "SwiftLintPlugin", package: "SwiftLintPlugin"),
            ]
        ),
        .testTarget(
            name: "MOS6502KitTests",
            dependencies: ["MOS6502Kit"]),
    ])
