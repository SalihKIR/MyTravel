import UIKit
import CoreData
class ShowVC: UIViewController , UITableViewDelegate, UITableViewDataSource {
  

    @IBOutlet weak var showDetailTabelView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        showDetailTabelView.delegate = self
        showDetailTabelView.dataSource = self
        showDetailTabelView.register(ShowCell.nibName, forCellReuseIdentifier: ShowCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let showcell = showDetailTabelView.dequeueReusableCell(withIdentifier: ShowCell.identifier, for: indexPath) as! ShowCell
        showcell.detailLabel.text = "Deneme11-11"
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
                for result in results as! [NSManagedObject] {
                    if let title = result.value(forKey: "title"){
                        
                    }
                    if let id = result.value(forKey: "id") as? UUID{
                        
                    }
                }
            }
        }
        catch {
                print("Erorr")
            }
        }
    }

