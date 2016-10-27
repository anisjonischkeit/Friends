//
//  MapViewController.swift
//  Friends
//
//  Created by Anis on 25/05/2016.
//  Copyright © 2016 Anis. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var textField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    var friend : Friend!
    
    // sets the map to the friend's address
    override func viewWillAppear(animated: Bool) {
        goToAddress(friend.address)
    }
    
//    sets the textfield and the title
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        
        navigationItem.title = "Address"
        textField.text = friend.address
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // if the user hits return, find the address and zoom in on it
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        goToAddress(textField.text!)
        return true
    }
    
    // MARK: - Navigation
    
    // saves the address
    override func viewWillDisappear(animated: Bool) {
        friend.address = textField.text!
    }
    
    //function that gets a string from user input, finds the coresponding coordinates, then goes to that area on the map
    func goToAddress(address: String) {
        CLGeocoder().geocodeAddressString(address, completionHandler: { (placemarks, error) in
            if error != nil {
                print(error)
                return
            }
            if placemarks?.count > 0 {
                let placemark = placemarks?[0]
                let location = placemark?.location
                let coordinate = location?.coordinate
                let regionRadius: CLLocationDistance = 1000
                
                if coordinate != nil {
                    let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate!, regionRadius * 2.0, regionRadius * 2.0)
                    self.mapView.setRegion(coordinateRegion, animated: true)
                }
                
                
            }
        })
    }
}
