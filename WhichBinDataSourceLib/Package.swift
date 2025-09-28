// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WhichBinDataSourceLib",
    platforms: [
        .macOS(.v14),
        .iOS(.v17),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "WhichBinDataSourceLib",
            targets: ["WhichBinDataSourceLib"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/RustyKnight/Cadmus", branch: "master"),
        .package(url: "https://github.com/RustyKnight/CoreExtensions", branch: "master"),
        .package(name: "WhichBinLib", path: "../WhichBinLib"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "WhichBinDataSourceLib",
            dependencies: [
                "Cadmus",
                "CoreExtensions",
                "WhichBinLib"
            ],
            resources: [
                .copy("Resources/MockedNewResponse.json"),
                .copy("Resources/MockedRestrictedResponse.json")
            ]
        ),
        .testTarget(
            name: "WhichBinDataSourceLibTests",
            dependencies: ["WhichBinDataSourceLib"],
            resources: [
                .copy("Resources/MockedResponse.json"),
                .copy("Resources/MockedNewResponse.json"),
                .copy("Resources/MockedRestrictedResponse.json"),
                .copy("Resources/MultiPolygonResponse.json"),
                .copy("Resources/SinglePolygonResponse.json")
            ]
        ),
    ]
)
