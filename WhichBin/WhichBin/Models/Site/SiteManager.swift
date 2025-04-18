//
//  SiteManager.swift
//  WhichBin
//
//  Created by Shane Whitehead on 18/4/2025.
//

import SwiftUI

class SiteManager: ObservableObject {

    @Published
    private(set) var sites: [Site] = []
}
