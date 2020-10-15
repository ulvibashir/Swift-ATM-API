//
//  ViewController.swift
//  ATM API Test
//
//  Created by Ulvi Bashirov on 10/8/20.
//

import UIKit
import ProgressHUD

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var langButton: UIButton!
    @IBOutlet weak var langImage: UIImageView!
    @IBOutlet weak var ATMtableView: UITableView!
    @IBOutlet weak var viewBottomConstraint: NSLayoutConstraint!
    
    let activity: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.backgroundColor = .white
        view.hidesWhenStopped = true
        return view
    }()
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    var currentLang: Languages = .AZ
    var selectedLang: Languages?
    var data: [ATM]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        getData(lang: currentLang.rawValue)
        
        
    }
    
    func setUp() {
        langButton.setTitle(currentLang.rawValue, for: .normal)
        langImage.image = UIImage(named: currentLang.rawValue)
        ATMtableView.dataSource = self
        ATMtableView.delegate = self
        pickerView.delegate = self
        pickerView.dataSource = self
        activity.frame = self.view.bounds
        self.view.addSubview(activity)
        ProgressHUD.animationType = .circleRotateChase
        
    }
    
    func getData(lang: String) {
//        activity.startAnimating()
        ProgressHUD.show("Loading")
        
        
        data?.removeAll()
        ATMtableView.reloadData()
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { _ in
//            API.getDataFromApi(lang: lang) { (result) in
//                self.data = result.data
//                DispatchQueue.main.async {
//                    self.ATMtableView.reloadData()
//                    self.activity.stopAnimating()
//                }
//            }
            APIalamofire.getDataFromApi(lang: lang) { result in

                self.data = result.data
                DispatchQueue.main.async {
                    self.ATMtableView.reloadData()
//                    self.activity.stopAnimating()
                    ProgressHUD.dismiss()
                }
                
            }
        }
    }
    
    @IBAction func langBtnOnClick(_ sender: Any) {
        animShow()
    }
    
    @IBAction func hideViewButtonTapped(_ sender: Any) {
        animHide()
        if selectedLang != currentLang {
            if let lang = selectedLang {
                getData(lang: lang.rawValue)
                currentLang = selectedLang!
                langButton.setTitle(currentLang.rawValue, for: .normal)
                langImage.image = UIImage(named: currentLang.rawValue)
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
    
    func animShow(){
        UIView.animate(withDuration: 0.3) {
            self.viewBottomConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    func animHide(){
        UIView.animate(withDuration: 0.3) {
            self.viewBottomConstraint.constant = 250
            self.view.layoutIfNeeded()
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Languages.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Languages.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedLang = Languages.allCases[row]
    }
}
