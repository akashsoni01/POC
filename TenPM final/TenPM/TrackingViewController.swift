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
import UIKit
import MapKit

class TrackingViewController: UIViewController {
  
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var safetyStatusView: UIView!
  @IBOutlet weak var safetyStatusLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
    mapView.setUserTrackingMode(.follow, animated: true)
  
    if let homeLocation = ParentProfile.homeLocation,
      let safeDistanceFromHome = ParentProfile.safeDistanceFromHome {
      let circleOverlay = MKCircle(center: homeLocation.coordinate,
                                   radius: safeDistanceFromHome)
      
      mapView.add(circleOverlay)
    }
    
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(unsafeDistanceNotificationReceived),
                                           name: TenPMNotifications.UnsafeDistanceNotification,
                                           object: nil)
    
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(safeDistanceNotificationReceived),
                                           name: TenPMNotifications.SafeDistanceNotification,
                                           object: nil)
  }
 
  func safeDistanceNotificationReceived() {
    
    safetyStatusView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    safetyStatusLabel.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
    safetyStatusLabel.text = "You are a safe distance from home."
  }
  
  func unsafeDistanceNotificationReceived() {
    
    safetyStatusView.backgroundColor = #colorLiteral(red: 1, green: 0.1551290751, blue: 0, alpha: 1)
  
    safetyStatusLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    safetyStatusLabel.text = "You are dangerously far from home."
  }
}

// MARK: MKMapViewDelegate
extension TrackingViewController: MKMapViewDelegate {
  
  func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
    
    if let overlay = overlay as? MKCircle{
      let circleRenderer = MKCircleRenderer(circle: overlay)
      circleRenderer.fillColor = UIColor.green
      circleRenderer.alpha = 0.2
      return circleRenderer
    }
    
    return MKOverlayRenderer(overlay: overlay)
  }
}
