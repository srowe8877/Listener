//
//  ArrayExtensions.swift
//  Listener
//
//  Created by Stephen Rowe on 12/10/24.
//

//


import Foundation




typealias Byte = UInt8
typealias ByteArray = [Byte]

extension Data {
    var bytes: ByteArray {
        var byteArray = ByteArray(repeating: 0, count: self.count)
        self.copyBytes(to: &byteArray, count: self.count )
        return byteArray
    }
}

extension Character {
    public var isPrintable: Bool {
        if let v = self.asciiValue {
            if v >= 0x20 && v <= 0x7e {
                return true
            }
        }
        return false
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

struct IncludeOptions: OptionSet {
    let rawValue: UInt8
    static let offset = IncludeOptions(rawValue: 1 << 0)
    static let printableCharacters = IncludeOptions(rawValue: 1 << 1)
    static let midChunkGap = IncludeOptions(rawValue: 1 << 2)
}

struct HexDumpConfig {
    var bytesPerLine: Int
    var uppercased: Bool
    var includeOptions: IncludeOptions
    var indent: Int
    
    static let defaultConfig  = HexDumpConfig(bytesPerLine: 16, uppercased: true, includeOptions: [.offset, .printableCharacters, .midChunkGap], indent: 0)
}




public struct SourceDumpConfig {
    var bytesPerLine: Int
    var uppercased: Bool
    var variableName: String
    var typeName: String
    var indent: Int
    
    public static let defaultConfig = SourceDumpConfig(
        bytesPerLine: 8,
        uppercased: true,
        variableName: "data",
        typeName: "[UInt8]",
        indent: 4)
    
}

extension ByteArray {
    
    func hexDump(config: HexDumpConfig = .defaultConfig) -> String {
        
        var lines = [String]()
        let chunks = self.chunked(into: config.bytesPerLine)
        
        var offset = 0
        let hexModifier = config.uppercased ? "X" : "x"
        let midChunkIndex = config.bytesPerLine / 2
        
        
        for chunk in chunks {
            var printableCharacters = ""
            var line = String(repeating: " ", count: config.indent)
            if config.includeOptions.contains(.offset) {
                line += String(format: "%08\(hexModifier)", offset)
                line += ": "
            }
            
            for (index, byte) in chunk.enumerated() {
                line += String(format: "%02X", byte)
                line += " "
                if index + 1 == midChunkIndex{
                    if config.includeOptions.contains(.midChunkGap){
                        line += " "
                    }
                }
                let ch = Character(Unicode.Scalar(byte))
                printableCharacters += ch.isPrintable ? String(ch) : "."
            }
            var bytesLeft = config.bytesPerLine - chunk.count
            while bytesLeft >= 0 {
                line += "   "
                printableCharacters += " "
                bytesLeft -= 1
            }
            if config.includeOptions.contains(.printableCharacters) {
                line += " "
                line += printableCharacters
            }
            lines.append(line)
            offset += config.bytesPerLine
        }
        return lines.joined(separator: "\n")
    }
}



extension ByteArray {
    public func sourceDump( config: SourceDumpConfig = .defaultConfig) -> String {
        var lines = [String]()
        
        lines.append("let \(config.variableName): \(config.typeName) = [")
        let chunks = self.chunked(into: config.bytesPerLine)
        let hexModifier = config.uppercased ? "X" : "x"
        for chunk in chunks {
            var line = String(repeating: " ", count: config.indent)
            for byte in chunk {
                line += "0x" + String(format: "%02\(hexModifier)", byte)
                line += ", "
            }
            line.removeLast()
            lines.append(line)
            
            
        }
        lines.append("]")
        return lines.joined(separator: " ")
    }
}

