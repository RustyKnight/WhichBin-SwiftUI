//
//  ParserError.swift
//  WhichBinLib
//
//  Created by Shane Whitehead on 10/4/2025.
//

import Foundation

/// Describes common parsing errors.
public enum ParserError: Error {
    /// Failed to decode property.
    case propertyDecodingFailed(String)
    /// Failed to load required resource.
    case failedLoadingResource(URL)
    /// Unknown value for property.
    case unknownValue(String, forProperty: String)
}
