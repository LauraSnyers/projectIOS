import UIKit
import Alamofire
import ReachabilitySwift

class NumbersViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var searchbar: UISearchBar!
    
    var searchResults: [Number] = []
    let reachability = Reachability()!
    //var model = AlbumModel()
    var numbers: [Number] = [];
    //fileprivate var numbers: [Number] = []
    
    
    override func viewDidLoad() {
        splitViewController?.delegate = self
        
        tableView.addSubview(errorView)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        tableView.addConstraints([
            errorView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            errorView.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
            errorView.widthAnchor.constraint(equalTo: tableView.widthAnchor),
            errorView.heightAnchor.constraint(equalTo: tableView.heightAnchor)
            ])
        hideErrorView()
        
        
        // Set up refresh control.
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        tableView.refreshControl = refreshControl

        refreshTableView()
    }
    
    private func showErrorView() {
        errorView.isHidden = false
        tableView.separatorStyle = .none
    }
    
    private func hideErrorView() {
        errorView.isHidden = true
        tableView.separatorStyle = .singleLine
    }
    
    func refreshTableView() {
        if reachability.isReachable {
            Alamofire.request("https://api.mlab.com/api/1/databases/projectios/collections/numbers?apiKey=yLsoR82FsulLNW6fKBozIuaR20nYe63P").responseJSON { response in
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
                guard let value = response.result.value as? [[String: Any]] else {
                    print("Malformed data received from fetchAllRooms service")
                    return
                }
                do{
                    self.numbers = try value.map { try Number(json: $0)}
                    
                    print("New array is \(self.numbers[0].name)")
                    self.searchResults = self.numbers
                    self.tableView.reloadData()
                }
                catch let error as Persistence.Error{
                    print(error)
                } catch {
                    print("Fout")
                }}
            searchbar.placeholder = "Type something here"
            searchbar.delegate = self
            searchResults = numbers
            hideErrorView()
        } else {
            print("Network not reachable")
            self.showErrorView()
        }
        self.tableView.refreshControl!.endRefreshing()
    }
    
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        searchResults = searchText.isEmpty ? numbers : numbers.filter({(number: Number) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return number.name.range(of: searchText, options: .caseInsensitive) != nil
        })
        
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchbar: UISearchBar) {
        self.searchbar.showsCancelButton = true
    }
    func searchBarCancelButtonClicked(_ searchbar: UISearchBar) {
        searchbar.showsCancelButton = false
        searchbar.text = ""
        searchbar.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BackToAlbums" {
            
        } else {
        let navigationController = segue.destination as! UINavigationController
        let numberViewController = navigationController.topViewController as! NumberViewController
        let selectedIndex = tableView.indexPathForSelectedRow!.row
        numberViewController.number = numbers[selectedIndex]
        }
    }
}

extension NumbersViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "number", for: indexPath)
        let number = searchResults[indexPath.row]
        cell.textLabel!.text = number.name
        cell.detailTextLabel!.text = number.album
        return cell
    }
}

extension NumbersViewController: UITableViewDelegate {
    
}

extension NumbersViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}
