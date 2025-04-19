// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Dashboard",
    defaultLocalization: "uk",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "Dashboard",
            targets: ["Dashboard"]
        ),
        .library(
            name: "DashboardTypes",
            targets: ["Dashboard"]
        ),
    ],
    dependencies: [
        .package(path: "DesignSystem"),
        .package(path: "Formatter"),
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
            name: "Dashboard",
            dependencies: [
                "DashboardTypes",
                "DesignSystem",
                "Formatter",
                "FlowStacks",
                .product(name: "XCStringsToolPlugin", package: "xcstrings-tool-plugin")
            ],
            resources: [
                .process("Resources")
            ]
        ),
        .target(
            name: "DashboardTypes",
            dependencies: []
        )
    ]
)
