// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TrueMasonaryStack",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "TrueMasonaryStack",targets: ["TrueMasonaryStack"]),
    ],
    targets: [
        .target(name: "TrueMasonaryStack"),
        .testTarget(name: "TrueMasonaryStackTests",dependencies: ["TrueMasonaryStack"]),
    ]
)
