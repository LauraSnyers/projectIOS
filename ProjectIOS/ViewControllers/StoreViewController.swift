import UIKit
import MapKit

class StoreViewController: UITableViewController{
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var townLabel: UILabel!
    @IBOutlet weak var mondayLabel: UILabel!
    @IBOutlet weak var tuesdayLabel: UILabel!
    @IBOutlet weak var wednesdayLabel: UILabel!
    @IBOutlet weak var thursdayLabel: UILabel!
    @IBOutlet weak var fridayLabel: UILabel!
    @IBOutlet weak var saturdayLabel: UILabel!
    @IBOutlet weak var sundayLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    
    var store: Store!
    
    override func viewDidLoad() {
        title = store.name
        nameLabel.text = "\(store.name)"
        addressLabel.text = "\(store.adress)"
        townLabel.text = "\(store.town)"
        mondayLabel.text = "\(store.opening_hours[0])"
        tuesdayLabel.text = "\(store.opening_hours[1])"
        wednesdayLabel.text = "\(store.opening_hours[2])"
        thursdayLabel.text = "\(store.opening_hours[3])"
        fridayLabel.text = "\(store.opening_hours[4])"
        saturdayLabel.text = "\(store.opening_hours[5])"
        sundayLabel.text = "\(store.opening_hours[6])"
        
        mapView.region = MKCoordinateRegion(center: store.coordinates, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        let pin = MKPointAnnotation()
        pin.coordinate = store.coordinates
        mapView.addAnnotation(pin)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if !splitViewController!.isCollapsed {
            navigationItem.leftBarButtonItem = splitViewController!.displayModeButtonItem
        }
    }
}
