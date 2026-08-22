// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "swift-standard-library",
    products: [
        .library(name: "SBStandardLibrary", targets: ["SBStandardLibrary"]),
    ],
    traits: [
        .trait(name: "Algorithms", description: "Import the Algorithms library"),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-algorithms", from: "1.0.0"),
        .package(url: "https://github.com/pointfreeco/swift-identified-collections", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "SBStandardLibrary",
            dependencies: [
                .product(
                    name: "Algorithms",
                    package: "swift-algorithms",
                    condition: .when(traits: ["Algorithms"])
                ),
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
