//
//  ViewController.swift
//  AlamofirePOC
//
//  Created by Varun Rathi on 12/08/16.
//  Copyright © 2016 NovoInvent. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var map:MKMapView?
    
   let apiKey:String="f817f03f8f4403707fc57c0d5c915248"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func handlelongPress(gestureRecognizer:UILongPressGestureRecognizer)
    {
        if gestureRecognizer.state==UIGestureRecognizerState.Began
        {
         
            let touchPoint = gestureRecognizer.locationInView(self.map)
            
            let MapCoordinates = map?.convertPoint(touchPoint, toCoordinateFromView: map)
            addAnnotationOnLocation(MapCoordinates!)
        }
    }
    
    func addAnnotationOnLocation(coordinates:CLLocationCoordinate2D)
    {
        let annotation = MKPointAnnotation()
        
        annotation.coordinate=coordinates
        annotation.title="Locating"
        annotation.subtitle="fetching response from server..."
        map!.addAnnotation(annotation)
        
        let url = "http://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&APIKEY=\(apiKey)&units=metric"
        Alamofire.request(.GET, url).responseJSON{response in
            
            switch response.result
            {
            case .Failure(let error):
                
                        print(error)
                break
                
            case .Success(let data):
                dispatch_async(dispatch_get_main_queue(), {
                    if let locName: String = data["name"] as! String
                    {
                        annotation.title=locName
                    }
                    
                    if let main:[NSObject: AnyObject] = data["main"] as? [NSObject:AnyObject]
                    {
                        if let temp=main["temp"]
                        {
                            annotation.subtitle="\(temp) °C"
                            self.map!.selectAnnotation(annotation, animated: true)
                        }
                        
                    }
                    
                })
                
            }
            
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func gestureAction(sender: UILongPressGestureRecognizer) {
        
        handlelongPress(sender)
        
    }


}

