import UIKit
import CoreData
class ShowVC: UIViewController , UITableViewDelegate, UITableViewDataSource {
  

    @IBOutlet weak var showDetailTabelView: UITableView!
    //BeginBuffer
    var titlebuffer = [String]()
    var idbufffer = [UUID]()
    //
    //Seçilmiş veri işlemleri.
    var chosentitle = ""
    var chosentitleid : UUID?
    override func viewDidLoad() {
        super.viewDidLoad()
        showDetailTabelView.delegate = self
        showDetailTabelView.dataSource = self
        showDetailTabelView.register(ShowCell.nibName, forCellReuseIdentifier: ShowCell.identifier)
        //TEST NOW
        if chosentitle != ""{
            //CoreData
            let stringUUID = chosentitleid!.uuidString
            print(stringUUID)
        }
        else {
            //Add New İtem
        }
        //Fonksiyon çağırma
        getdata()
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titlebuffer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let showcell = showDetailTabelView.dequeueReusableCell(withIdentifier: ShowCell.identifier, for: indexPath) as! ShowCell
       // showcell.detailLabel.text = "Deneme11-11"
        showcell.detailLabel?.text = titlebuffer[indexPath.row]
        return showcell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
        
    }
    //Show Data Data göterimi için
    func getdata(){
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Entity")
        
        request.returnsObjectsAsFaults = false
        do{
            let results = try context.fetch(request)
            
            if results.count > 0
             {
                //Veri herzaman basılmaması için remove yapılması gerekmektedir.
                self.titlebuffer.removeAll(keepingCapacity: false)
                self.idbufffer.removeAll(keepingCapacity: false)
                for result in results as! [NSManagedObject] {
                    if let title = result.value(forKey: "title") as? String{
                        self.titlebuffer.append(title)
                        showDetailTabelView.reloadData()//Liste düzenleme
                    }
                    if let id = result.value(forKey: "id") as? UUID{
                        self.idbufffer.append(id)
                    }
                }
            }
        }
        catch {
                print("Erorr")
            }
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosentitle = titlebuffer[indexPath.row]
        chosentitleid = idbufffer[indexPath.row]
    }
    
    }

