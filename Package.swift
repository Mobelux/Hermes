// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Hermes",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(name: "Hermes", targets: ["Hermes"]),
        .library(name: "ActionCable", targets: ["ActionCable"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
         .package(url: "https://github.com/daltoniam/Starscream.git", from: "3.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(name: "Hermes", dependencies: ["Starscream"]),
        .target(name: "ActionCable", dependencies: ["Hermes"]),
        .testTarget(name: "HermesTests", dependencies: ["Hermes"]),
        .testTarget(name: "ActionCableTests", dependencies: ["ActionCable"])
    ]
)
