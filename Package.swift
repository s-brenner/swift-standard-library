// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "swift-standard-library",
    products: [
        .library(name: "SBStandardLibrary", targets: ["SBStandardLibrary"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-identified-collections", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "SBStandardLibrary",
            dependencies: [
                .product(name: "IdentifiedCollections", package: "swift-identified-collections"),
            ]
        ),
        .testTarget(
            name: "SBStandardLibraryTests",
            dependencies: [
                "SBStandardLibrary",
            ]
        ),
    ]
)
