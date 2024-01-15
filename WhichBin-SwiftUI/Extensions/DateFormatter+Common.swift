//
//  DateFormatter+Common.swift
//  WhichBin-SwiftUI
//
//  Created by Shane Whitehead on 13/1/2024.
//

import Foundation

extension DateFormatter {
    static var relativeFullDate: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.doesRelativeDateFormatting = true
        return dateFormatter
    }()    

    static var fullDate: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.doesRelativeDateFormatting = false
        return dateFormatter
    }()

    static var shortDate: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.doesRelativeDateFormatting = false
        return dateFormatter
    }()
}
