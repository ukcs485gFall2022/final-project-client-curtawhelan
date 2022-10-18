//
//  ColorStyler.swift
//  OCKSample
//
//  Created by Corey Baker on 10/16/21.
//  Copyright © 2021 Network Reconnaissance Lab. All rights reserved.
//

import Foundation
import CareKitUI
import UIKit

struct ColorStyler: OCKColorStyler {
    #if os(iOS)
    var label: UIColor {
        FontColorKey.altValue
    }
    var secondaryLabel: UIColor {
        FontColorKey.altValue
    }
    var tertiaryLabel: UIColor {
        TintColorKey.altValue
    }
    var customBackground: UIColor {
        TintColorKey.altValue
    }
    #endif
}
