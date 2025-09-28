// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WhichBinLib",
    platforms: [
        .macOS(.v14),
        .iOS(.v17),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "WhichBinLib",
            targets: ["WhichBinLib"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/RustyKnight/Cadmus", branch: "master"),
        .package(url: "https://github.com/RustyKnight/CoreExtensions", branch: "master"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "WhichBinLib",
            dependencies: [
                "Cadmus",
                "CoreExtensions"
            ]
        ),
        .testTarget(
            name: "WhichBinLibTests",
            dependencies: ["WhichBinLib"]
        ),
    ]
)
