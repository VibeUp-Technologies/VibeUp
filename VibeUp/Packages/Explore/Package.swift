// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Explore",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "Explore",
            targets: ["Explore"]
        )
    ],
    dependencies: [
        .package(path: "DesignSystem"),
        .package(
            url: "https://github.com/johnpatrickmorgan/FlowStacks.git",
            from: "0.4.1"
        )
    ],
    targets: [
        .target(
            name: "Explore",
            dependencies: [
                "DesignSystem",
                "FlowStacks"
            ]
        )
    ]
)
