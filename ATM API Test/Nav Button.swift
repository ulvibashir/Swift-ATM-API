//
//  File.swift
//  ATM API Test
//
//  Created by Ulvi Bashirov on 10/13/20.
//

import Foundation
import UIKit

struct NavBarButton {
    
    static func getNavBarButton(title: String, handler: Selector) -> UIBarButtonItem {
        let btn = UIBarButtonItem(title: title, style: .plain, target: self, action: handler)
        return btn
    }
    
}
