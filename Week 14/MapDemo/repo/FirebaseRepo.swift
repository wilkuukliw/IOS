//
//  FirebaseRepo.swift
//  MapDemo
//
//  Created by Anna Maria on 20/03/2020.
//  Copyright © 2020 Anna Maria. All rights reserved.
//

import Foundation
import FirebaseFirestore
import MapKit

class FirebaseRepo {
  
    private static let db = Firestore.firestore() // instance of db
    private static let path = "locations"
    
    static func startListener(vc: ViewController) {
        print("listener started")

        db.collection(path).addSnapshotListener { (snap, error) in
            if error != nil {  //check if there is an error, if so then return
                return
            }
            
            if let snap = snap {  // we check if the snap has a value.    // is snap does have a value, it is reasigned to another variable, also called snap, this is a way of unwrapping the snap Optional
            vc.updateMarkers(snap: snap)
            }
        }
    }

    static func addMarker(marker: MKPointAnnotation){
        
        let coordinates = GeoPoint(latitude: marker.coordinate.latitude, longitude: marker.coordinate.longitude)
        
        let ref = db.collection(path).document().setData([    //add a new document in Firebase collection
            "coordinates": coordinates,
            "text": marker.title ?? "Name",
            ])
    }
    
}
