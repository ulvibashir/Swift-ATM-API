//
//  NavBarExtension.swift
//  ATM API Test
//
//  Created by Ulvi Bashirov on 10/13/20.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setLanguageButton(lang: String) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: lang, style: .plain, target: self, action: #selector(onClick))
    }
    func changeLangLabel(lang: String) {
        navigationItem.rightBarButtonItem?.title = lang
    }
    @objc func onClick() {
        
    }
}
