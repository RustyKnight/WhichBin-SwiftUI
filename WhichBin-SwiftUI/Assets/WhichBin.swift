////
////  WhichBin.swift
////  WhichBin
////
////  Created by Me on 13/1/2024.
////  Copyright © 2024 CompanyName. All rights reserved.
////
////  Generated by PaintCode
////  http://www.paintcodeapp.com
////
////  This code was generated by Trial version of PaintCode, therefore cannot be used for commercial purposes.
////
//#if canImport(UIKit)
//import UIKit
//#elseif canImport(AppKit)
//import AppKit
//#endif
//
//public class WhichBin : NSObject {
//
//    //// Drawing Methods
//
//    @objc dynamic public class func drawLeaf(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 50, height: 50), resizing: ResizingBehavior = .aspectFit, isDarkMode: Bool = false) {
//        //// General Declarations
//        let context = UIGraphicsGetCurrentContext()!
//        
//        //// Resize to Target Frame
//        context.saveGState()
//        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 50, height: 50), target: targetFrame)
//        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
//        context.scaleBy(x: resizedFrame.width / 50, y: resizedFrame.height / 50)
//
//
//        //// Color Declarations
//        let green = UIColor(red: 0.000, green: 0.502, blue: 0.000, alpha: 1.000)
//        var greenRedComponent: CGFloat = 1
//        var greenGreenComponent: CGFloat = 1
//        var greenBlueComponent: CGFloat = 1
//        green.getRed(&greenRedComponent, green: &greenGreenComponent, blue: &greenBlueComponent, alpha: nil)
//
//        let greenLight = UIColor(red: (greenRedComponent * 0.8 + 0.2), green: (greenGreenComponent * 0.8 + 0.2), blue: (greenBlueComponent * 0.8 + 0.2), alpha: (green.cgColor.alpha * 0.8 + 0.2))
//
//        //// Variable Declarations
//        let leafFill = isDarkMode ? greenLight : green
//
//        //// Bezier Drawing
//        let bezierPath = UIBezierPath()
//        bezierPath.move(to: CGPoint(x: 39.84, y: 0))
//        bezierPath.addCurve(to: CGPoint(x: 39.19, y: 0.44), controlPoint1: CGPoint(x: 39.58, y: 0.04), controlPoint2: CGPoint(x: 39.34, y: 0.21))
//        bezierPath.addCurve(to: CGPoint(x: 28.69, y: 5.31), controlPoint1: CGPoint(x: 37.14, y: 3.33), controlPoint2: CGPoint(x: 33.21, y: 4.24))
//        bezierPath.addCurve(to: CGPoint(x: 9.66, y: 16.56), controlPoint1: CGPoint(x: 22.5, y: 6.78), controlPoint2: CGPoint(x: 14.8, y: 8.6))
//        bezierPath.addCurve(to: CGPoint(x: 8.72, y: 29.91), controlPoint1: CGPoint(x: 5.97, y: 22.23), controlPoint2: CGPoint(x: 7.11, y: 26.95))
//        bezierPath.addCurve(to: CGPoint(x: 18.47, y: 37.75), controlPoint1: CGPoint(x: 10.88, y: 33.89), controlPoint2: CGPoint(x: 15.15, y: 36.87))
//        bezierPath.addCurve(to: CGPoint(x: 4.56, y: 43.12), controlPoint1: CGPoint(x: 13.61, y: 41.88), controlPoint2: CGPoint(x: 8.62, y: 44.27))
//        bezierPath.addCurve(to: CGPoint(x: 3.34, y: 43.84), controlPoint1: CGPoint(x: 4.03, y: 42.98), controlPoint2: CGPoint(x: 3.49, y: 43.31))
//        bezierPath.addCurve(to: CGPoint(x: 4.03, y: 45.06), controlPoint1: CGPoint(x: 3.2, y: 44.38), controlPoint2: CGPoint(x: 3.5, y: 44.91))
//        bezierPath.addCurve(to: CGPoint(x: 6.66, y: 45.41), controlPoint1: CGPoint(x: 4.89, y: 45.3), controlPoint2: CGPoint(x: 5.76, y: 45.41))
//        bezierPath.addCurve(to: CGPoint(x: 20.16, y: 38.88), controlPoint1: CGPoint(x: 10.97, y: 45.41), controlPoint2: CGPoint(x: 15.7, y: 42.78))
//        bezierPath.addCurve(to: CGPoint(x: 19.91, y: 38), controlPoint1: CGPoint(x: 20.05, y: 38.57), controlPoint2: CGPoint(x: 19.98, y: 38.28))
//        bezierPath.addCurve(to: CGPoint(x: 18.5, y: 37.75), controlPoint1: CGPoint(x: 19.47, y: 37.97), controlPoint2: CGPoint(x: 18.98, y: 37.88))
//        bezierPath.addCurve(to: CGPoint(x: 35.38, y: 14.34), controlPoint1: CGPoint(x: 25.53, y: 31.77), controlPoint2: CGPoint(x: 32.25, y: 22.18))
//        bezierPath.addCurve(to: CGPoint(x: 36.66, y: 13.78), controlPoint1: CGPoint(x: 35.58, y: 13.83), controlPoint2: CGPoint(x: 36.14, y: 13.58))
//        bezierPath.addCurve(to: CGPoint(x: 37.22, y: 15.06), controlPoint1: CGPoint(x: 37.17, y: 13.98), controlPoint2: CGPoint(x: 37.42, y: 14.55))
//        bezierPath.addCurve(to: CGPoint(x: 20.16, y: 38.88), controlPoint1: CGPoint(x: 34.34, y: 22.3), controlPoint2: CGPoint(x: 27.61, y: 32.36))
//        bezierPath.addCurve(to: CGPoint(x: 30.09, y: 45), controlPoint1: CGPoint(x: 21.14, y: 41.68), controlPoint2: CGPoint(x: 23.66, y: 45))
//        bezierPath.addCurve(to: CGPoint(x: 41.97, y: 37.56), controlPoint1: CGPoint(x: 33.29, y: 45), controlPoint2: CGPoint(x: 38.32, y: 43.05))
//        bezierPath.addCurve(to: CGPoint(x: 40.94, y: 0.62), controlPoint1: CGPoint(x: 45.27, y: 32.6), controlPoint2: CGPoint(x: 49.55, y: 21.22))
//        bezierPath.addCurve(to: CGPoint(x: 40.12, y: 0), controlPoint1: CGPoint(x: 40.8, y: 0.29), controlPoint2: CGPoint(x: 40.48, y: 0.04))
//        bezierPath.addCurve(to: CGPoint(x: 39.84, y: 0), controlPoint1: CGPoint(x: 40.03, y: -0.01), controlPoint2: CGPoint(x: 39.93, y: -0.02))
//        bezierPath.close()
//        leafFill.setFill()
//        bezierPath.fill()
//        
//        context.restoreGState()
//
//    }
//
//    @objc dynamic public class func drawRecycle(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 50, height: 50), resizing: ResizingBehavior = .aspectFit, isDarkMode: Bool = false) {
//        //// General Declarations
//        let context = UIGraphicsGetCurrentContext()!
//        
//        //// Resize to Target Frame
//        context.saveGState()
//        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 50, height: 50), target: targetFrame)
//        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
//        context.scaleBy(x: resizedFrame.width / 50, y: resizedFrame.height / 50)
//
//
//        //// Color Declarations
//        let yellow = UIColor(red: 0.502, green: 0.502, blue: 0.000, alpha: 1.000)
//        var yellowRedComponent: CGFloat = 1
//        var yellowGreenComponent: CGFloat = 1
//        var yellowBlueComponent: CGFloat = 1
//        yellow.getRed(&yellowRedComponent, green: &yellowGreenComponent, blue: &yellowBlueComponent, alpha: nil)
//
//        let yellowLight = UIColor(red: (yellowRedComponent * 0.8 + 0.2), green: (yellowGreenComponent * 0.8 + 0.2), blue: (yellowBlueComponent * 0.8 + 0.2), alpha: (yellow.cgColor.alpha * 0.8 + 0.2))
//
//        //// Variable Declarations
//        let recyleFill = isDarkMode ? yellowLight : yellow
//
//        //// Bezier Drawing
//        let bezierPath = UIBezierPath()
//        bezierPath.move(to: CGPoint(x: 19.06, y: 1))
//        bezierPath.addCurve(to: CGPoint(x: 13.69, y: 3.72), controlPoint1: CGPoint(x: 16.5, y: 1.15), controlPoint2: CGPoint(x: 14.69, y: 2.06))
//        bezierPath.addLine(to: CGPoint(x: 7.09, y: 15.16))
//        bezierPath.addLine(to: CGPoint(x: 11.5, y: 17.69))
//        bezierPath.addLine(to: CGPoint(x: 0.16, y: 19.09))
//        bezierPath.addLine(to: CGPoint(x: 3.62, y: 21.09))
//        bezierPath.addLine(to: CGPoint(x: 0.59, y: 26.25))
//        bezierPath.addCurve(to: CGPoint(x: 0.78, y: 31.62), controlPoint1: CGPoint(x: -0.04, y: 27.35), controlPoint2: CGPoint(x: -0.41, y: 29.82))
//        bezierPath.addCurve(to: CGPoint(x: 4.12, y: 37.47), controlPoint1: CGPoint(x: 1.25, y: 32.34), controlPoint2: CGPoint(x: 2.78, y: 35.07))
//        bezierPath.addCurve(to: CGPoint(x: 6.88, y: 42.31), controlPoint1: CGPoint(x: 5.29, y: 39.54), controlPoint2: CGPoint(x: 6.38, y: 41.5))
//        bezierPath.addCurve(to: CGPoint(x: 8.09, y: 43.97), controlPoint1: CGPoint(x: 7.45, y: 43.1), controlPoint2: CGPoint(x: 8.02, y: 43.87))
//        bezierPath.addCurve(to: CGPoint(x: 9.09, y: 37.88), controlPoint1: CGPoint(x: 8.1, y: 43.97), controlPoint2: CGPoint(x: 6.82, y: 41.82))
//        bezierPath.addLine(to: CGPoint(x: 15, y: 27.66))
//        bezierPath.addLine(to: CGPoint(x: 18.47, y: 29.66))
//        bezierPath.addLine(to: CGPoint(x: 14.03, y: 19.16))
//        bezierPath.addLine(to: CGPoint(x: 18.44, y: 21.69))
//        bezierPath.addLine(to: CGPoint(x: 27.88, y: 5.34))
//        bezierPath.addCurve(to: CGPoint(x: 31.66, y: 1.06), controlPoint1: CGPoint(x: 29.79, y: 1.78), controlPoint2: CGPoint(x: 31.31, y: 1.16))
//        bezierPath.addCurve(to: CGPoint(x: 32.12, y: 1.06), controlPoint1: CGPoint(x: 31.83, y: 1.06), controlPoint2: CGPoint(x: 31.97, y: 1.06))
//        bezierPath.addCurve(to: CGPoint(x: 31.72, y: 1.03), controlPoint1: CGPoint(x: 31.99, y: 1.06), controlPoint2: CGPoint(x: 31.86, y: 1.03))
//        bezierPath.addCurve(to: CGPoint(x: 31.47, y: 1.03), controlPoint1: CGPoint(x: 31.64, y: 1.03), controlPoint2: CGPoint(x: 31.55, y: 1.03))
//        bezierPath.addCurve(to: CGPoint(x: 24.75, y: 1.03), controlPoint1: CGPoint(x: 30.07, y: 1.06), controlPoint2: CGPoint(x: 27.66, y: 1.05))
//        bezierPath.addCurve(to: CGPoint(x: 19.06, y: 1), controlPoint1: CGPoint(x: 23.02, y: 1.02), controlPoint2: CGPoint(x: 21.12, y: 1))
//        bezierPath.close()
//        bezierPath.move(to: CGPoint(x: 32.97, y: 1.16))
//        bezierPath.addCurve(to: CGPoint(x: 29.5, y: 5.34), controlPoint1: CGPoint(x: 32.37, y: 1.45), controlPoint2: CGPoint(x: 31.08, y: 2.39))
//        bezierPath.addLine(to: CGPoint(x: 25.88, y: 11.62))
//        bezierPath.addLine(to: CGPoint(x: 28, y: 15.34))
//        bezierPath.addLine(to: CGPoint(x: 24.53, y: 17.38))
//        bezierPath.addLine(to: CGPoint(x: 35.84, y: 18.75))
//        bezierPath.addLine(to: CGPoint(x: 31.44, y: 21.28))
//        bezierPath.addLine(to: CGPoint(x: 37.16, y: 31.19))
//        bezierPath.addLine(to: CGPoint(x: 44.59, y: 31.19))
//        bezierPath.addCurve(to: CGPoint(x: 49.94, y: 29.53), controlPoint1: CGPoint(x: 47.72, y: 31.19), controlPoint2: CGPoint(x: 49.28, y: 30.18))
//        bezierPath.addCurve(to: CGPoint(x: 49.38, y: 26.16), controlPoint1: CGPoint(x: 50.12, y: 28.3), controlPoint2: CGPoint(x: 49.93, y: 27.17))
//        bezierPath.addLine(to: CGPoint(x: 42.78, y: 14.75))
//        bezierPath.addLine(to: CGPoint(x: 38.38, y: 17.28))
//        bezierPath.addLine(to: CGPoint(x: 42.84, y: 6.78))
//        bezierPath.addLine(to: CGPoint(x: 39.38, y: 8.78))
//        bezierPath.addLine(to: CGPoint(x: 36.41, y: 3.59))
//        bezierPath.addCurve(to: CGPoint(x: 32.97, y: 1.16), controlPoint1: CGPoint(x: 35.9, y: 2.72), controlPoint2: CGPoint(x: 34.58, y: 1.54))
//        bezierPath.close()
//        bezierPath.move(to: CGPoint(x: 32.16, y: 28.72))
//        bezierPath.addLine(to: CGPoint(x: 25.28, y: 37.84))
//        bezierPath.addLine(to: CGPoint(x: 25.28, y: 32.75))
//        bezierPath.addLine(to: CGPoint(x: 13.84, y: 32.75))
//        bezierPath.addLine(to: CGPoint(x: 10.12, y: 39.19))
//        bezierPath.addCurve(to: CGPoint(x: 8.91, y: 44.66), controlPoint1: CGPoint(x: 8.56, y: 41.9), controlPoint2: CGPoint(x: 8.68, y: 43.76))
//        bezierPath.addCurve(to: CGPoint(x: 12.09, y: 45.88), controlPoint1: CGPoint(x: 9.88, y: 45.43), controlPoint2: CGPoint(x: 10.94, y: 45.85))
//        bezierPath.addLine(to: CGPoint(x: 25.28, y: 45.88))
//        bezierPath.addLine(to: CGPoint(x: 25.28, y: 40.75))
//        bezierPath.addLine(to: CGPoint(x: 32.16, y: 49.88))
//        bezierPath.addLine(to: CGPoint(x: 32.16, y: 45.88))
//        bezierPath.addLine(to: CGPoint(x: 38.12, y: 45.91))
//        bezierPath.addCurve(to: CGPoint(x: 42.69, y: 43.09), controlPoint1: CGPoint(x: 39.4, y: 45.91), controlPoint2: CGPoint(x: 41.72, y: 45.03))
//        bezierPath.addCurve(to: CGPoint(x: 46.09, y: 37.25), controlPoint1: CGPoint(x: 43.07, y: 42.33), controlPoint2: CGPoint(x: 44.69, y: 39.62))
//        bezierPath.addCurve(to: CGPoint(x: 48.91, y: 32.44), controlPoint1: CGPoint(x: 47.31, y: 35.2), controlPoint2: CGPoint(x: 48.45, y: 33.28))
//        bezierPath.addCurve(to: CGPoint(x: 49.72, y: 30.56), controlPoint1: CGPoint(x: 49.3, y: 31.54), controlPoint2: CGPoint(x: 49.67, y: 30.67))
//        bezierPath.addCurve(to: CGPoint(x: 43.97, y: 32.75), controlPoint1: CGPoint(x: 49.72, y: 30.56), controlPoint2: CGPoint(x: 48.52, y: 32.75))
//        bezierPath.addLine(to: CGPoint(x: 32.16, y: 32.75))
//        bezierPath.addLine(to: CGPoint(x: 32.16, y: 28.72))
//        bezierPath.close()
//        recyleFill.setFill()
//        bezierPath.fill()
//        
//        context.restoreGState()
//
//    }
//
//    @objc dynamic public class func drawWhichBin1024(frame: CGRect = CGRect(x: 0, y: 0, width: 1024, height: 1024)) {
//        //// General Declarations
//        let context = UIGraphicsGetCurrentContext()!
//        // This non-generic function dramatically improves compilation times of complex expressions.
//        func fastFloor(_ x: CGFloat) -> CGFloat { return floor(x) }
//
//        //// Color Declarations
//        let fillColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
//        let binFill = UIColor(red: 0.753, green: 0.753, blue: 0.753, alpha: 0.753)
//
//
//        //// Subframes
//        let group: CGRect = CGRect(x: frame.minX + fastFloor(frame.width * 0.00000 + 0.5), y: frame.minY + fastFloor(frame.height * 0.00000 + 0.5), width: fastFloor(frame.width * 1.00000 + 0.5) - fastFloor(frame.width * 0.00000 + 0.5), height: fastFloor(frame.height * 1.00000 + 0.5) - fastFloor(frame.height * 0.00000 + 0.5))
//
//
//        //// Group
//        //// Rectangle Drawing
//        let rectanglePath = UIBezierPath(roundedRect: CGRect(x: group.minX + fastFloor(group.width * 0.00000 + 0.5), y: group.minY + fastFloor(group.height * 0.00000 + 0.5), width: fastFloor(group.width * 1.00000 + 0.5) - fastFloor(group.width * 0.00000 + 0.5), height: fastFloor(group.height * 1.00000 + 0.5) - fastFloor(group.height * 0.00000 + 0.5)), cornerRadius: 220)
//        UIColor.gray.setFill()
//        rectanglePath.fill()
//
//
//        //// Bezier Drawing
//        let bezierPath = UIBezierPath()
//        bezierPath.move(to: CGPoint(x: group.minX + 0.18438 * group.width, y: group.minY + 0.15625 * group.height))
//        bezierPath.addLine(to: CGPoint(x: group.minX + 0.18438 * group.width, y: group.minY + 0.18125 * group.height))
//        bezierPath.addLine(to: CGPoint(x: group.minX + 0.25625 * group.width, y: group.minY + 0.19375 * group.height))
//        bezierPath.addLine(to: CGPoint(x: group.minX + 0.25625 * group.width, y: group.minY + 0.24062 * group.height))
//        bezierPath.addLine(to: CGPoint(x: group.minX + 0.26562 * group.width, y: group.minY + 0.25000 * group.height))
//        bezierPath.addCurve(to: CGPoint(x: group.minX + 0.30625 * group.width, y: group.minY + 0.89375 * group.height), controlPoint1: CGPoint(x: group.minX + 0.26562 * group.width, y: group.minY + 0.25000 * group.height), controlPoint2: CGPoint(x: group.minX + 0.30313 * group.width, y: group.minY + 0.87500 * group.height))
//        bezierPath.addCurve(to: CGPoint(x: group.minX + 0.33750 * group.width, y: group.minY + 0.91875 * group.height), controlPoint1: CGPoint(x: group.minX + 0.30938 * group.width, y: group.minY + 0.91250 * group.height), controlPoint2: CGPoint(x: group.minX + 0.32188 * group.width, y: group.minY + 0.91250 * group.height))
//        bezierPath.addCurve(to: CGPoint(x: group.minX + 0.48750 * group.width, y: group.minY + 0.96250 * group.height), controlPoint1: CGPoint(x: group.minX + 0.35313 * group.width, y: group.minY + 0.92500 * group.height), controlPoint2: CGPoint(x: group.minX + 0.47500 * group.width, y: group.minY + 0.95937 * group.height))
//        bezierPath.addCurve(to: CGPoint(x: group.minX + 0.55312 * group.width, y: group.minY + 0.96250 * group.height), controlPoint1: CGPoint(x: group.minX + 0.50000 * group.width, y: group.minY + 0.96563 * group.height), controlPoint2: CGPoint(x: group.minX + 0.53438 * group.width, y: group.minY + 0.96875 * group.height))
//        bezierPath.addCurve(to: CGPoint(x: group.minX + 0.68125 * group.width, y: group.minY + 0.91875 * group.height), controlPoint1: CGPoint(x: group.minX + 0.57187 * group.width, y: group.minY + 0.95625 * group.height), controlPoint2: CGPoint(x: group.minX + 0.68125 * group.width, y: group.minY + 0.91875 * group.height))
//        bezierPath.addLine(to: CGPoint(x: group.minX + 0.75000 * group.width, y: group.minY + 0.91875 * group.height))
//        bezierPath.addCurve(to: CGPoint(x: group.minX + 0.78750 * group.width, y: group.minY + 0.88125 * group.height), controlPoint1: CGPoint(x: group.minX + 0.75000 * group.width, y: group.minY + 0.91875 * group.height), controlPoint2: CGPoint(x: group.minX + 0.77187 * group.width, y: group.minY + 0.91250 * group.height))
//        bezierPath.addCurve(to: CGPoint(x: group.minX + 0.72500 * group.width, y: group.minY + 0.75000 * group.height), controlPoint1: CGPoint(x: group.minX + 0.82302 * group.width, y: group.minY + 0.81021 * group.height), controlPoint2: CGPoint(x: group.minX + 0.81875 * group.width, y: group.minY + 0.68750 * group.height))
//        bezierPath.addLine(to: CGPoint(x: group.minX + 0.71562 * group.width, y: group.minY + 0.74062 * group.height))
//        bezierPath.addLine(to: CGPoint(x: group.minX + 0.71562 * group.width, y: group.minY + 0.69375 * group.height))
//        bezierPath.addLine(to: CGPoint(x: group.minX + 0.75000 * group.width, y: group.minY + 0.24062 * group.height))
//        bezierPath.addLine(to: CGPoint(x: group.minX + 0.75937 * group.width, y: group.minY + 0.23438 * group.height))
//        bezierPath.addLine(to: CGPoint(x: group.minX + 0.75937 * group.width, y: group.minY + 0.18125 * group.height))
//        bezierPath.addLine(to: CGPoint(x: group.minX + 0.78750 * group.width, y: group.minY + 0.14687 * group.height))
//        bezierPath.addLine(to: CGPoint(x: group.minX + 0.80937 * group.width, y: group.minY + 0.12187 * group.height))
//        bezierPath.addLine(to: CGPoint(x: group.minX + 0.80937 * group.width, y: group.minY + 0.09375 * group.height))
//        bezierPath.addCurve(to: CGPoint(x: group.minX + 0.78750 * group.width, y: group.minY + 0.06563 * group.height), controlPoint1: CGPoint(x: group.minX + 0.80937 * group.width, y: group.minY + 0.07812 * group.height), controlPoint2: CGPoint(x: group.minX + 0.80625 * group.width, y: group.minY + 0.06563 * group.height))
//        bezierPath.addLine(to: CGPoint(x: group.minX + 0.54688 * group.width, y: group.minY + 0.04063 * group.height))
//        bezierPath.addCurve(to: CGPoint(x: group.minX + 0.51875 * group.width, y: group.minY + 0.04063 * group.height), controlPoint1: CGPoint(x: group.minX + 0.53125 * group.width, y: group.minY + 0.03750 * group.height), controlPoint2: CGPoint(x: group.minX + 0.52813 * group.width, y: group.minY + 0.04063 * group.height))
//        bezierPath.addLine(to: CGPoint(x: group.minX + 0.47813 * group.width, y: group.minY + 0.05000 * group.height))
//        bezierPath.addLine(to: CGPoint(x: group.minX + 0.46563 * group.width, y: group.minY + 0.06563 * group.height))
//        bezierPath.addLine(to: CGPoint(x: group.minX + 0.35938 * group.width, y: group.minY + 0.07500 * group.height))
//        bezierPath.addCurve(to: CGPoint(x: group.minX + 0.34687 * group.width, y: group.minY + 0.06563 * group.height), controlPoint1: CGPoint(x: group.minX + 0.35938 * group.width, y: group.minY + 0.07500 * group.height), controlPoint2: CGPoint(x: group.minX + 0.35469 * group.width, y: group.minY + 0.06563 * group.height))
//        bezierPath.addCurve(to: CGPoint(x: group.minX + 0.28125 * group.width, y: group.minY + 0.07500 * group.height), controlPoint1: CGPoint(x: group.minX + 0.33437 * group.width, y: group.minY + 0.06563 * group.height), controlPoint2: CGPoint(x: group.minX + 0.30156 * group.width, y: group.minY + 0.06797 * group.height))
//        bezierPath.addCurve(to: CGPoint(x: group.minX + 0.26562 * group.width, y: group.minY + 0.09375 * group.height), controlPoint1: CGPoint(x: group.minX + 0.26719 * group.width, y: group.minY + 0.08125 * group.height), controlPoint2: CGPoint(x: group.minX + 0.26562 * group.width, y: group.minY + 0.09375 * group.height))
//        bezierPath.addLine(to: CGPoint(x: group.minX + 0.25625 * group.width, y: group.minY + 0.09375 * group.height))
//        bezierPath.addCurve(to: CGPoint(x: group.minX + 0.24375 * group.width, y: group.minY + 0.10313 * group.height), controlPoint1: CGPoint(x: group.minX + 0.25078 * group.width, y: group.minY + 0.09609 * group.height), controlPoint2: CGPoint(x: group.minX + 0.24688 * group.width, y: group.minY + 0.09375 * group.height))
//        bezierPath.addLine(to: CGPoint(x: group.minX + 0.24375 * group.width, y: group.minY + 0.12187 * group.height))
//        bezierPath.addLine(to: CGPoint(x: group.minX + 0.20625 * group.width, y: group.minY + 0.12187 * group.height))
//        bezierPath.addCurve(to: CGPoint(x: group.minX + 0.18438 * group.width, y: group.minY + 0.15625 * group.height), controlPoint1: CGPoint(x: group.minX + 0.18437 * group.width, y: group.minY + 0.12812 * group.height), controlPoint2: CGPoint(x: group.minX + 0.18438 * group.width, y: group.minY + 0.14062 * group.height))
//        bezierPath.close()
//        binFill.setFill()
//        bezierPath.fill()
//        UIColor.black.setStroke()
//        bezierPath.lineWidth = 10
//        bezierPath.lineCapStyle = .round
//        bezierPath.lineJoinStyle = .round
//        context.saveGState()
//        context.setLineDash(phase: 0, lengths: [32, 24])
//        bezierPath.stroke()
//        context.restoreGState()
//
//
//        //// Bezier 2 Drawing
//        let bezier2Path = UIBezierPath()
//        bezier2Path.move(to: CGPoint(x: group.minX + 0.50156 * group.width, y: group.minY + 0.23125 * group.height))
//        bezier2Path.addCurve(to: CGPoint(x: group.minX + 0.35313 * group.width, y: group.minY + 0.38125 * group.height), controlPoint1: CGPoint(x: group.minX + 0.41972 * group.width, y: group.minY + 0.23125 * group.height), controlPoint2: CGPoint(x: group.minX + 0.35313 * group.width, y: group.minY + 0.29854 * group.height))
//        bezier2Path.addCurve(to: CGPoint(x: group.minX + 0.50156 * group.width, y: group.minY + 0.53125 * group.height), controlPoint1: CGPoint(x: group.minX + 0.35313 * group.width, y: group.minY + 0.46396 * group.height), controlPoint2: CGPoint(x: group.minX + 0.41972 * group.width, y: group.minY + 0.53125 * group.height))
//        bezier2Path.addCurve(to: CGPoint(x: group.minX + 0.65000 * group.width, y: group.minY + 0.38125 * group.height), controlPoint1: CGPoint(x: group.minX + 0.58341 * group.width, y: group.minY + 0.53125 * group.height), controlPoint2: CGPoint(x: group.minX + 0.65000 * group.width, y: group.minY + 0.46396 * group.height))
//        bezier2Path.addCurve(to: CGPoint(x: group.minX + 0.50156 * group.width, y: group.minY + 0.23125 * group.height), controlPoint1: CGPoint(x: group.minX + 0.65000 * group.width, y: group.minY + 0.29854 * group.height), controlPoint2: CGPoint(x: group.minX + 0.58341 * group.width, y: group.minY + 0.23125 * group.height))
//        bezier2Path.close()
//        bezier2Path.move(to: CGPoint(x: group.minX + 0.51316 * group.width, y: group.minY + 0.45909 * group.height))
//        bezier2Path.addCurve(to: CGPoint(x: group.minX + 0.51085 * group.width, y: group.minY + 0.46142 * group.height), controlPoint1: CGPoint(x: group.minX + 0.51316 * group.width, y: group.minY + 0.46050 * group.height), controlPoint2: CGPoint(x: group.minX + 0.51223 * group.width, y: group.minY + 0.46142 * group.height))
//        bezier2Path.addLine(to: CGPoint(x: group.minX + 0.49326 * group.width, y: group.minY + 0.46142 * group.height))
//        bezier2Path.addCurve(to: CGPoint(x: group.minX + 0.49094 * group.width, y: group.minY + 0.45909 * group.height), controlPoint1: CGPoint(x: group.minX + 0.49186 * group.width, y: group.minY + 0.46142 * group.height), controlPoint2: CGPoint(x: group.minX + 0.49094 * group.width, y: group.minY + 0.46049 * group.height))
//        bezier2Path.addLine(to: CGPoint(x: group.minX + 0.49094 * group.width, y: group.minY + 0.43897 * group.height))
//        bezier2Path.addCurve(to: CGPoint(x: group.minX + 0.49326 * group.width, y: group.minY + 0.43664 * group.height), controlPoint1: CGPoint(x: group.minX + 0.49094 * group.width, y: group.minY + 0.43757 * group.height), controlPoint2: CGPoint(x: group.minX + 0.49186 * group.width, y: group.minY + 0.43664 * group.height))
//        bezier2Path.addLine(to: CGPoint(x: group.minX + 0.51085 * group.width, y: group.minY + 0.43664 * group.height))
//        bezier2Path.addCurve(to: CGPoint(x: group.minX + 0.51316 * group.width, y: group.minY + 0.43897 * group.height), controlPoint1: CGPoint(x: group.minX + 0.51224 * group.width, y: group.minY + 0.43664 * group.height), controlPoint2: CGPoint(x: group.minX + 0.51316 * group.width, y: group.minY + 0.43758 * group.height))
//        bezier2Path.addLine(to: CGPoint(x: group.minX + 0.51316 * group.width, y: group.minY + 0.45909 * group.height))
//        bezier2Path.close()
//        bezier2Path.move(to: CGPoint(x: group.minX + 0.53352 * group.width, y: group.minY + 0.36995 * group.height))
//        bezier2Path.addLine(to: CGPoint(x: group.minX + 0.51801 * group.width, y: group.minY + 0.39148 * group.height))
//        bezier2Path.addCurve(to: CGPoint(x: group.minX + 0.51199 * group.width, y: group.minY + 0.40901 * group.height), controlPoint1: CGPoint(x: group.minX + 0.51339 * group.width, y: group.minY + 0.39779 * group.height), controlPoint2: CGPoint(x: group.minX + 0.51199 * group.width, y: group.minY + 0.40106 * group.height))
//        bezier2Path.addLine(to: CGPoint(x: group.minX + 0.51199 * group.width, y: group.minY + 0.41649 * group.height))
//        bezier2Path.addCurve(to: CGPoint(x: group.minX + 0.50968 * group.width, y: group.minY + 0.41883 * group.height), controlPoint1: CGPoint(x: group.minX + 0.51199 * group.width, y: group.minY + 0.41790 * group.height), controlPoint2: CGPoint(x: group.minX + 0.51107 * group.width, y: group.minY + 0.41883 * group.height))
//        bezier2Path.addLine(to: CGPoint(x: group.minX + 0.49441 * group.width, y: group.minY + 0.41883 * group.height))
//        bezier2Path.addCurve(to: CGPoint(x: group.minX + 0.49209 * group.width, y: group.minY + 0.41651 * group.height), controlPoint1: CGPoint(x: group.minX + 0.49302 * group.width, y: group.minY + 0.41885 * group.height), controlPoint2: CGPoint(x: group.minX + 0.49209 * group.width, y: group.minY + 0.41792 * group.height))
//        bezier2Path.addLine(to: CGPoint(x: group.minX + 0.49209 * group.width, y: group.minY + 0.40693 * group.height))
//        bezier2Path.addCurve(to: CGPoint(x: group.minX + 0.49903 * group.width, y: group.minY + 0.38587 * group.height), controlPoint1: CGPoint(x: group.minX + 0.49209 * group.width, y: group.minY + 0.39756 * group.height), controlPoint2: CGPoint(x: group.minX + 0.49417 * group.width, y: group.minY + 0.39266 * group.height))
//        bezier2Path.addLine(to: CGPoint(x: group.minX + 0.51455 * group.width, y: group.minY + 0.36435 * group.height))
//        bezier2Path.addCurve(to: CGPoint(x: group.minX + 0.52542 * group.width, y: group.minY + 0.33978 * group.height), controlPoint1: CGPoint(x: group.minX + 0.52264 * group.width, y: group.minY + 0.35312 * group.height), controlPoint2: CGPoint(x: group.minX + 0.52542 * group.width, y: group.minY + 0.34774 * group.height))
//        bezier2Path.addCurve(to: CGPoint(x: group.minX + 0.50296 * group.width, y: group.minY + 0.31803 * group.height), controlPoint1: CGPoint(x: group.minX + 0.52542 * group.width, y: group.minY + 0.32645 * group.height), controlPoint2: CGPoint(x: group.minX + 0.51616 * group.width, y: group.minY + 0.31803 * group.height))
//        bezier2Path.addCurve(to: CGPoint(x: group.minX + 0.47890 * group.width, y: group.minY + 0.34025 * group.height), controlPoint1: CGPoint(x: group.minX + 0.49000 * group.width, y: group.minY + 0.31803 * group.height), controlPoint2: CGPoint(x: group.minX + 0.48167 * group.width, y: group.minY + 0.32598 * group.height))
//        bezier2Path.addCurve(to: CGPoint(x: group.minX + 0.47635 * group.width, y: group.minY + 0.34213 * group.height), controlPoint1: CGPoint(x: group.minX + 0.47866 * group.width, y: group.minY + 0.34166 * group.height), controlPoint2: CGPoint(x: group.minX + 0.47774 * group.width, y: group.minY + 0.34236 * group.height))
//        bezier2Path.addLine(to: CGPoint(x: group.minX + 0.46177 * group.width, y: group.minY + 0.33955 * group.height))
//        bezier2Path.addCurve(to: CGPoint(x: group.minX + 0.45991 * group.width, y: group.minY + 0.33697 * group.height), controlPoint1: CGPoint(x: group.minX + 0.46037 * group.width, y: group.minY + 0.33932 * group.height), controlPoint2: CGPoint(x: group.minX + 0.45968 * group.width, y: group.minY + 0.33838 * group.height))
//        bezier2Path.addCurve(to: CGPoint(x: group.minX + 0.50343 * group.width, y: group.minY + 0.29978 * group.height), controlPoint1: CGPoint(x: group.minX + 0.46339 * group.width, y: group.minY + 0.31452 * group.height), controlPoint2: CGPoint(x: group.minX + 0.47936 * group.width, y: group.minY + 0.29978 * group.height))
//        bezier2Path.addCurve(to: CGPoint(x: group.minX + 0.54532 * group.width, y: group.minY + 0.33954 * group.height), controlPoint1: CGPoint(x: group.minX + 0.52842 * group.width, y: group.minY + 0.29978 * group.height), controlPoint2: CGPoint(x: group.minX + 0.54532 * group.width, y: group.minY + 0.31638 * group.height))
//        bezier2Path.addCurve(to: CGPoint(x: group.minX + 0.53352 * group.width, y: group.minY + 0.36995 * group.height), controlPoint1: CGPoint(x: group.minX + 0.54532 * group.width, y: group.minY + 0.35077 * group.height), controlPoint2: CGPoint(x: group.minX + 0.54140 * group.width, y: group.minY + 0.35896 * group.height))
//        bezier2Path.close()
//        fillColor.setFill()
//        bezier2Path.fill()
//    }
//
//    //WARNING: Drawing method for 'WhichBin167' cannot be generated due to Trial limits.
//
//    //WARNING: Drawing method for 'WhichBin76' cannot be generated due to Trial limits.
//
//    //WARNING: Drawing method for 'WhichBin40' cannot be generated due to Trial limits.
//
//    //WARNING: Drawing method for 'WhichBin29' cannot be generated due to Trial limits.
//
//    //WARNING: Drawing method for 'WhichBin20' cannot be generated due to Trial limits.
//
//    //WARNING: Drawing method for 'WhichBin60' cannot be generated due to Trial limits.
//
//    //WARNING: Drawing method for 'Unknown' cannot be generated due to Trial limits.
//
//    //WARNING: Drawing method for 'Bin' cannot be generated due to Trial limits.
//
//    //// Generated Images
//
//    @objc dynamic public class func imageOfLeaf(isDarkMode: Bool = false) -> UIImage {
//        UIGraphicsBeginImageContextWithOptions(CGSize(width: 50, height: 50), false, 0)
//            WhichBin.drawLeaf(isDarkMode: isDarkMode)
//
//        let imageOfLeaf = UIGraphicsGetImageFromCurrentImageContext()!
//        UIGraphicsEndImageContext()
//
//        return imageOfLeaf
//    }
//
//    @objc dynamic public class func imageOfRecycle(isDarkMode: Bool = false) -> UIImage {
//        UIGraphicsBeginImageContextWithOptions(CGSize(width: 50, height: 50), false, 0)
//            WhichBin.drawRecycle(isDarkMode: isDarkMode)
//
//        let imageOfRecycle = UIGraphicsGetImageFromCurrentImageContext()!
//        UIGraphicsEndImageContext()
//
//        return imageOfRecycle
//    }
//
//    //WARNING: Image method for 'Unknown' cannot be generated due to Trial limits.
//    //WARNING: Image method for 'Bin' cannot be generated due to Trial limits.
//
//
//
//
//    @objc(WhichBinResizingBehavior)
//    public enum ResizingBehavior: Int {
//        case aspectFit /// The content is proportionally resized to fit into the target rectangle.
//        case aspectFill /// The content is proportionally resized to completely fill the target rectangle.
//        case stretch /// The content is stretched to match the entire target rectangle.
//        case center /// The content is centered in the target rectangle, but it is NOT resized.
//
//        public func apply(rect: CGRect, target: CGRect) -> CGRect {
//            if rect == target || target == CGRect.zero {
//                return rect
//            }
//
//            var scales = CGSize.zero
//            scales.width = abs(target.width / rect.width)
//            scales.height = abs(target.height / rect.height)
//
//            switch self {
//                case .aspectFit:
//                    scales.width = min(scales.width, scales.height)
//                    scales.height = scales.width
//                case .aspectFill:
//                    scales.width = max(scales.width, scales.height)
//                    scales.height = scales.width
//                case .stretch:
//                    break
//                case .center:
//                    scales.width = 1
//                    scales.height = 1
//            }
//
//            var result = rect.standardized
//            result.size.width *= scales.width
//            result.size.height *= scales.height
//            result.origin.x = target.minX + (target.width - result.width) / 2
//            result.origin.y = target.minY + (target.height - result.height) / 2
//            return result
//        }
//    }
//}