// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BackdoorPanel",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "BackdoorPanel",
            targets: ["BackdoorPanel"]
        ),
        .library(
            name: "BackdoorPanelTypes",
            targets: ["BackdoorPanel"]
        )
    ],
    dependencies: [
        .package(path: "DesignSystem"),
        .package(
            url: "https://github.com/johnpatrickmorgan/FlowStacks.git",
            .upToNextMajor(from: "0.8.3")
        )
    ],
    targets: [
        .target(
            name: "BackdoorPanel",
            dependencies: [
                "BackdoorPanelTypes",
                "DesignSystem",
                "FlowStacks"
            ]
        ),
        .target(
            name: "BackdoorPanelTypes",
            dependencies: []
        )
    ]
)
