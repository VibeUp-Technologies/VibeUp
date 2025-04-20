// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Favorites",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "Favorites",
            targets: ["Favorites"]
        ),
        .library(
            name: "FavoriteTypes",
            targets: ["Favorites"]
        )
    ],
    dependencies: [
        .package(path: "DesignSystem"),
        .package(
            url: "https://github.com/johnpatrickmorgan/FlowStacks.git",
            from: "0.4.1"
        ),
        .package(
            url: "https://github.com/liamnichols/xcstrings-tool-plugin.git",
            from: "1.1.0"
        )
    ],
    targets: [
        .target(
            name: "Favorites",
            dependencies: [
                "FavoriteTypes",
                "DesignSystem",
                "FlowStacks",
                .product(name: "XCStringsToolPlugin", package: "xcstrings-tool-plugin")
            ],
            resources: [
                .process("Resources")
            ]
        ),
        .target(
            name: "FavoriteTypes",
            dependencies: []
        )
    ]
)
