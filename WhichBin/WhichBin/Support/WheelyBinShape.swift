//
//  WheelyBinShape.swift
//  WhichBin
//
//  Created by Shane Whitehead on 9/9/2025.
//

import Foundation
import SwiftUI
import Cadmus

struct WheelyBinShape: Shape {
    
    static let originalSize: CGSize = .init(width: 256, height: 390)
    static var aspectRatio: Double {
        originalSize.width / originalSize.height
    }
    
    func path(in rect: CGRect) -> Path {
        let baseSize = Self.originalSize
        
        let xScale = rect.size.width / baseSize.width
        let yScale = rect.size.height / baseSize.height
        
        let scale = min(xScale, yScale)
        
        var path = Path()
        let width = baseSize.width * scale
        let height = baseSize.height * scale
        
        let xOffset: CGFloat = (rect.width - width) / 2
        let yOffset: CGFloat = (rect.height - height) / 2
        
        path.move(to: CGPoint(x: 0.01509*width, y: 0.13387*height))
        path.addLine(to: CGPoint(x: 0.01509*width, y: 0.16028*height))
        path.addLine(to: CGPoint(x: 0.12683*width, y: 0.17349*height))
        path.addLine(to: CGPoint(x: 0.12683*width, y: 0.223*height))
        path.addLine(to: CGPoint(x: 0.14143*width, y: 0.2329*height))
        path.addCurve(to: CGPoint(x: 0.20457*width, y: 0.91297*height), control1: CGPoint(x: 0.14143*width, y: 0.2329*height), control2: CGPoint(x: 0.19974*width, y: 0.89315*height))
        path.addCurve(to: CGPoint(x: 0.25317*width, y: 0.93938*height), control1: CGPoint(x: 0.20943*width, y: 0.93277*height), control2: CGPoint(x: 0.22887*width, y: 0.93277*height))
        path.addCurve(to: CGPoint(x: 0.48638*width, y: 0.98559*height), control1: CGPoint(x: 0.27747*width, y: 0.94597*height), control2: CGPoint(x: 0.46694*width, y: 0.98231*height))
        path.addCurve(to: CGPoint(x: 0.58842*width, y: 0.98559*height), control1: CGPoint(x: 0.50581*width, y: 0.9889*height), control2: CGPoint(x: 0.55925*width, y: 0.99221*height))
        path.addCurve(to: CGPoint(x: 0.78758*width, y: 0.93938*height), control1: CGPoint(x: 0.61755*width, y: 0.979*height), control2: CGPoint(x: 0.78758*width, y: 0.93938*height))
        path.addLine(to: CGPoint(x: 0.89449*width, y: 0.93938*height))
        path.addCurve(to: CGPoint(x: 0.95279*width, y: 0.89977*height), control1: CGPoint(x: 0.89449*width, y: 0.93938*height), control2: CGPoint(x: 0.92849*width, y: 0.93277*height))
        path.addCurve(to: CGPoint(x: 0.85562*width, y: 0.7611*height), control1: CGPoint(x: 1.008*width, y: 0.82472*height), control2: CGPoint(x: 1.00136*width, y: 0.69508*height))
        path.addLine(to: CGPoint(x: 0.84106*width, y: 0.75121*height))
        path.addLine(to: CGPoint(x: 0.84106*width, y: 0.70169*height))
        path.addLine(to: CGPoint(x: 0.89449*width, y: 0.223*height))
        path.addLine(to: CGPoint(x: 0.90906*width, y: 0.21641*height))
        path.addLine(to: CGPoint(x: 0.90906*width, y: 0.16028*height))
        path.addLine(to: CGPoint(x: 0.95279*width, y: 0.12397*height))
        path.addLine(to: CGPoint(x: 0.98679*width, y: 0.09756*height))
        path.addLine(to: CGPoint(x: 0.98679*width, y: 0.06785*height))
        path.addCurve(to: CGPoint(x: 0.95279*width, y: 0.03813*height), control1: CGPoint(x: 0.98679*width, y: 0.05133*height), control2: CGPoint(x: 0.98192*width, y: 0.03813*height))
        path.addLine(to: CGPoint(x: 0.57868*width, y: 0.01172*height))
        path.addCurve(to: CGPoint(x: 0.53494*width, y: 0.01172*height), control1: CGPoint(x: 0.55438*width, y: 0.00841*height), control2: CGPoint(x: 0.54955*width, y: 0.01172*height))
        path.addLine(to: CGPoint(x: 0.47181*width, y: 0.02162*height))
        path.addLine(to: CGPoint(x: 0.45234*width, y: 0.03813*height))
        path.addLine(to: CGPoint(x: 0.28717*width, y: 0.04803*height))
        path.addCurve(to: CGPoint(x: 0.26774*width, y: 0.03813*height), control1: CGPoint(x: 0.28717*width, y: 0.04803*height), control2: CGPoint(x: 0.27989*width, y: 0.03813*height))
        path.addCurve(to: CGPoint(x: 0.1657*width, y: 0.04803*height), control1: CGPoint(x: 0.2483*width, y: 0.03813*height), control2: CGPoint(x: 0.19728*width, y: 0.04062*height))
        path.addCurve(to: CGPoint(x: 0.14143*width, y: 0.06785*height), control1: CGPoint(x: 0.14385*width, y: 0.05464*height), control2: CGPoint(x: 0.14143*width, y: 0.06785*height))
        path.addLine(to: CGPoint(x: 0.12683*width, y: 0.06785*height))
        path.addCurve(to: CGPoint(x: 0.1074*width, y: 0.07774*height), control1: CGPoint(x: 0.11834*width, y: 0.07033*height), control2: CGPoint(x: 0.11226*width, y: 0.06785*height))
        path.addLine(to: CGPoint(x: 0.1074*width, y: 0.09756*height))
        path.addLine(to: CGPoint(x: 0.04909*width, y: 0.09756*height))
        path.addCurve(to: CGPoint(x: 0.01509*width, y: 0.13387*height), control1: CGPoint(x: 0.01509*width, y: 0.10415*height), control2: CGPoint(x: 0.01509*width, y: 0.11736*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.01509*width, y: 0.13387*height))
        
        return path
            .offsetBy(dx: xOffset, dy: yOffset)
    }
}
