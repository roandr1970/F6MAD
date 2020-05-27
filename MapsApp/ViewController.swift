//
//  ViewController.swift
//  MapsApp
//
//  Created by user on 5/26/20.
//  Copyright © 2020 rodionov. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let manager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.activityType = .fitness
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter =  1
        locationManager.showsBackgroundLocationIndicator = true
        locationManager.pausesLocationUpdatesAutomatically = true
        return locationManager
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        manager.delegate = self
        authorization()
        manager.startUpdatingLocation()
        pointsOnMap()
    }
    
    func pointsOnMap() {
        let arrayLat = [56.81, 54.81, 55.31]
        let arrayLon = [37.49, 38.00, 36.91]
        if arrayLat.count == arrayLon.count {
            for i in 0..<arrayLat.count {
                let point = MKPointAnnotation()
                point.title = ""
                point.coordinate = CLLocationCoordinate2D(latitude: arrayLat[i], longitude: arrayLon[i])
                    self.mapView.addAnnotation(point)
            }
        }
    }
    
    func authorization(){
        if CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        }else {
            manager.requestWhenInUseAuthorization()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations {
            print(location.coordinate)
        }
    }
}

