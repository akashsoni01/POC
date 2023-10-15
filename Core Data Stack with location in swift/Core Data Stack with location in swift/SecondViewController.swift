

import UIKit
import CoreData

class SecondViewController: UIViewController {
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var subtitle: UITextField!
    @IBOutlet weak var latitude: UITextField!
    @IBOutlet weak var longitude: UITextField!
    var location:TLocation!
    
    var managedContext: NSManagedObjectContext!
    override func viewDidLoad() {
        super.viewDidLoad()
        if location != nil{
            titleField.text = "\(location.title ?? "")"
            subtitle.text = "\(location.subtitle)"
            latitude.text = "\(location.latitude)"
            longitude.text = "\(location.longitude)"
        }else{
            //hide trash button
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func trash(_ sender: UIBarButtonItem) {
        managedContext.delete(location)
        try? managedContext.save()
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func save(_ sender: UIBarButtonItem) {
        if location == nil{
            let location = TLocation(context: managedContext)
            location.title = titleField.text
            location.subtitle = Int16(Int(subtitle.text ?? "")!)
            location.latitude = Double(latitude.text ?? "")!
            location.longitude = Double(longitude.text ?? "")!
        }else{
            self.location.title = titleField.text
            self.location.subtitle = Int16(Int(subtitle.text ?? "")!)
            self.location.latitude = Double(latitude.text ?? "")!
            self.location.longitude = Double(longitude.text ?? "")!
        }
        try? managedContext.save()
        self.navigationController?.popViewController(animated: true)
    }
    
}
