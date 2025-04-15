// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Formatter",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Formatter",
            targets: ["Formatter"]
        )
    ],
    targets: [
        .target(
            name: "Formatter"
        )
    ]
)
