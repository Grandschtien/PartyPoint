//
//  Shell.swift
//  PartyPointManifests
//
//  Created by Егор Шкарин on 05.07.2024.
//

import Foundation

public enum Shell { }

public extension Shell {
    static func capture(_ command: [String]) -> String? {
        let task = Process()
        let pipe = Pipe()
        
        task.standardOutput = pipe
        task.standardError = nil
        task.arguments = ["-c", command.joined(separator: " ")]
        task.executableURL = URL(fileURLWithPath: "/bin/zsh")
        task.standardInput = nil
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        task.waitUntilExit()
        
        if task.terminationStatus != 0 {
            return nil
        }
        
        return String(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    static func capture(_ command: String...) -> String? {
        capture(Array(command))
    }
    
    static func numberOfCommits() -> Int? {
        capture("git", "rev-list", "HEAD", "--count").flatMap(Int.init)
    }
}
