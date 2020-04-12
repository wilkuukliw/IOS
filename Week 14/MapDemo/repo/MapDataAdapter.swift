//
//  MapDataAdapter.swift
//  MapDemo
//
//  Created by Anna Maria on 20/03/2020.
//  Copyright © 2020 Anna Maria. All rights reserved.
//

import Foundation
import MapKit
import FirebaseFirestore

class MapDataAdapter {
    
    static func getMKAnnotationsFromData(snap:QuerySnapshot) -> [MKPointAnnotation]{   //this is just a helper, we can make it static, an call it statically then 
        var markers = [MKPointAnnotation]()   //create an empty list
        for doc in snap.documents {
            print("received data: ")
            let map = doc.data() // here the data is delivered in a map
            let text = map["text"] as! String
            let geoPoint = map["coordinates"] as! GeoPoint
            let coordinates = map["coordinates"] as? GeoPoint ?? GeoPoint(latitude: 0, longitude: 0)   //Radu's suggestion to overcome error with retrieving the field from Firestore
            print(coordinates)   // coordinates printed to the console
            let mkAnnotation = MKPointAnnotation()
            mkAnnotation.title = text
            let coordinate = CLLocationCoordinate2D(latitude: geoPoint.latitude, longitude: geoPoint.longitude)
            mkAnnotation.coordinate = coordinate
            markers.append(mkAnnotation)
        }
       return markers
    }
    static func getGeoPoint(lat:Double, lon:Double) -> GeoPoint{
        return GeoPoint(latitude: lat, longitude: lon)
        
    }
}
