//
//  CustomFeaturedContentView.swift
//  OCKSample
//
//  Created by Corey Baker on 11/29/22.
//  Copyright © 2022 Network Reconnaissance Lab. All rights reserved.
//

import UIKit
import CareKit
import CareKitUI

// look at parent class to figure out how to set text on custom content view

/// A simple subclass to take control of what CareKit already gives us.
class CustomFeaturedContentView: OCKFeaturedContentView {

    var url: URL?

    // Need to override so we can become delegate when the user taps on card
    override init(imageOverlayStyle: UIUserInterfaceStyle = .unspecified) {

        // See that this always calls the super
        super.init(imageOverlayStyle: imageOverlayStyle)

        // TODOx: 1 - Need to become a "delegate" so we know when view is tapped.
        // hint: this is one line
        self.delegate = self
    }
    /*
    // A convenience initializer to make it easier to use our custom featured content
    convenience init(url: String, imageOverlayStyle: UIUserInterfaceStyle = .unspecified) {
        
        // TODOx: 2 - Need to call the designated initializer
            
        // TODOx: 3 - Need to turn the url string into a real URL using URL(string: String)
        
    }
     */
}
/// Need to conform to delegate in order to be delegated to.
extension CustomFeaturedContentView: OCKFeaturedContentViewDelegate {

    func didTapView(_ view: OCKFeaturedContentView) {

            // When tapped open a URL.
            guard let url = url else {
                return
            }
            DispatchQueue.main.async {
                UIApplication.shared.open(url)
            }
        }
}
