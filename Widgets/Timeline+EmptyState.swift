//
//  Timeline+EmptyState.swift
//  WhichBin-SwiftUI
//
//  Created by Shane Whitehead on 29/8/2024.
//

import WidgetKit

extension Timeline {
    static func emptyState(debugDetails: String) -> Timeline<WidgetModel> {
        Timeline<WidgetModel>(
            entries: [WidgetModel(date: Date().plus(minutes: 5), eventsDate: nil, events: [], debugDetails: debugDetails)],
            policy: .atEnd
        )
    }
}
