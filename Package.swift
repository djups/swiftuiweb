// swift-tools-version:5.6
import PackageDescription
let package = Package(
    name: "swiftuiweb",
    platforms: [.macOS(.v11), .iOS(.v13)],
    products: [
        .executable(name: "swiftuiweb", targets: ["swiftuiweb"])
    ],
    dependencies: [
        .package(url: "https://github.com/TokamakUI/Tokamak", from: "0.11.0")
    ],
    targets: [
        .executableTarget(
            name: "swiftuiweb",
            dependencies: [
                "swiftuiwebLibrary",
                .product(name: "TokamakShim", package: "Tokamak")
            ]),
        .target(
            name: "swiftuiwebLibrary",
            dependencies: []),
        .testTarget(
            name: "swiftuiwebLibraryTests",
            dependencies: ["swiftuiwebLibrary"]),
    ]
)
