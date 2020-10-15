//
//  ATMTableViewCell.swift
//  ATM API Test
//
//  Created by Ulvi Bashirov on 10/8/20.
//

import UIKit

class ATMTableViewCell: UITableViewCell {
    @IBOutlet weak var uiView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
    }
    
    func setUp() {
        addTapGesture()
        uiView.backgroundColor = UIColor.white
        uiView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        uiView.layer.shadowOffset = CGSize(width: 4.0, height: 7.0)
        uiView.layer.shadowOpacity = 3.0
        uiView.layer.shadowRadius = 7.0
        uiView.layer.masksToBounds = false
        uiView.layer.cornerRadius = 15.0
    }
    
    func addTapGesture() {
        let tap = UILongPressGestureRecognizer(target: self, action: #selector(doSomething))
        uiView.addGestureRecognizer(tap)
    }

    @objc func doSomething() {
        print("click")
    }
}
