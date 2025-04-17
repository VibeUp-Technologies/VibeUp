// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Dashboard",
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
        .package(path: "Formatter")
    ],
    targets: [
        .target(
            name: "Dashboard",
            dependencies: [
                "DashboardTypes",
                "DesignSystem",
                "Formatter"
            ]
        ),
        .target(
            name: "DashboardTypes",
            dependencies: []
        )
    ]
)
