//
//  ViewController.swift
//  CoreLocationExam
//
//  Created by youngjun goo on 12/03/2019.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var locationTapButton: UIButton!
    @IBOutlet weak var latitudeLabel: UILabel!      // 위도
    @IBOutlet weak var longitudeLabel: UILabel!     // 경도
    
    @IBAction func getCurrentLocationTapped(_ sender: Any) {
        retriveCurrentLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        // after showing the permission dialog, the program will continue executing the next line before the user has tap 'Allow' or 'Disallow'
        
        // if previously user has allowed the location permission, then request location
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways){
            locationManager.requestLocation()
        }
    }

}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
    
    private func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == .authorizedWhenInUse || status == .authorizedAlways){
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // .requestLocation will only pass one location to the locations array
        // hence we can access it by taking the first element of the array
        if let location = locations.first {
            self.latitudeLabel.text = "\(location.coordinate.latitude)"
            self.longitudeLabel.text = "\(location.coordinate.longitude)"
        }
    }
    
    
    func retriveCurrentLocation(){
        let status = CLLocationManager.authorizationStatus()
        
        if(status == .denied || status == .restricted || !CLLocationManager.locationServicesEnabled()){
            // show alert to user telling them they need to allow location data to use some feature of your app
            return
        }
        
        // if haven't show location permission dialog before, show it to user
        if(status == .notDetermined){
            locationManager.requestWhenInUseAuthorization()
            
            // if you want the app to retrieve location data even in background, use requestAlwaysAuthorization
            // locationManager.requestAlwaysAuthorization()
            return
        }
        
        // at this point the authorization status is authorized
        // request location data once
        locationManager.requestLocation()
        
        // start monitoring location data and get notified whenever there is change in location data / every few seconds, until stopUpdatingLocation() is called
        // locationManager.startUpdatingLocation()
    }
    
    
    
}

