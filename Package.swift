// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "swift-contexts",
    products: [
        .library(name: "Contexts", targets: ["Contexts"]),
    ],
    targets: [
        .target(name: "Contexts"),
        .testTarget(name: "ContextsTests", dependencies: ["Contexts"]),
    ]
)
