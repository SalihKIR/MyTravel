import UIKit

class ShowCell: UITableViewCell {
    
    @IBOutlet weak var outSide: UIView!
    @IBOutlet weak var detailLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        outSide.layer.cornerRadius = 18
        detailLabel.layer.cornerRadius = 25
    }

}

extension ShowCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nibName: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
