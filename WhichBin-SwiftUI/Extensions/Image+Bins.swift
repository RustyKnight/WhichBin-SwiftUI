//
//  Image+Bins.swift
//  WhichBin-SwiftUI
//
//  Created by Shane Whitehead on 29/8/2024.
//

import SwiftUI
import WhichBinLib
import WidgetKit

public extension Image {

    static func imageFor(event: EventModel.Event) -> Image {
        switch event.collectionType {
        case .rubbish: Image(.redBinVector)
        case .recycling: Image(.yellowBinVector)
        case .green: Image(.greenBinVector)
        case .glass: Image(.purpleBinVector)
        }
    }

    static func imageFor(event: EventModel.Event, family: WidgetFamily) -> Image {
        switch event.collectionType {
        case .rubbish:
            switch family {
            case .accessoryCircular, .accessoryCorner, .accessoryInline, .accessoryRectangular:
                return Image(.symbolRubbish)
            default:
                return Image(.redBinVector)
            }
        case .recycling:
            switch family {
            case .accessoryCircular, .accessoryCorner, .accessoryInline, .accessoryRectangular:
                return Image(.symbolRecyclePlastic)
            default:
                return Image(.yellowBinVector)
            }
        case .green:
            switch family {
            case .accessoryCircular, .accessoryCorner, .accessoryInline, .accessoryRectangular:
                return Image(.symbolRecycleGreen)
            default:
                return Image(.greenBinVector)
            }
        case .glass:
            switch family {
            case .accessoryCircular, .accessoryCorner, .accessoryInline, .accessoryRectangular:
                return Image(.symbolRecycleGlass)
            default:
                return Image(.purpleBinVector)
            }
        }
    }

}
