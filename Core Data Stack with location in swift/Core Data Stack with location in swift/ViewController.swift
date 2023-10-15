//The main building blocks of Core Data are: NSManagedObject, NSManagedObjectModel, NSPersistentStoreCoordinator and NSManagedObjectContext. When connected together, they are usually referred to as a Core Data stack.
///https://www.vadimbulavin.com/core-data-stack-swift-4/

import UIKit
import CoreData
import MapKit

class ViewController: UIViewController,MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    var managedContext: NSManagedObjectContext!
    var locationArray = [TLocation]()
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //for loop to add
        //datqa model name is Core_Data_Stack_with_location_in_swift (Like schema)
        //load your schema
        let request:NSFetchRequest<TLocation> = TLocation.fetchRequest()
        let results = try? managedContext.fetch(request)
        if let resultarray = results{
            self.locationArray = resultarray
        }
        mapView.removeAnnotations(mapView.annotations)
        for index in 0..<locationArray.count {
            let loc = locationArray[index]
            let artwork = Artwork(title: loc.title ?? "",
                                  locationName:"\(loc.subtitle)",
                discipline: "Sculpture",
                coordinate: CLLocationCoordinate2D(latitude: loc.latitude, longitude: loc.longitude), id: index)
            mapView.addAnnotation(artwork)
        }
    }
    func addPin(locName : String, locLat : Double , locLong : Double , locSubtitle : String,tag:Int) {
        let annotation = MKPointAnnotation()
        let centerCoordinate = CLLocationCoordinate2D(latitude: locLat, longitude:locLong)
        annotation.coordinate = centerCoordinate
        annotation.title = locName + " - " + locSubtitle
        mapView.addAnnotation(annotation)
    }
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    {
    }
    
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        if let artwork = view.annotation as? Artwork{
            vc.location = locationArray[artwork.id]
        }
        vc.managedContext = self.managedContext
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "Location"
        
        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
            annotationView.annotation = annotation
            return annotationView
        } else {
            let annotationView = MKPinAnnotationView(annotation:annotation, reuseIdentifier:identifier)
            annotationView.isEnabled = true
            annotationView.canShowCallout = true
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView.rightCalloutAccessoryView = btn
            return annotationView
        }
    }
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        vc.managedContext = self.managedContext
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


//adding new property to store id in mkannotation
//fileprivate var storedPropertyForImage: [ObjectIdentifier:Int] = [:]
//fileprivate var defaultValueForImage = 0
//extension MKPointAnnotation {
//    var idInt: Int {
//        get {return storedPropertyForImage[ObjectIdentifier(self)] ?? defaultValueForImage}
//        set {storedPropertyForImage[ObjectIdentifier(self)] = newValue}
//    }
//}



class Artwork: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    let id:Int
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D,id:Int) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        self.id  = id
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}

