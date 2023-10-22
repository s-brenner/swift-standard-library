// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "swift-standard-library",
    products: [
        .library(name: "SBStandardLibrary", targets: ["SBStandardLibrary"]),
    ],
    targets: [
        .target(name: "SBStandardLibrary"),
        .testTarget(name: "SBStandardLibraryTests", dependencies: ["SBStandardLibrary"]),
    ]
)
