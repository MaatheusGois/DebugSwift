// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "DebugSwift",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "DebugSwift",
            targets: ["DebugSwift"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "DebugSwift",
            dependencies: [],
            path: "Sources"
        )
    ],
    swiftLanguageVersions: [.v5]
)