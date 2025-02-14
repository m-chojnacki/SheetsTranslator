// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "SheetsTranslator",
    platforms: [
        .macOS(.v10_13)
    ],
    products: [
        .executable(name: "sheets", targets: ["sheets"]),
        .plugin(name: "SheetsTranslatorBuildToolPlugin", targets: ["SheetsTranslatorBuildToolPlugin"]),
        .plugin(name: "SheetsTranslatorCommandPlugin", targets: ["SheetsTranslatorCommandPlugin"])
    ],
    targets: [
        .executableTarget(
            name: "sheets",
            path: "SheetsTranslator"
        ),
        .binaryTarget(
            name: "SheetsTranslatorBinary",
            url: "https://github.com/m-chojnacki/SheetsTranslator/releases/download/0.5/SheetsTranslatorBinary.artifactbundle.zip",
            checksum: "d32d31a6cd9c98c20c9652637107f48385b7e3083fcd17f0ef5d15e1e9451ce4"
        ),
        .plugin(
            name: "SheetsTranslatorBuildToolPlugin",
            capability: .buildTool(),
            dependencies: [
                .target(name: "SheetsTranslatorBinary")
            ]
        ),
        .plugin(
            name: "SheetsTranslatorCommandPlugin",
            capability: .command(
                intent: .custom(verb: "sheets", description: "SheetsTranslator"),
                permissions: [
                    .allowNetworkConnections(scope: .all(ports: [80, 443]), reason: "Fetch the sheet"),
                    .writeToPackageDirectory(reason: "Save translations")
                ]
            ),
            dependencies: [
                .target(name: "SheetsTranslatorBinary")
            ]
        )
    ]
)
