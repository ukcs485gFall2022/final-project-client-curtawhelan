//
//  MyContactView.swift
//  OCKSample
//
//  Created by Curt Whelan on 11/29/22.
//  Copyright © 2022 Network Reconnaissance Lab. All rights reserved.
//

import SwiftUI
import UIKit
import CareKitStore
import CareKit
import os.log

struct MyContactView: UIViewControllerRepresentable {

    @State var storeManager = StoreManagerKey.defaultValue

    func makeUIViewController(context: Context) -> some UIViewController {
        let viewController = MyContactViewController(storeManager: storeManager)
        return UINavigationController(rootViewController: viewController)
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType,
                                context: Context) {

    }
}

struct MyContactView_Previews: PreviewProvider {
    static var previews: some View {
        MyContactView(storeManager: Utility.createPreviewStoreManager())
            .accentColor(Color(TintColorKey.defaultValue))
    }
}
