//
//  EqualSizeGridLayout.swift
//  WhichBin
//
//  Created by Shane Whitehead on 11/9/2025.
//


//
//  EqualSizeGridLayout.swift
//  GridLayoutTest
//
//  Created by Shane Whitehead on 25/8/2025.
//

import SwiftUI

public struct EqualSizeGridLayout: Layout {

    public enum Constraint {
        case columns(Int)
        case rows(Int)
    }

    public let columnSpacing: CGFloat
    public let rowSpacing: CGFloat

    public let constraint: Constraint?

    public init(columnSpacing: CGFloat = 8, rowSpacing: CGFloat = 8, constraint: Constraint? = nil) {
        self.columnSpacing = columnSpacing
        self.rowSpacing = rowSpacing
        self.constraint = constraint
    }

    public func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout Void
    ) -> CGSize {
        guard subviews.isEmpty == false else { return .zero }

        let maxSize = cellMaxSize(subviews: subviews)

        let proposedHeight = proposal.height
        let proposedWidth = proposal.width

        switch constraint {
        case .none:
            if let proposedWidth, let proposedHeight {
                if proposedWidth <= maxSize.width {
                    let spacing = max(0, CGFloat(subviews.count - 1) * columnSpacing)
                    return CGSize(
                        width: maxSize.width,
                        height: (maxSize.height * CGFloat(subviews.count)) + spacing
                    )
                }

                let columnCount = floor(proposedWidth / (maxSize.width + columnSpacing))
                let rowCount = ceil(CGFloat(subviews.count) / columnCount)

                return sizeThatFits(
                    columnCount: Int(columnCount),
                    rowCount: Int(rowCount),
                    cellSize: maxSize
                )
            } else {
                let proposedSize = proposal.replacingUnspecifiedDimensions()
                let spacing = max(0, CGFloat(subviews.count - 1) * columnSpacing)
                return CGSize(
                    width: (maxSize.width * CGFloat(subviews.count)) + spacing,
                    height: maxSize.height
                )
            }

        case .some(let constraint):
            switch constraint {
            case .columns(let columnCount):
                // Soooo, with fixed number of columns, we can either fit them to the
                // proposed space and ignore cell width / height OR we can
                // can honour the cell size and ignore the proposed size ...

                let rowCount = ceil(CGFloat(subviews.count) / CGFloat(columnCount))

                return sizeThatFits(
                    columnCount: Int(columnCount),
                    rowCount: Int(rowCount),
                    cellSize: maxSize
                )

            case .rows(let rowCount):
                let columnCount = ceil(CGFloat(subviews.count) / CGFloat(rowCount))

                return sizeThatFits(
                    columnCount: Int(columnCount),
                    rowCount: Int(rowCount),
                    cellSize: maxSize
                )
            }
        }
    }
    
    public func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        guard subviews.isEmpty == false else { return }

        let maxSize = cellMaxSize(subviews: subviews)
        let placementProposal = ProposedViewSize(
            width: maxSize.width,
            height: maxSize.height
        )

        var nextX = bounds.minX + maxSize.width / 2
        var nextY = bounds.minY + maxSize.height / 2

        for index in subviews.indices {
            subviews[index]
                .place(
                    at: CGPoint(x: nextX, y: nextY),
                    anchor: .center,
                    proposal: placementProposal
                )

            nextX += maxSize.width + columnSpacing

            if nextX > bounds.maxX {
                nextX = bounds.minX + maxSize.width / 2
                nextY += maxSize.height + rowSpacing
            }
        }
    }

    private func sizeThatFits(columnCount: Int, rowCount: Int, cellSize: CGSize) -> CGSize {
        CGSize(
            width: ((cellSize.width + columnSpacing) * CGFloat(columnCount)) - columnSpacing,
            height: ((cellSize.height + rowSpacing) * CGFloat(rowCount)) - rowSpacing
        )
    }

    /// Finds the largest ideal size of the subviews.
    private func cellMaxSize(subviews: Subviews) -> CGSize {
        let subviewSizes = subviews.map { $0.sizeThatFits(.unspecified) }
        let maxSize: CGSize = subviewSizes.reduce(.zero) { currentMax, subviewSize in
            CGSize(
                width: max(currentMax.width, subviewSize.width),
                height: max(currentMax.height, subviewSize.height))
        }

        return maxSize
    }

}
