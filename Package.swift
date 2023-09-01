// swift-tools-version:5.8

import PackageDescription

let package = Package(
    name: "VideoPlayerContainer",
    platforms: [
        .iOS(.v15),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "VideoPlayerContainer",
            targets: [
                "VideoPlayerContainer"
            ]
        )
    ],
    targets: [
        .target(
            name: "VideoPlayerContainer",
            path: "Source"
        )
    ],
    swiftLanguageVersions: [.v5]
)
