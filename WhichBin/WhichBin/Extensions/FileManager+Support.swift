//
//  FileManager+Support.swift
//  WhichBin
//
//  Created by Shane Whitehead on 19/4/2025.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        directory(for: .documentDirectory)
    }

    static var libraryDirectory: URL {
        directory(for: .libraryDirectory)
    }

    static var cachesDirectory: URL {
        directory(for: .cachesDirectory)
    }

    private static func directory(for path: FileManager.SearchPathDirectory) -> URL {
        let paths = FileManager.default.urls(for: path, in: .userDomainMask)
        return paths[0]
    }
}
