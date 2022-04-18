import UIKit
import MapKit
import CoreLocation
import CoreData

class ViewController: UIViewController , MKMapViewDelegate , CLLocationManagerDelegate{
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var mapVC: MKMapView!
    var locationManager = CLLocationManager()
    var text = ""
    var chosenlatitude = Double()
    var chosenlongitude = Double()
    override func viewDidLoad() {
        super.viewDidLoad()
        //For-NavigatorContorllerbar startded
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.search, target: self, action: #selector(barSearchButton))
        //
        //For-MapKit
        mapVC.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // Location için en iyi tahmin  parametresi.
        //locationManager.requestWhenInUseAuthorization()// Kullanıcıdan kullanım izni iistemek için kullanılmaktadır.
        locationManager.startUpdatingLocation()//Kullanıcının yerini belirlemeye başladık.
        // Dokunma işlemleri
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action:#selector(choselotation(gestureRecognizer:)))
            gestureRecognizer.minimumPressDuration = 3
        mapVC.addGestureRecognizer(gestureRecognizer)
        //
        //Textfiell designer
        nameTextfield.isEnabled = true
        nameTextfield.text = text
        nameTextfield.layer.cornerRadius = 20.0
        nameTextfield.layer.borderWidth = 1.0
        //nameTextfield.layer.borderColor = UIColor.red.cgColor
        locationTextField.layer.cornerRadius = 20.0
        locationTextField.layer.borderWidth = 1.0
        checktext()
        //Button
        saveButton.isHidden = false
        }
    
    func checktext (){
        if nameTextfield.text == ""{
            nameTextfield.layer.borderColor = UIColor.red.cgColor
            }
        else {
            nameTextfield.layer.borderColor = UIColor.black.cgColor
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("Gooddddd")
    }
    // Dokunma Func
    @objc func choselotation(gestureRecognizer:UILongPressGestureRecognizer){
        if gestureRecognizer.state == .began{
            let  touchpoint = gestureRecognizer.location(in: self.mapVC)
            let  touchCordination = mapVC.convert(touchpoint, toCoordinateFrom: self.mapVC)
            chosenlatitude = touchCordination.latitude
            chosenlongitude = touchCordination.longitude
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchCordination
            annotation.title = nameTextfield.text
            annotation.subtitle = locationTextField.text
            self.mapVC.addAnnotation(annotation)
        }
    }
    
    // For EnlemBoylam
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)//Enlem,Boylam istenilen kordinat enlem boylam için ve bulunduğun konum için.
        let span = MKCoordinateSpan(latitudeDelta: 0.001 , longitudeDelta: 0.001)//Ekranda görünen zoom seviyeisi için.
        //BU kod bloğu ise belirlenen zoom seviyesi gerçekleşmesini sağlayan bloktur.
        
        let region = MKCoordinateRegion(center: location, span: span)
        
        mapVC.setRegion(region, animated: true) // haritanın set edilme işlemi gerçekleştirildi.
    }
    
   //Coredata kayıt bölümü
    @IBAction func saveButtonAction(_ sender: Any) {
        //Core Data model oluşumu
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newPlace = NSEntityDescription.insertNewObject(forEntityName: "Entity", into: context)
        newPlace.setValue(nameTextfield.text, forKey: "title")
        newPlace.setValue(locationTextField.text, forKey: "subtitle")
        newPlace.setValue(chosenlatitude, forKey: "latitued")
        newPlace.setValue(chosenlongitude, forKey: "longitude")
        newPlace.setValue(UUID(), forKey: "id")
        
        do{
            try context.save()
            print("Yes")
        } catch{
            print("NO")
        }
        let detailVC = ShowVC.instantiate(storyboard: .details)
        navigationController?.pushViewController(detailVC, animated: true)
        // Core Data final
    }
    //Navigator contorller bar item func
    @objc func barSearchButton(){
        let detailVC = ShowVC.instantiate(storyboard: .details)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

