// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "superwallkit_flutter",
    platforms: [
        .iOS("15.0")
    ],
    products: [
        .library(name: "superwallkit-flutter", targets: ["superwallkit_flutter"])
    ],
    dependencies: [
        // Our fork of SuperwallKit 4.19.1, which adds
        // StoreProduct.withPromotionalOffer. CocoaPods apps (anotarapp) pin the
        // same commit in their Podfile; this is the Swift Package Manager side.
        .package(url: "https://github.com/appm8ker/Superwall-iOS.git", revision: "39cd2216f1b09d938893965b8e6b644d1a8a5de4")
    ],
    targets: [
        .target(
            name: "superwallkit_flutter",
            dependencies: [
                .product(name: "SuperwallKit", package: "Superwall-iOS")
            ],
            // Promotional offers on direct purchases; CocoaPods apps set it on
            // the plugin target in their Podfile.
            swiftSettings: [.define("ANOTAR_PROMOTIONAL_OFFER")]
        )
    ]
)
