import UIKit
import Alamofire
import ReachabilitySwift


class AlbumsViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var searchbar: UISearchBar!
    
    var searchResults: [Album] = []
    let reachability = Reachability()!
    
    var albums = [Album]()
    //var persistence = Persistence()
    override func viewDidLoad() {
        
        
        // Set up error view.
        // This uses layout anchors to create constraints instead of using the NSLayoutConstraint class directly.
        errorView.translatesAutoresizingMaskIntoConstraints = false
        tableView.addSubview(errorView)
        tableView.addConstraints([
            errorView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            errorView.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
            errorView.widthAnchor.constraint(equalTo: tableView.widthAnchor),
            errorView.heightAnchor.constraint(equalTo: tableView.heightAnchor)
            ])
        
        // Set up refresh control.
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        tableView.refreshControl = refreshControl
        refreshTableView()
    }
    
    private func showErrorView() {
        tableView.separatorStyle = .none
        errorView.isHidden = false
    }
    
    private func hideErrorView() {
        tableView.separatorStyle = .singleLine
        errorView.isHidden = true
    }
    
    func refreshTableView() {
        if reachability.isReachable {
                Alamofire.request("https://api.mlab.com/api/1/databases/projectios/collections/albums?apiKey=yLsoR82FsulLNW6fKBozIuaR20nYe63P").responseJSON { response in
                    
                    if let JSON = response.result.value {
                        print("JSON: \(JSON)")
                    }
                    guard let value = response.result.value as? [[String: Any]] else {
                        print("No data received from fetching albums service")
                        self.tableView.refreshControl!.endRefreshing()
                        self.showErrorView()
                        return
                    }
                    do{
                        self.albums = []
                        self.albums = try value.map { try Album(json: $0)}
                        
                        print("New array is \(self.albums[0].name)")
                        self.searchResults = self.albums
                        self.tableView.reloadData()
                        self.hideErrorView()
                        self.tableView.refreshControl!.endRefreshing()
                    }
                    catch let error as Persistence.Error{
                        print(error)
                        self.showErrorView()
                        self.tableView.refreshControl!.endRefreshing()
                    } catch {
                        print("Fout")
                        self.showErrorView()
                        self.tableView.refreshControl!.endRefreshing()
                    }}
            searchbar.placeholder = "Type something here"
            searchbar.delegate = self
            searchResults = albums
            hideErrorView()
                      } else {
            self.showErrorView()
            self.tableView.refreshControl!.endRefreshing()
            print("Network not reachable")
        }
        
    }
    
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        searchResults = searchText.isEmpty ? albums : albums.filter({(album: Album) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return album.name.range(of: searchText, options: .caseInsensitive) != nil
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
    

}

extension AlbumsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "album", for: indexPath) as! PreviewAlbumCell
           let album = searchResults[indexPath.row]
        cell.themeLabel!.text = album.theme
        cell.nameLabel!.text = album.name
        cell.preview!.image = UIImage(named: album.image)
        //cell.textLabel!.text = album.name
        //label.text = album.theme
        //cell.detailTextLabel!.text = album.theme
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let numbersAlbumViewController = segue.destination as! NumbersAlbumViewController
        let selectedIndex = tableView.indexPathForSelectedRow!.row
        numbersAlbumViewController.numbers = albums[selectedIndex].numbers
    }
    
    
    
}

//extension AlbumsViewController: UITableViewDelegate {
    
//}
