//
//  ViewController.swift
//  DemoCoreLocation
//
//  Created by SHILEI CUI on 3/26/19.
//  Copyright © 2019 scui5. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var appleMap: MKMapView!
    var locationManager = CLLocationManager()
    var rect: MKMapRect = MKMapRect.null
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupLocation()
        //setupCordinate()
        localSearchApi()
        appleMap.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func mapView(_ appleMap: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var anoView : MKAnnotationView?
        if let pinView = appleMap.dequeueReusableAnnotationView(withIdentifier: "whitepinid") {
            anoView = pinView
            anoView?.annotation = annotation
        } else {
            anoView = MKAnnotationView(annotation: annotation, reuseIdentifier: "whitepinid")
            anoView?.image = UIImage(named: "whitepin")
            anoView?.canShowCallout = true
        }
        return anoView
    }
    
    func setupCordinate(coordinate : CLLocationCoordinate2D, title : String){
        let dropPin = MKPointAnnotation()
        //let a = MKAnnotation()
        
        
        dropPin.coordinate = coordinate
        dropPin.title = title
        appleMap.addAnnotation(dropPin)
        //mapView(appleMap, viewFor: dropPin)
        //can also define array of annotation use appleMap.addAnnotations([MKAnnotation])
        //appleMap.addAnnotation(dropPin)
        

        //setupZoomLevel(loc: location)
        //localSearchApi()
    }
    
    
    func localSearchApi(){
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Food"
        request.region = appleMap.region
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            guard let respo = response else{
                print(error?.localizedDescription)
                return
            }
            
            // Create array of points from coordinates
            let coords = respo.mapItems.map({MKMapPoint($0.placemark.coordinate)})
            // Create MapRects and union them all together
            let rect = coords.reduce(MKMapRect.null, { (res, coord) -> MKMapRect in
                res.union(MKMapRect(origin: coord, size: MKMapSize()))
            })
            // Form region from union
            let region = MKCoordinateRegion(rect)
            
            
            for i in respo.mapItems{
                let coordinate = i.placemark.coordinate
                self.setupCordinate(coordinate: coordinate, title: i.name!)
                
                let point: MKMapPoint = MKMapPoint(i.placemark.coordinate)
                self.rect = self.rect.union(MKMapRect(x: point.x, y: point.y, width: 0, height: 0))
            }
            
            //self.appleMap.setRegion(region, animated: true)
            
            self.appleMap.setVisibleMapRect(self.rect, animated: true)
            self.appleMap.setVisibleMapRect(self.rect, edgePadding: UIEdgeInsets(top: 40.0, left: 40.0, bottom: 40.0, right: 40.0), animated: true)

            print(respo.mapItems.count)
        }
    }
    
//    func setupZoomLevel(loc : CLLocation){
//        let span = MKCoordinateSpan(latitudeDelta: 0.28, longitudeDelta: 0.22)
//        //let region1 = MKCoordinateRegion(makeRect(coordinates: loc))
//        let region = MKCoordinateRegion(center: loc.coordinate, span: span)
//        appleMap.setRegion(region, animated: true)
//    }

    func setupLocation(){
        
        locationManager.requestWhenInUseAuthorization()
        //locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            locationManager.startUpdatingLocation()
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loc = locations.last{
            //print(loc)
            getCityName(loc: loc)
           // print(loc.coordinate)
            locationManager.stopUpdatingLocation()
        }
    }
    
    func getCityName(loc:CLLocation) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(loc) { (placemarks, error) in
            if let place = placemarks?.last{
                print(place.locality!)
            }
        }
    }

}

