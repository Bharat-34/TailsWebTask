//
//  Coordinates.swift
//  TailsWebTask
//
//  Created by Bharat on 11/11/20.
//

import Foundation
import FirebaseFirestore

protocol DocumentSerializable  {
    init?(dictionary:[String:Any])
}

struct Location {
    
    var sourceLattitude : Double
    var sourceLongitude : Double
    var destnLattitude : Double
    var destnLongitude : Double
    var timeStamp : Date
    
    var dictionary : [String:Any] {
        return [
            "sourceLattitude" : sourceLattitude,
            "sourceLongitude" : sourceLongitude,
            "destnLattitude" : destnLattitude,
            "destnLongitude" : destnLongitude,
            "timeStamp" : timeStamp
        ]
    }
}

extension Location : DocumentSerializable {
    init?(dictionary: [String : Any]) {
        guard let sourceLattitude = dictionary["sourceLattitude"] as? Double,
              let sourceLongitude = dictionary["sourceLongitude"] as? Double,
              let destnLattitude = dictionary["destnLattitude"] as? Double,
              let destnLongitude = dictionary["destnLongitude"] as? Double,
              let timeStamp = dictionary["timeStamp"] as? Date else { return nil}
        
        self.init(sourceLattitude: sourceLattitude, sourceLongitude: sourceLongitude, destnLattitude: destnLattitude, destnLongitude: destnLongitude, timeStamp: timeStamp)
    }
    

}
