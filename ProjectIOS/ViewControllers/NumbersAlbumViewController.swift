import UIKit

class NumbersAlbumViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchbar: UISearchBar!
    
    var numbers: [Number]!
    //fileprivate var numbers: [Number] = []
    
    var searchResults: [Number] = []
    
    override func viewDidLoad() {
        searchbar.placeholder = "Type something here"
        searchbar.delegate = self
        searchResults = numbers
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
           // let navigationController = segue.destination as! UINavigationController
            let numberViewController = segue.destination as! NumberViewController
            let selectedIndex = tableView.indexPathForSelectedRow!.row
            numberViewController.number = numbers[selectedIndex]
        
    }
}

extension NumbersAlbumViewController: UITableViewDataSource {
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

extension NumbersAlbumViewController: UITableViewDelegate {
    
}

