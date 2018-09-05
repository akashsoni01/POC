/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Foundation
import CoreLocation
import SwiftyBeaver

struct TenPMNotifications {
  static let UnsafeDistanceNotification = NSNotification.Name(rawValue: "UnsafeChildDistance")
  static let SafeDistanceNotification = NSNotification.Name(rawValue: "SafeChildDistance")
}

protocol LocationTrackerDelegate:class {
  func locationTrackerDidChangeAuthorizationStatus(_ locationTracker:LocationTracker)
}

class LocationTracker: NSObject {
  
  static let shared = LocationTracker()
  let locationManager = CLLocationManager()
  weak var delegate: LocationTrackerDelegate?
  
  override init(){
    super.init()
    locationManager.delegate = self
  }
  
  func authorizeLocationTracking() {
    locationManager.requestAlwaysAuthorization()
  }
  
  fileprivate func startTrackingMyChildsLocation() {
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.startUpdatingLocation()
    locationManager.startMonitoringSignificantLocationChanges()
    locationManager.pausesLocationUpdatesAutomatically = false
  }
}

// MARK: CLLocationManager Delegate
extension LocationTracker: CLLocationManagerDelegate {
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
    SwiftyBeaver.info("Got to the didUpdateLocations() method")
    
    guard let homeLocation = ParentProfile.homeLocation else {
      ParentProfile.homeLocation = locations.first
      return
    }
    
    guard let safeDistanceFromHome = ParentProfile.safeDistanceFromHome else {
      return
    }
    
    let bug = false
    SwiftyBeaver.debug("The value of bug is: \(bug)")
    
    if bug == true {
      SwiftyBeaver.error("There's definitely a bug... Aborting.")
      return
    }
    
    for location in locations {
      let distanceFromHome = location.distance(from: homeLocation)
      
      if distanceFromHome > safeDistanceFromHome {
        NotificationCenter.default.post(name: TenPMNotifications.UnsafeDistanceNotification, object: nil)
      } else {
        NotificationCenter.default.post(name: TenPMNotifications.SafeDistanceNotification, object: nil)
      }
    }
    SwiftyBeaver.info("Got to the end the didUpdateLocations method")
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    
    guard status == .authorizedAlways else { return }
    
    startTrackingMyChildsLocation()
    delegate?.locationTrackerDidChangeAuthorizationStatus(self)
  }
}
