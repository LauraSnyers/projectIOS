import CoreLocation

class Store{
    let name: String
    let adress: String
    let town: String
    let opening_hours: [String]
    let coordinates: CLLocationCoordinate2D
    
    init(name: String, adress: String, town: String, opening_hours: [String], coordinates: CLLocationCoordinate2D) {
        self.name = name
        self.adress = adress
        self.town = town
        self.opening_hours = opening_hours
        self.coordinates = coordinates
    }
}
extension Store {
    
    convenience init(json: [String: Any]) throws {
        guard let name = json["name"] as? String else {
            throw Persistence.Error.missingJsonProperty(name: "name")
        }
        guard let adress = json["adress"] as? String else {
            throw Persistence.Error.missingJsonProperty(name: "adress")
        }
        
        guard let town = json["town"] as? String else {
            throw Persistence.Error.missingJsonProperty(name: "town")
        }
        
        guard let opening_hours = json["opening_hours"] as? [String] else {
            throw Persistence.Error.missingJsonProperty(name: "opening_hours")
        }
        
        guard let coordinates = json["coordinates"] as? [Double] else {
            throw Persistence.Error.missingJsonProperty(name: "coordinates")
        }
        let coords = CLLocationCoordinate2D(latitude: coordinates[0], longitude: coordinates[1])
        
        self.init(name: name, adress: adress, town: town, opening_hours: opening_hours, coordinates: coords)
    }}
