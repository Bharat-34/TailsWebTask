//
//  Annotations.swift
//  TailsWebTask
//
//  Created by Bharat on 11/11/20.
//

import Foundation
import MapKit

class myAnnitation: NSObject, MKAnnotation {

    var coordinate: CLLocationCoordinate2D
    var title : String?
    var subTitle : String?
    
    init(title : String, subTitle : String, coordinate : CLLocationCoordinate2D) {
        
        self.title = title
        self.subTitle = title
        self.coordinate = coordinate
    }
    
}
