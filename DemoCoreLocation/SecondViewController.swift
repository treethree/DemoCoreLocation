//
//  SecondViewController.swift
//  DemoCoreLocation
//
//  Created by SHILEI CUI on 3/26/19.
//  Copyright © 2019 scui5. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit
import CoreLocation

class SecondViewController: UIViewController ,GMSMapViewDelegate, CLLocationManagerDelegate{

    var arrLocation : Array<CLLocation> = []
    @IBOutlet weak var viewGms: GMSMapView!
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //viewGms.mapType = .satellite
        viewGms.mapType = .normal
        setupLocation()
        // Do any additional setup after loading the view.
    }
    
    func setupLocation(){
        locationManager.requestWhenInUseAuthorization()
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
        //locations.last is latest position
        let loc = locations.last
        print(loc!)
        
        createPath(cord: loc!.coordinate)
        viewGms.camera = GMSCameraPosition.camera(withTarget: loc!.coordinate, zoom: 15)
    }

    
//    func setupCordinate(loc : CLLocation){
//        //let location = CLLocation(latitude: 43.4343, longitude: -120.3434)
//        let marker = GMSMarker()
//        marker.title = "One Location"
//        marker.position = loc.coordinate
//        marker.map = viewGms
//        marker.isDraggable = true
//        //marker.icon = UIImage(named: "whitepin")
//
////        let location2 = CLLocation(latitude: 44.4343, longitude: -121.3434)
////        let marker2 = GMSMarker()
////        marker2.title = "Second Location"
////        marker2.position = location2.coordinate
////        marker2.map = viewGms
////        marker2.isDraggable = true
//
////        viewGms.camera = GMSCameraPosition.camera(withTarget: marker.position, zoom: 15)
//        //arrLocation.append(loc)
////        arrLocation.append(location2)
//
//        //locationManager(locationManager, didUpdateLocations: arrLocation)
////        for loca in arrLocation{
////            createPath(cord: loca.coordinate)
////        }
////        setupBounds()
//    }
    
    //Set the camera position for polyline
    func setupBounds(){
        let bounds = GMSCoordinateBounds(path: gmspath)
        let update = GMSCameraUpdate.fit(bounds)
        viewGms.moveCamera(update)
        viewGms.setMinZoom(viewGms.minZoom, maxZoom: viewGms.maxZoom)
    }
    
    var polyline = GMSPolyline()
    var gmspath = GMSMutablePath()
    
    func createPath(cord: CLLocationCoordinate2D){
        gmspath.add(cord)
        polyline.path = gmspath
        polyline.strokeColor = UIColor.red
        polyline.strokeWidth = 5.0
        polyline.map = viewGms
    }


}
