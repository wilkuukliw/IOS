//
//  ViewController.swift
//  MapDemo
//
//  Created by Anna Maria on 20/03/2020.
//  Copyright © 2020 Anna Maria. All rights reserved.
//

import UIKit
import MapKit
import FirebaseFirestore
import CoreLocation


class ViewController: UIViewController {
    

    @IBOutlet weak var map: MKMapView!
    
    var firebaseManager:FirebaseManager?
    let locationManager = CLLocationManager() // will handle location (GPS,WiFi) updates
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // ask user to approve location sharing with the app
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer // how precise do you want it?
        locationManager.startUpdatingLocation() // start getting location data from device in a continous stream
        //createDemoMarker()   // begining of the classs, demo purposes
        FirebaseRepo.startListener(vc:self)
        map.showsUserLocation = true
        
    }
    
    func updateMarkers(snap: QuerySnapshot) { // now we get raw data from the Firebase
        let markers = MapDataAdapter.getMKAnnotationsFromData(snap: snap)    //calling adapter to convert data
        print("updating markers...")
        map.removeAnnotations(map.annotations)// clear the map from previous annotations
        map.addAnnotations(markers)

        }
    
    //enable the user to long-click anywhere on the map to create a new marker.
    @IBAction func longPressed(_ gestureReconizer: UILongPressGestureRecognizer) {
        
        if gestureReconizer.state == .ended { //limit amount of calls to just ONE
            let location = gestureReconizer.location(in: map) // receive the click on the map&get the Latitude and Longitude from this click
            let coordinate = map.convert(location,toCoordinateFrom: map) //onvert to latitude and longitutde
        // Add the pop up alert to get user input
            let alert = UIAlertController(title: "Provide a name", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addTextField(configurationHandler: { (textField) in textField.placeholder = "Input location name here..."
            })
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                
                if let name = alert.textFields?.first?.text {
                print("Name of place: \(name)")
                let annotation = MKPointAnnotation()
                annotation.title = name
                annotation.coordinate = coordinate
                // Add annotation:
                self.map.addAnnotation(annotation)
                // Save the marker to Firebase
                FirebaseRepo.addMarker(marker: annotation)
            }
            
            }))
        
            self.present(alert, animated: true, completion: nil)
        
        }
    }
    
    @IBAction func stopUpdate(_ sender: Any) {
        locationManager.stopUpdatingLocation()
    }
    
    @IBAction func startUpdate(_ sender: Any) {
        locationManager.startUpdatingLocation()
    }
    
    @IBAction func signOutPressed(_ sender: UIButton) {
        // warning: Do not hide content based on this call. Do that in the listener
        firebaseManager?.signOut()
        }
}
extension ViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("new location \(locations.first?.coordinate)")
        if let coord = locations.last?.coordinate {
            let region = MKCoordinateRegion(center: coord, latitudinalMeters: 300, longitudinalMeters: 300)
            map.setRegion(region, animated: true)   //will move the camera
            
        }
    }
}
