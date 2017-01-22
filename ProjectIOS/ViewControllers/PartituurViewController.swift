import UIKit

class PartituurViewController: UIViewController {
    @IBOutlet weak var partituur: UIImageView!
    
    var partituurString: String!
    
    override func viewDidLoad() {
        partituur.image = UIImage(named: partituurString)
    }
}
