import UIKit
import MapKit
import CoreLocation
class ViewController: UIViewController , MKMapViewDelegate , CLLocationManagerDelegate{
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var mapVC: MKMapView!
    var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        mapVC.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // Location için en iyi tahmin  parametresi.
        //locationManager.requestWhenInUseAuthorization()// Kullanıcıdan kullanım izni iistemek için kullanılmaktadır.
        locationManager.startUpdatingLocation()//Kullanıcının yerini belirlemeye başladık.
        // Dokunma işlemleri
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action:#selector(choselotation(gestureRecognizer:)))
            gestureRecognizer.minimumPressDuration = 3
        mapVC.addGestureRecognizer(gestureRecognizer)
            }
    
    // Dokunma Func
    @objc func choselotation(gestureRecognizer:UILongPressGestureRecognizer){
        if gestureRecognizer.state == .began{
            let  touchpoint = gestureRecognizer.location(in: self.mapVC)
            let  touchCordination = mapVC.convert(touchpoint, toCoordinateFrom: self.mapVC)
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchCordination
            annotation.title = "Sucess..."
            annotation.subtitle = "True"
            self.mapVC.addAnnotation(annotation)
        }
    }
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)//Enlem,Boylam istenilen kordinat enlem boylam için ve bulunduğun konum için.
        let span = MKCoordinateSpan(latitudeDelta: 0.001 , longitudeDelta: 0.001)//Ekranda görünen zoom seviyeisi için.
        //BU kod bloğu ise belirlenen zoom seviyesi gerçekleşmesini sağlayan bloktur.
        
        let region = MKCoordinateRegion(center: location, span: span)
        
        mapVC.setRegion(region, animated: true) // haritanın set edilme işlemi gerçekleştirildi.
    }
}

