

import UIKit

class ShowVC: UIViewController , UITableViewDelegate, UITableViewDataSource {
  

    @IBOutlet weak var showDetailTabelView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        showDetailTabelView.delegate = self
        showDetailTabelView.dataSource = self
        showDetailTabelView.register(ShowCell.nibName, forCellReuseIdentifier: ShowCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let showcell = showDetailTabelView.dequeueReusableCell(withIdentifier: ShowCell.identifier, for: indexPath) as! ShowCell
        showcell.detailLabel.text = "Deneme11-11"
        return showcell
    }
    

}
