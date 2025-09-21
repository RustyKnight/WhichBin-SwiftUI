//
//  SiteManager.swift
//  WhichBin
//
//  Created by Shane Whitehead on 18/4/2025.
//

import SwiftUI
import CoreExtensions

class SiteManager: ObservableObject {
    
    enum Error: Swift.Error {
        case storeInaccessible
    }
    
    enum State {
        case initial
        case loaded
        case error(Swift.Error)
    }
    
    static let shared = SiteManager()

    @Published
    private(set) var sites: Set<Site> = []

    @Published
    private(set) var state: State = .initial
    
    var isLoaded: Bool {
        switch state {
        case .loaded:
            return true
        default:
            return false
        }
    }
    
    var loadError: Swift.Error? {
        switch state {
        case .error(let error):
            error
        default:
            nil
        }
    }

    private init() {
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
    
    func remove(siteWithId id: UUID) throws {
        guard sites.remove(siteWithId: id) else { return }
        try save()
    }
    
    private func store() throws -> URL {
        guard let url = Support.sharedFolder else {
            throw Error.storeInaccessible
        }
        return url.appendingPathComponent("Sites.json")
    }

    private func load() throws {
        let url = try store()
//        FileManager.libraryDirectory
//            .appendingPathComponent("Sites.json")
        guard FileManager.default.fileExists(atPath: url) else { return }
        let data = try Data(contentsOf: url)
        let values = try JSONDecoder().decode([Site].self, from: data)
        sites = Set(values)
    }

    private func save() throws {
        let url = try store()
//        FileManager.libraryDirectory
//            .appendingPathComponent("Sites.json")
        let data = try JSONEncoder().encode(Array(sites))
        try data.write(to: url)
    }
}

extension SiteManager {
    
    func delete(_ indexSet: IndexSet) throws {
        var temp = Array(sites)
        temp.remove(atOffsets: indexSet)
        
        sites = Set(temp)
        
        try save()
    }
}

private extension Set where Element == Site {
    
    @discardableResult
    mutating func remove(siteWithId id: UUID) -> Bool {
        guard let index = index(ofSiteWithId: id) else { return false }
        remove(at: index)
        return true
    }
    
    func index(ofSiteWithId id: UUID) -> Set<Site>.Index? {
        firstIndex { site in
            site.id == id
        }
    }
    
}
