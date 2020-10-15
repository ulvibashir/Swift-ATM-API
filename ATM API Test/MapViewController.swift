//
//  MapViewController.swift
//  ATM API Test
//
//  Created by Ulvi Bashirov on 10/12/20.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        getData(lang: "AZ")
    }
    var data: [ATM]?
    
    @IBOutlet weak var mapView: MKMapView!
    
    func setUp() {
        navigationItem.title = "Map"
        self.setLanguageButton(lang: "AZ")
    }
    
    func getData(lang: String) {
        APIalamofire.getDataFromApi(lang: lang) { result in
            self.data = result.data
            self.setPins()
        }
    }
    
    func setPins() {
        for place in data! {
            let annotations = MKPointAnnotation()
            annotations.title = place.name
            annotations.coordinate = CLLocationCoordinate2D(
                latitude: Double(place.latitude ?? 0),
                longitude: Double(place.longitude ?? 0))
            mapView.addAnnotation(annotations)
        }
    }
    
}
