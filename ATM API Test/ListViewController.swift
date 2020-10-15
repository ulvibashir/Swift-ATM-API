//
//  ListViewController.swift
//  ATM API Test
//
//  Created by Ulvi Bashirov on 10/12/20.
//

import UIKit
import ProgressHUD

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var ATMtableView: UITableView!
    
    let activity: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.backgroundColor = .white
        view.hidesWhenStopped = true
        return view
    }()
    
    var currentLang: Languages = .AZ
    var selectedLang: Languages?
    var data: [ATM]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        getData(lang: currentLang.rawValue)
    }
    
    func setUp() {
        ATMtableView.dataSource = self
        ATMtableView.delegate = self
        activity.frame = self.view.bounds
        self.view.addSubview(activity)
        ProgressHUD.animationType = .circleRotateChase
        
        navigationItem.title = "List"
        self.setLanguageButton(lang: currentLang.rawValue)
    }
    
    override func onClick() {
        let vc = storyboard?.instantiateViewController(identifier: "languageVC") as! LangugageViewController
        vc.delegate = self
        vc.modalPresentationStyle = .fullScreen
        navigationController?.present(vc, animated: true)
    }
    
    @objc func btnClick() {
        print("list click")
    }

    func getData(lang: String) {
//        ProgressHUD.show("Loading")
        activity.startAnimating()
        data?.removeAll()
        ATMtableView.reloadData()
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { _ in
            APIalamofire.getDataFromApi(lang: lang) { result in
                self.data = result.data
                DispatchQueue.main.async {
                    self.ATMtableView.reloadData()
                    self.activity.stopAnimating()
                    
//                    ProgressHUD.dismiss()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ATMtableView.dequeueReusableCell(withIdentifier: "atmCell", for: indexPath) as! ATMTableViewCell
        cell.nameLabel.text = data?[indexPath.row].name
        cell.adressLabel.text = data?[indexPath.row].address
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
}

extension ListViewController: LanguageControllerDelegate {
    func langSelection(lang: Languages) {
        getData(lang: lang.rawValue)
        changeLangLabel(lang: lang.rawValue)
    }
}
