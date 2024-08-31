//
//  UserDefaults+Shared.swift
//  WhichBinLib
//
//  Created by Shane Whitehead on 29/8/2024.
//

import Foundation
import CoreLocation

public extension UserDefaults {
    convenience init?<R: RawRepresentable>(suiteName: R) where R.RawValue == String {
        self.init(suiteName: suiteName.rawValue)
    }

    func set(_ location: CLLocationCoordinate2D, forKey key: String) {
        set(location.latitude, forKey: "\(key).latitude)")
        set(location.longitude, forKey: "\(key).longitude")
    }

    func location(forKey key: String) -> CLLocationCoordinate2D? {
        guard let latitudeString = string(forKey: "\(key).latitude)"),
              let longitudeString = string(forKey: "\(key).longitude"),
              let latitude = Double(latitudeString),
              let longitude = Double(longitudeString) else {
            return nil
        }
        return .init(latitude: latitude, longitude: longitude)
    }

    func set<R: RawRepresentable>(_ location: CLLocationCoordinate2D, forKey key: R) where R.RawValue == String {
        set(location, forKey: key.rawValue)
    }

    func location<R: RawRepresentable>(forKey key: R) -> CLLocationCoordinate2D? where R.RawValue == String {
        location(forKey: key.rawValue)
    }

    func set<R: RawRepresentable>(_ value: String, forKey key: R) where R.RawValue == String {
        set(value, forKey: key.rawValue)
    }

    func string<R: RawRepresentable>(forKey key: R) -> String? where R.RawValue == String {
        string(forKey: key.rawValue)
    }

    func set<R: RawRepresentable>(_ value: URL, forKey key: R) where R.RawValue == String {
        set(value, forKey: key.rawValue)
    }

    func url<R: RawRepresentable>(forKey key: R) -> URL? where R.RawValue == String {
        url(forKey: key.rawValue)
    }}
