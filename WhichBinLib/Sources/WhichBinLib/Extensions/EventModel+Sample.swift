//
//  EventModel+Sample.swift
//  WhichBinLib
//
//  Created by Shane Whitehead on 29/8/2024.
//

import Foundation

public extension EventModel {
    static var sample: EventModel {
        EventModel([
            Property(
                day: .wednesday,
                weeks: 1,
                epoch: WhichBinSupport.rubbishEpoch,
                collectionType: .rubbish
            ),
            Property(
                day: .wednesday,
                weeks: 2,
                epoch: WhichBinSupport.recycleEpoch,
                collectionType: .recycling
            ),
            Property(
                day: .wednesday,
                weeks: 2,
                epoch: WhichBinSupport.greenEpoch,
                collectionType: .green
            ),
            Property(
                day: .wednesday,
                weeks: 4,
                epoch: WhichBinSupport.glassEpoch,
                collectionType: .glass
            )
        ])
    }

    static func sampleEvents(_ targetDate: Date) -> [EventModel.Event] {
        [
            EventModel.Event(
                property: Property(
                    day: .wednesday,
                    weeks: 1,
                    epoch: WhichBinSupport.rubbishEpoch,
                    collectionType: .rubbish
                ),
                date: targetDate
            ),
            EventModel.Event(
                property: Property(
                    day: .wednesday,
                    weeks: 1,
                    epoch: WhichBinSupport.glassEpoch,
                    collectionType: .glass
                ),
                date: targetDate
            ),
            EventModel.Event(
                property: Property(
                    day: .wednesday,
                    weeks: 1,
                    epoch: WhichBinSupport.recycleEpoch,
                    collectionType: .recycling
                ),
                date: targetDate
            ),
            EventModel.Event(
                property: Property(
                    day: .wednesday,
                    weeks: 1,
                    epoch: WhichBinSupport.greenEpoch,
                    collectionType: .green
                ),
                date: targetDate
            ),
        ]
    }
}
