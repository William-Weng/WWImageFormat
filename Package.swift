// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WWImageFormat",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "WWImageFormat", targets: ["WWImageFormat"]),
    ],
    targets: [
        .target(name: "WWImageFormat", resources: [.copy("Privacy")]),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
