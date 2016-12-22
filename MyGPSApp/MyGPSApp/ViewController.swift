//
//  ViewController.swift
//  MyGPSApp
//
//  Created by Vinh Nguyen on 3/21/16.
//  Copyright © 2016 Vinh Nguyen. All rights reserved.
//

import UIKit
import GoogleMaps


class ViewController: UIViewController, GMSMapViewDelegate {

//    var firstLocationUpdate: Bool?
//    let locationManager=CLLocationManager()
    
//    @IBOutlet var mapView: GMSMapView!
    var mapView: GMSMapView!
    
//    func mapView(mapView: GMSMapView!, didChangeCameraPosition position: GMSCameraPosition!) {
//        print(position)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.locationManager.requestWhenInUseAuthorization()
        
        let camera = GMSCameraPosition.cameraWithLatitude(30.28565, longitude: -97.73921, zoom: 10)
        mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        mapView.settings.compassButton = true
        mapView.settings.myLocationButton = true
        
        mapView.addObserver(self, forKeyPath: "myLocation", options: .New, context: nil)
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.mapView.myLocationEnabled = true
        })
        
        print("1")
        print(mapView.myLocation)
        print("10")
        view = mapView
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(30.28565, -97.73921)
        marker.title = "UT Tower"
        marker.snippet = "UT Austin"
        marker.map = mapView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

