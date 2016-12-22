//
//  MapViewController.swift
//  HopJocky
//
//  Created by Vinh Nguyen on 3/22/16.
//  Copyright © 2016 cs378. All rights reserved.
//

import UIKit
import GoogleMaps
import Firebase

class MapViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {
    
    let locationManager = CLLocationManager()
    
    var mapTasks = MapTasks()
    
    var locationMarker: GMSMarker!
    
    var bars = [Bar]()
    
    var marker = GMSMarker()
    
    var markerSet = [NSObject]()
    
    

    @IBOutlet weak var viewMap: GMSMapView!
    
    @IBOutlet weak var searchBarTextField: UITextField!
    
    @IBAction func nearbySearch(sender: AnyObject) {

        self.viewMap.clear()
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            BARS_REF.observeEventType(.Value, withBlock: { snapshot in
                if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                    self.bars = []
                    for snap in snapshots{
                        if let barDict = snap.value as? Dictionary<String, AnyObject>{
                            //make our bars array for tableview
                            let barName = snap.key
                            let barObj = Bar(key: barName, dict: barDict)
                            let distance: CLLocationDegrees = self.checkDistanceFromUser(barObj.lat, longitude: barObj.lng)
                            print(String(distance) + " " + barObj.name)
                            if(distance <= 1000){
                                //insert new bar object into bar array
                                self.bars.append(barObj)
                            }
                        }
                    }
                    
                    for bar in self.bars {
                        let pin = GMSMarker()
                        pin.position = CLLocationCoordinate2DMake(bar.lat, bar.lng)
                        pin.title = bar.name
                        pin.snippet = bar.location
                        pin.map = self.viewMap
                    }
                    
                    
                }
            })
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBarTextField.delegate = self
        
        let camera: GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(48.857165, longitude: 2.354613, zoom: 10.0)
        viewMap.camera = camera
        
        self.locationManager.delegate = self
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if(CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse) {
            self.locationManager.startUpdatingLocation()
            viewMap.myLocationEnabled = true
            viewMap.settings.myLocationButton = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.searchBarTextField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func searchAddress(sender: AnyObject) {
        
        self.viewMap.clear()
        
        self.bars = []
        var pin = GMSMarker()
        
        let searchKey = searchBarTextField.text!
        self.bars = []
        
        self.search(searchKey, withCompletionHandler: { (status, success) -> Void in
            
            if !success {
                print(status)
                
                if status == "ZERO_RESULTS" {
                    self.showAlertWithMessage("The location could not be found.")
                }
            }
            else {
                print(status)
                
                let coordinate = CLLocationCoordinate2DMake(self.bars[0].lat, self.bars[0].lng);
                self.viewMap.camera = GMSCameraPosition.cameraWithTarget(coordinate, zoom: 10.0)
                for bar in self.bars {
                    pin = GMSMarker()
                    pin.position = CLLocationCoordinate2DMake(bar.lat, bar.lng)
                    pin.title = bar.name
                    pin.snippet = bar.location
                    pin.map = self.viewMap
                    
                }
            }
        })
    }
    
    func search(searchKey: String!, withCompletionHandler completionHandler: ((status: String, success: Bool) -> Void)) {
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            
            do {
                BARS_REF.observeEventType(.Value, withBlock: { snapshot in
                    if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                        self.bars = []
                        for snap in snapshots{
                            if let barDict = snap.value as? Dictionary<String, AnyObject>{
                                //make our bars array for tableview
                                let barName = snap.key
                                //insert new bar object into bar array
                                if barName == searchKey {
                                    self.bars.append(Bar(key: barName, dict: barDict))
                                }
                            }
                        }
                        if self.bars.count > 0 {
                            completionHandler(status: "OK", success: true)
                        } else {
                            BEERS_REF.observeEventType(.Value, withBlock: { snapshot in
                                if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                                    for snap in snapshots{
                                        if let beerDict = snap.value as? Dictionary<String, AnyObject>{
                                            //make our bars array for tableview
                                            let beerName = snap.key
                                            if beerName == searchKey {
                                                //insert new bar object into bar array
                                                let barsWithBeer = Firebase(url: "\(BASE_URL)/Beers/\(beerName)/BarsSold")
                                                barsWithBeer.queryOrderedByValue().observeEventType(.ChildAdded, withBlock: { snapshot in
                                                    let barSellsBeer = snapshot.key
                                                    BARS_REF.observeEventType(.Value, withBlock: { snapshot in
                                                        if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                                                            for snap in snapshots{
                                                                if let barDict = snap.value as? Dictionary<String, AnyObject>{
                                                                    //make our bars array for tableview
                                                                    let barName = snap.key
                                                                    //insert new bar object into bar array
                                                                    if barName == barSellsBeer {
                                                                        self.bars.append(Bar(key: barName, dict: barDict))
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        if self.bars.count > 0 {
                                                            print("good")
                                                            print(self.bars.count)
                                                            completionHandler(status: "OK", success: true)
                                                        } else {
                                                            print("bad")
                                                            print(self.bars.count)
                                                            completionHandler(status: "ZERO_RESULTS", success: false)
                                                        }
                                                    }) // END BARS_REF
                                                }) // END BARSWITHBEER
                                            }// END BEERNAME
                                        }// END BEERDICT
                                    } // END OUTER FORLOOP
                                } // END SNAPSHOT
                            }) // END BEEF_REF
                        }
                    }
                })
            } // END DO
        }) // END DISPATCH_ASYNC
    }

    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        if (status == .AuthorizedWhenInUse) {
            
            locationManager.startUpdatingLocation()
            viewMap.myLocationEnabled = true
            viewMap.settings.myLocationButton = true
            print("When in use")
        }
        else if (status == .AuthorizedAlways){
            locationManager.startUpdatingLocation()
            viewMap.myLocationEnabled = true
            viewMap.settings.myLocationButton = true
            print("Always")
        }
        else if (status == .NotDetermined){
            locationManager.requestWhenInUseAuthorization()
            print("IDK")
        }
        print("In didChangeAuthorization")
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("location = locations.first")
            viewMap.camera = GMSCameraPosition(target: location.coordinate, zoom: 8, bearing: 0, viewingAngle: 0)
            
            locationManager.stopUpdatingLocation()
        }
        print("didUpdateLocations")
    }
    
    func showAlertWithMessage(message: String) {
        let alertController = UIAlertController(title: "HopJocky", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel) { (alertAction) -> Void in
            
        }
        
        alertController.addAction(closeAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    func setupLocationMarker(coordinate: CLLocationCoordinate2D) {
        
        if locationMarker != nil {
            locationMarker.map = nil
        }
        
        locationMarker = GMSMarker(position: coordinate)
        
        locationMarker.map = viewMap
        
        locationMarker.title = mapTasks.title
        locationMarker.appearAnimation = kGMSMarkerAnimationPop
        locationMarker.opacity = 0.6
    }
    
    func checkDistanceFromUser(latitude: Double, longitude: Double) -> CLLocationDegrees {
        if(CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse) {
            
            locationManager.startUpdatingLocation()
            let barLocation = CLLocation(latitude: latitude, longitude: longitude)
            
            let distance = locationManager.location?.distanceFromLocation(barLocation)
            locationManager.stopUpdatingLocation()
            
            return distance!
        }
        
        return -1
    }
    
     // MARK: - Navigation
     
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 
 let ShowBarsFromMap = segue.destinationViewController as! ShowBarsFromMapTableViewController
 
 ShowBarsFromMap.bars = self.bars
 }
 
}
