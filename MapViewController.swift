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

protocol MapViewControllerDelegate {
//    func save(friend : Friend)
}

class MapViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var textField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    var delegate : MapViewControllerDelegate!
    var friend : Friend!
    
    override func viewWillAppear(animated: Bool) {
        goToAddress(friend.address)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.text = friend.address
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        goToAddress(textField.text!)
        return true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewWillDisappear(animated: Bool) {
        friend.address = textField.text!
    }
    
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
