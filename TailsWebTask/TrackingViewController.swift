//
//  TrackingViewController.swift
//  TailsWebTask
//
//  Created by Bharat on 11/11/20.
//

import UIKit
import MapKit
import CoreLocation
import FirebaseFirestore

class TrackingViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var trackingBtn: UIButton!
    
    let location_Manager = CLLocationManager()
    var myLocations: [CLLocation] = []

    var sourceIndex = Int()
    var c1 = CLLocationCoordinate2D()

    var locationArr = [CLLocationCoordinate2D]()
    var point : myAnnitation!
    var point1 : myAnnitation!

    var timer1: Timer?
    var totalTime = 0
      
    var db:Firestore!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()

    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0]
        myLocations.append(location)

        let span : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        let mylocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        let region : MKCoordinateRegion = MKCoordinateRegion(center: mylocation, span: span)
        
        mapView.setRegion(region, animated: true)
        self.mapView.showsUserLocation = true
        
        
        
        if myLocations.count > 1 {
            
            
            sourceIndex = myLocations.count - 1
            c1 = myLocations[sourceIndex].coordinate
            locationArr.append(c1)
            
            
            
            print("locationArr\(locationArr)")
                        
            if(locationArr.count > 1)
            {
                let polyline = MKPolyline(coordinates:locationArr, count: locationArr.count)
                mapView.addOverlay(polyline)
                
                
                
            }
            
            let latt = locationArr.first?.latitude
            let longg = locationArr.first?.longitude
            let Annolocation = CLLocationCoordinate2D(latitude: latt!, longitude: longg!)
            point = myAnnitation.init(title: "", subTitle: "", coordinate: Annolocation)
            self.mapView.addAnnotation(point)
            
            let latt1 = locationArr.last?.latitude
            let longg1 = locationArr.last?.longitude
            let Annolocation1 = CLLocationCoordinate2D(latitude: latt1!, longitude: longg1!)
            point1 = myAnnitation.init(title: "", subTitle: "", coordinate: Annolocation1)
            self.mapView.addAnnotation(point1)
            

    }
        
        if let SorceLattitude = locationArr.first?.latitude, let SorceLongitude = locationArr.first?.longitude, let destnLattitude = locationArr.last?.latitude, let destinLongitude = locationArr.last?.longitude {
            
          //  let newLocation = Location(lattitude: lattitude, longitude: longitude, timeStamp: Date())
            let newLocation = Location(sourceLattitude: SorceLattitude, sourceLongitude: SorceLongitude, destnLattitude: destnLattitude, destnLongitude: destinLongitude, timeStamp: Date())
            
            var ref:DocumentReference? = nil
            
            ref = self.db.collection("Coordinates1").addDocument(data: newLocation.dictionary) { error in
                
                if let error = error {
                    print("error adding documment : \(error.localizedDescription)")
                } else {
                    print("documment added with ID : \(ref!.documentID)")
                }
                
            }
            
        }
        
}
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {

        if let polyline = overlay as? MKPolyline {
            let testlineRenderer = MKPolylineRenderer(polyline: polyline)
            testlineRenderer.strokeColor = .black
            testlineRenderer.lineWidth = 3.0
            return testlineRenderer
        }

        fatalError("Something wrong...")
        
    }
    
    
    // Timer Functionality
    
    @IBAction func startTracking(_ sender: UIButton) {
        

        if sender.isSelected {
            
            sender .isSelected = false
           
            location_Manager.stopUpdatingLocation()
            timer1?.invalidate()
            self.dismiss(animated: false, completion: nil)
            
        } else {
        
            sender.isSelected = true
            location_Manager.delegate = self
            location_Manager.desiredAccuracy = kCLLocationAccuracyBest
            location_Manager.requestWhenInUseAuthorization()
            location_Manager.startUpdatingLocation()
            

            
            mapView.showsUserLocation = true
            mapView.delegate = self
            startOtpTimer()
            

        }
        
        
    }
    
    private func startOtpTimer() {
        self.totalTime = 0
        self.timer1 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        print(self.totalTime)
        let time = self.timeFormatted(self.totalTime) // will show timer
        print("mmmmmmmm \(time)")
        self.timeLabel.text = "\(time)"
        totalTime += 1  // decrease counter time
        
        if totalTime == 3600 {
            totalTime = 0
        }
        
    }
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60)
        return String(format: "%02d:%02d", minutes, seconds)
    }
 
    
    
}


