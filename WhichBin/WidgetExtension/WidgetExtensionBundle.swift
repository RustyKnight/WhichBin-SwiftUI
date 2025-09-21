//
//  WidgetExtensionBundle.swift
//  WidgetExtension
//
//  Created by Shane Whitehead on 20/9/2025.
//

import WidgetKit
import SwiftUI

@main
struct WidgetExtensionBundle: WidgetBundle {
    var body: some Widget {
        WidgetExtension()
        WidgetExtensionControl()
        WidgetExtensionLiveActivity()
    }
}
