//
//  main.swift
//  SheetsTranslator
//
//  Created by Marcin Chojnacki on 14/02/2025.
//

import PackagePlugin
import Foundation

@main
struct SheetsTranslatorCommandPlugin: CommandPlugin {
    func performCommand(context: PluginContext, arguments: [String]) throws {
        try runProcess(
            tool: try context.tool(named: "sheets"),
            pluginWorkDirectory: context.pluginWorkDirectory,
            arguments: arguments
        )
    }

    private func runProcess(tool: PluginContext.Tool, pluginWorkDirectory: Path, arguments: [String]) throws {
        print(pluginWorkDirectory.string)
        
        let process = Process()
        process.currentDirectoryURL = URL(fileURLWithPath: pluginWorkDirectory.string)
        process.executableURL = URL(fileURLWithPath: tool.path.string)
        process.arguments = arguments

        try process.run()
        process.waitUntilExit()
    }
}

#if canImport(XcodeProjectPlugin)

import XcodeProjectPlugin

extension SheetsTranslatorCommandPlugin: XcodeCommandPlugin {
    func performCommand(context: XcodePluginContext, arguments: [String]) throws {
        let resourcesDirectory = context.xcodeProject.directory
            .appending(context.xcodeProject.displayName)
            .appending("Resources")

        try runProcess(
            tool: try context.tool(named: "sheets"),
            pluginWorkDirectory: resourcesDirectory,
            arguments: arguments
        )
    }
}

#endif
