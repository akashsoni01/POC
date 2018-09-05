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

class ParentProfile {
  
  private static let homeLatitudeKey = "homeLatitude"
  
  private class var homeLatitude: CLLocationDegrees? {
    get {
      return UserDefaults.standard.object(forKey: homeLatitudeKey) as? CLLocationDegrees
    }
    set {
      UserDefaults.standard.set(newValue, forKey: homeLatitudeKey)
    }
  }
  
  private static let homeLongitudeKey = "homeLongitude"
  
  private class var homeLongitude: CLLocationDegrees? {
    get{
      return UserDefaults.standard.object(forKey: homeLongitudeKey) as? CLLocationDegrees
    }
    set {
      UserDefaults.standard.set(newValue, forKey: homeLongitudeKey)
    }
  }
  
  private static let homeLocationKey = "homeLocation"
  
  class var homeLocation: CLLocation? {
    get {
      guard let latitude = homeLatitude,
            let longitude = homeLongitude
      else { return nil }
      
      return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    set {
      homeLatitude = newValue?.coordinate.latitude
      homeLongitude = newValue?.coordinate.longitude
    }
  }
  
  private static let safeDistanceKey = "safeDistance"
  
  // A safe distance that the child may wander from the parent's home before triggering an alert.
  class var safeDistanceFromHome: CLLocationDistance? {
    get {
      return UserDefaults.standard.double(forKey: safeDistanceKey)
    }
    set {
      UserDefaults.standard.set(newValue, forKey: safeDistanceKey)
    }
  }
  
}
