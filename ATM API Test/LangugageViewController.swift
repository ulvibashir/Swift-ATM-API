//
//  LangugageViewController.swift
//  ATM API Test
//
//  Created by Ulvi Bashirov on 10/13/20.
//

import UIKit

protocol LanguageControllerDelegate {
    func langSelection(lang: Languages)
}

class LangugageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    var delegate: LanguageControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        view.backgroundColor = .clear
        setUp()
    }
    
    func setUp() {
        height.constant = self.view.frame.height / 2
    }
    
    @IBAction func onCloseClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        print("asd")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Languages.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "languageCell", for: indexPath) as! LanguageTableViewCell
        cell.label.text = Languages.allCases[indexPath.row].rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.langSelection(lang: Languages.allCases[indexPath.row])
        dismiss(animated: true, completion: nil)
    }
}
