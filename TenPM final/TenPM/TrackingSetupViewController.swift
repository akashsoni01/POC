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

import UIKit
import CoreLocation

class TrackingSetupViewController: UITableViewController {
  
  @IBOutlet weak var setupButton: UIButton!
  @IBOutlet weak var distanceTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    LocationTracker.shared.delegate = self
    setButtonTitleForLocationAuthorizationStatus()
  }
  
  fileprivate func setButtonTitleForLocationAuthorizationStatus() {
    
    var buttonTitle: String = String()
    var buttonColor: UIColor!
    
    if CLLocationManager.authorizationStatus() == .authorizedAlways {
      buttonTitle = "SETUP FINISHED"
      buttonColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
    } else {
      buttonTitle = "SETUP TRACKING"
      buttonColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    }
    
    setupButton.setTitle(buttonTitle, for: .normal)
    setupButton.backgroundColor = buttonColor
  }
  
  // MARK: UITableView DataSource
  override func numberOfSections(in tableView: UITableView) -> Int {
    
    // Show two sections once location tracking is enabled.
    if CLLocationManager.authorizationStatus() == .authorizedAlways {
      return 2
    }
    
    // Otherwise just show the first section.
    return 1
  }
  
  
  @IBAction func setupButtonWasPressed(_ sender:Any) {
    
    guard CLLocationManager.authorizationStatus() != .authorizedAlways else { return }
    
    let alert = UIAlertController(title: nil,
                                  message: "Are you the parent, and are you really home?",
                                  preferredStyle: .alert)
    
    let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) in
      LocationTracker.shared.authorizeLocationTracking()
      
    }
    
    let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
    
    alert.addAction(yesAction)
    alert.addAction(noAction)
    
    present(alert, animated: true, completion: nil)
  }
  
  @IBAction func distanceButtonWasPressed(_ sender:Any) {
    
    guard let text = distanceTextField.text,
          let distance = Double(text),
          distance > 0
      else {
        distanceTextField.text = nil
        showInvalidDistanceAlert()
        return
    }
    
    // We want to store the distance in meters
    ParentProfile.safeDistanceFromHome = distance * 1000
    
    if ParentProfile.homeLocation == nil {
      
      let alert = UIAlertController(title: "Oops",
                                    message: "We still haven't figured out where 'home' is. Give it a second!",
                                    preferredStyle: .alert)
      
      let okayAction = UIAlertAction(title: "Okay",
                                     style: .default,
                                     handler: nil)
      
      alert.addAction(okayAction)
      
      present(alert, animated: true, completion: nil)
      
    } else {
      performSegue(withIdentifier: "ShowTrackingMap", sender: nil)
    }
    
  }
  
  fileprivate func showInvalidDistanceAlert() {
    
    let alert = UIAlertController(title: nil,
                                  message: "Please enter a valid distance in kilometers",
                                  preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: "OK",
                                 style: .default, handler: nil)
    
    alert.addAction(okAction)
    
    present(alert, animated: true, completion: nil)
  }
}

extension TrackingSetupViewController: LocationTrackerDelegate {
  
  func locationTrackerDidChangeAuthorizationStatus(_ locationTracker: LocationTracker) {
    setButtonTitleForLocationAuthorizationStatus()
    tableView.reloadData()
  }
  
}
