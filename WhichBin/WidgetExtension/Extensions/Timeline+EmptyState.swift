//
//  Timeline+EmptyState.swift
//  WhichBin
//
//  Created by Shane Whitehead on 22/9/2025.
//

import WidgetKit
import CoreExtensions

extension Timeline {

    static func emptyState(debugDetails: String) -> Timeline<WidgetModel> {
        Timeline<WidgetModel>(
            entries: [
                WidgetModel(
                    date: Date() + 5.minutes,
                    debugDetails: debugDetails
                )
            ],
            policy: .atEnd
        )
    }
}
