// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "CallableKitHummingbirdTransport",
    platforms: [.macOS(.v14)],
    products: [
        .library(name: "CallableKitHummingbirdTransport", targets: ["CallableKitHummingbirdTransport"]),
    ],
    dependencies: [
        .package(url: "https://github.com/sidepelican/CallableKit.git", from: "2.0.0"),
        .package(url: "https://github.com/hummingbird-project/hummingbird.git", from: "2.5.0"),
    ],
    targets: [
        .target(
            name: "CallableKitHummingbirdTransport",
            dependencies: [
                .product(name: "CallableKit", package: "CallableKit"),
                .product(name: "Hummingbird", package: "hummingbird"),
            ]
        ),
        .testTarget(
            name: "CallableKitHummingbirdTransportTests",
            dependencies: [
                .product(name: "CallableKit", package: "CallableKit"),
                .product(name: "Hummingbird", package: "hummingbird"),
                .product(name: "HummingbirdTesting", package: "hummingbird"),
                "CallableKitHummingbirdTransport",
            ]
        ),
    ]
)
