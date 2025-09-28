//
//  DataSource+Grouping.swift
//  WhichBin
//
//  Created by Shane Whitehead on 3/9/2025.
//

import WhichBinLib
import WhichBinDataSourceLib

extension DataSourceRegistry {

    var grouped: [Tree] {
        let sources = DataSourceRegistry.shared.dataSources

        let cities = sources.values.map { $0.city }
        let states = cities.map { $0.state }
        let countries = states.map { $0.country }

        var countryTrees = [Tree]()

        for country in Set(countries) {
            let statesInCountry = states.filter { $0.country == country }

            var countryTree = Tree(
                value: .country(country),
                children: []
            )

            for state in Set(statesInCountry) {
                let citiesInState = cities
                    .filter { $0.state == state }
                    .compactMap { city -> Tree? in
                        guard let key = sources.first(where: { $0.value.city == city })?.key else {
                            return nil
                        }
                        return Tree(value: .city(city, key))
                    }

                guard !citiesInState.isEmpty else { continue }

                var stateTree = Tree(
                    value: .state(state),
                    children: citiesInState
                )
                stateTree.sortChildren()

                countryTree.children?.append(stateTree)
            }

            countryTree.sortChildren()
            countryTrees.append(countryTree)
        }

        countryTrees = countryTrees.sorted { lhs, rhs in
            lhs.value < rhs.value
        }

        return countryTrees
    }
}
