//
//  TSLocationManager.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/7/28.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

import Foundation
import INTULocationManager

let LocationInstance = LocationManager.sharedInstance
private let kDefaultCoordinateValue: Float = -1.00

class LocationManager: NSObject {
    class var sharedInstance: LocationManager {
        struct Static {
            static let instance: LocationManager = LocationManager()
        }
        return Static.instance
    }
  
    
    
    
    var address: String = ""
    var city: String = ""
    var street: String = ""
    var latitude: NSNumber = NSNumber(float: kDefaultCoordinateValue)
    var longitude: NSNumber = NSNumber(float: kDefaultCoordinateValue)
    var currentLocation: CLLocation!
    var locationService: CLLocationManager!
    var geocoder: CLGeocoder!
    
    private override init() {
        self.locationService = CLLocationManager()
        self.geocoder = CLGeocoder()
        super.init()
    }
    
    func startLocation(success: (Void) -> Void, failure: (Void) -> Void)  {
        let manager = INTULocationManager.sharedInstance()
        manager.requestLocationWithDesiredAccuracy(
        .City,
        timeout: 10,
        delayUntilAuthorized: true) { (currentLocation, achievedAccuracy, status) in
            switch status {
            case .Success:
                self.currentLocation = currentLocation
                self.latitude = NSNumber(double: currentLocation.coordinate.latitude)
                self.longitude = NSNumber(double: currentLocation.coordinate.longitude)
                self.locationService.delegate = self;
                self.locationService.startUpdatingLocation()
                success()
            case .TimedOut:
                TSAlertView_show("Location request time out.")
                failure()
                break
            default:
                TSAlertView_show(self.getLocationErrorDescription(status))
                break
            }
        }
    }
    
    
    
    func getLocationErrorDescription(status: INTULocationStatus) -> String {
        if status == .ServicesNotDetermined {
            return "Error: User has not responded to the permissions alert."
        }
        if status == .ServicesDenied {
            return "Error: User has denied this app permissions to access device location."
        }
        if status == .ServicesRestricted {
            return "Error: User is restricted from using location services by a usage policy."
        }
        if status == .ServicesDisabled {
            return "Error: Location services are turned off for all apps on this device."
        }
        return "An unknown error occurred.\n(Are you using iOS Simulator with location set to 'None'?)"
    }

    
    func resetLocation() -> Void {
        self.address = ""
        self.city = ""
        self.street = ""
        self.latitude = NSNumber(float: kDefaultCoordinateValue)
        self.longitude = NSNumber(float: kDefaultCoordinateValue)
    }
    
    func updateLocation(userLocation: CLLocation) {
        if userLocation.horizontalAccuracy > 0 {
            self.locationService.stopUpdatingLocation()
            return
        }
        
        self.latitude = NSNumber(double: userLocation.coordinate.latitude)
        self.longitude = NSNumber(double: userLocation.coordinate.longitude)
        
        if !self.geocoder.geocoding {
            self.geocoder.reverseGeocodeLocation(userLocation, completionHandler: { (placemarks, error) in
                if let error = error {
                    log.error("reverse geodcode fail: \(error.localizedDescription)")
                    return
                }
                if let placemarks = placemarks where placemarks.count > 0 {
                    let onePlacemark = placemarks[0]
                    self.address =  "\(onePlacemark.administrativeArea,onePlacemark.subLocality,onePlacemark.thoroughfare)"
                    self.city = onePlacemark.administrativeArea!
                    self.street = onePlacemark.thoroughfare!
                }
            })
        }
        
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations.last!
        self.updateLocation(userLocation)
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        self.updateLocation(manager.location!)
    }
    
    func locationManager(manager: CLLocationManager, didFinishDeferredUpdatesWithError error: NSError?) {
        self.resetLocation()
    }
    
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        self.resetLocation()
        TSAlertView_show("\(error.localizedDescription)")
    }
    
}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
