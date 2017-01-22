import UIKit
import Alamofire
import ReachabilitySwift

class StoresViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var searchbar: UISearchBar!
    
    var searchResults: [Store] = []
    let reachability = Reachability()!
    
    var stores: [Store] = [];
    //var model = AlbumModel()
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
    
    func refreshTableView() {
        if reachability.isReachable {
            Alamofire.request("https://api.mlab.com/api/1/databases/projectios/collections/stores?apiKey=yLsoR82FsulLNW6fKBozIuaR20nYe63P").responseJSON { response in
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
                guard let value = response.result.value as? [[String: Any]] else {
                    print("Malformed data received from fetchAllRooms service")
                    return
                }
                do{
                    self.stores = try value.map { try Store(json: $0)}
                    
                    print("New array is \(self.stores[0].name)")
                    self.searchResults = self.stores
                    self.tableView.reloadData()
                }
                catch let error as Persistence.Error{
                    print(error)
                } catch {
                    print("Fout")
                }}
            searchbar.placeholder = "Type something here"
            searchbar.delegate = self
            searchResults = stores
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
        searchResults = searchText.isEmpty ? stores : stores.filter({(store: Store) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return store.name.range(of: searchText, options: .caseInsensitive) != nil
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
    
    private func showErrorView() {
        errorView.isHidden = false
        tableView.separatorStyle = .none
    }
    
    private func hideErrorView() {
        errorView.isHidden = true
        tableView.separatorStyle = .singleLine
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let storeViewController = navigationController.topViewController as! StoreViewController
        let selectedIndex = tableView.indexPathForSelectedRow!.row
        storeViewController.store = stores[selectedIndex]
    }
}

extension StoresViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "store", for: indexPath)
        let store = searchResults[indexPath.row]
        cell.textLabel!.text = store.name
        cell.detailTextLabel!.text = store.town
        return cell
    }
}

extension StoresViewController: UITableViewDelegate {
    
}

extension StoresViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}
