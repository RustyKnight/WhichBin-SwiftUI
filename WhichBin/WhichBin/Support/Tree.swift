//
//  Tree.swift
//  WhichBinLib
//
//  Created by Shane Whitehead on 3/9/2025.
//

import WhichBinLib
import Foundation

struct Tree: Hashable, Sendable, Identifiable {
    let id = UUID()
    let value: Element
    var children: [Tree]? = nil

    mutating func sortChildren() {
        guard let children else { return }
        self.children = children.sorted { $0.value < $1.value }
    }
}

extension Tree {
    enum Element: Hashable, Sendable {
        case country(Country)
        case state(State)
        case city(City, DataSourceRegistry.Key)
    }
}

func < (lhs: Tree.Element, rhs: Tree.Element) -> Bool {
    switch (lhs, rhs) {
    case let (.country(lCountry), .country(rCountry)):
        return lCountry.description < rCountry.description
    case let (.state(lState), .state(rState)):
        return lState.description < rState.description
    case let (.city(lCity, _), .city(rCity, _)):
        return lCity.description < rCity.description
    case (.country, .state):
        return true
    case (.country, .city):
        return true
    case (.state, .country):
        return false
    case (.state, .city):
        return true
    case (.city, .country):
        return false
    case (.city, .state):
        return false
    }
}
