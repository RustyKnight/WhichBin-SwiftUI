//
//  SiteManager.swift
//  WhichBin
//
//  Created by Shane Whitehead on 18/4/2025.
//

import SwiftUI
import CoreExtensions

class SiteManager: ObservableObject {

    enum State {
        case initial
        case loaded
        case error(Error)
    }

    @Published
    private(set) var sites: Set<Site> = []

    @Published
    private(set) var state: State = .initial

    init() {
        do {
            try load()
            state = .loaded
        } catch {
            state = .error(error)
        }
    }

    init(sites: Set<Site>) {
        self.sites = sites
        state = .loaded
    }

    func add(site: Site) throws {
        sites.insert(site)
        try save()
    }

    func remove(site: Site) throws {
        sites.remove(site)
        try save()
    }

    private func load() throws {
        let url = FileManager.libraryDirectory
            .appendingPathComponent("Sites.json")
        guard FileManager.default.fileExists(atPath: url) else { return }
        let data = try Data(contentsOf: url)
        let values = try JSONDecoder().decode([Site].self, from: data)
        sites = Set(values)
    }

    private func save() throws {
        let url = FileManager.libraryDirectory
            .appendingPathComponent("Sites.json")
        let data = try JSONEncoder().encode(Array(sites))
        try data.write(to: url)
    }
}
