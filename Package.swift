// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Markdown",
    products: [
        .library(
            name: "Markdown",
            targets: ["Markdown"]
        )
    ],
    dependencies: [],
    targets: [
        .systemLibrary(name: "discount", pkgConfig: "libmarkdown", providers: [.apt(["libmarkdown2-dev"]), .brew(["discount"])]),
        .target(name: "Markdown", dependencies: ["discount"]),
        .testTarget(name: "MarkdownTests", dependencies: ["Markdown"])
    ]
)
