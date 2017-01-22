import Alamofire

class Persistence {
    enum Error: Swift.Error {
        case missingJsonProperty(name: String)
        case noNetwork
        case unexpectedStatusCode(found: Int, expected: Int)
        case missingJsonData
        case invalidJsonData(message: String)
        case other(Swift.Error)
    }
    var jsonArray:NSMutableArray?
    var albums: [Album]? = nil

 func fetchAllAlbums(){
    
    Alamofire.request("https://api.mlab.com/api/1/databases/projectios/collections/albums?apiKey=yLsoR82FsulLNW6fKBozIuaR20nYe63P").responseJSON { response in
        
        
        if let JSON = response.result.value {
            print("JSON: \(JSON)")
        }
        guard let value = response.result.value as? [[String: Any]] else {
                print("Malformed data received from fetchAllRooms service")
                return
        }
        do{
            self.albums = []
                self.albums = try value.map { try Album(json: $0)}
            
            print("New array is \(self.albums![0].name)")
        }
    catch let error as Persistence.Error{
        print(error)
    } catch {
        print("Fout")
        }}
    }
    
}

