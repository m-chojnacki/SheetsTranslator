//
//  main.swift
//  SheetsTranslator
//
//  Created by Marcin Chojnacki on 14/02/2025.
//

import PackagePlugin
import Foundation

@main
struct SheetsTranslatorBuildToolPlugin: BuildToolPlugin {
    func createBuildCommands(context: PluginContext, target: Target) throws -> [Command] {
        makeCommands(tool: try context.tool(named: "sheets"), pluginWorkDirectory: context.pluginWorkDirectory)
    }

    private func makeCommands(tool: PluginContext.Tool, pluginWorkDirectory: Path) -> [Command] {
        [
            .prebuildCommand(
                displayName: "Run SheetsTranslator",
                executable: tool.path,
                arguments: [],
                outputFilesDirectory: pluginWorkDirectory
            )
        ]
    }
}

#if canImport(XcodeProjectPlugin)

import XcodeProjectPlugin

extension SheetsTranslatorBuildToolPlugin: XcodeBuildToolPlugin {
    func createBuildCommands(context: XcodePluginContext, target: XcodeTarget) throws -> [Command] {
        makeCommands(tool: try context.tool(named: "sheets"), pluginWorkDirectory: context.pluginWorkDirectory)
    }
}

#endif
