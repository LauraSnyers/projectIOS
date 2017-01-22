class Number {
    let name: String
    let description: String
    let partiture: String
    let muziekfragment: String
    let album: String
    let theme: String
    
    init(name: String, description: String, partiture: String, muziekfragment: String, album: String, theme: String) {
        self.name = name
        self.description = description
        self.partiture = partiture
        self.muziekfragment = muziekfragment
        self.album = album
        self.theme = theme
    }
}
extension Number {
    
    convenience init(json: [String: Any]) throws {
        guard let description = json["description"] as? String else {
            throw Persistence.Error.missingJsonProperty(name: "description")
        }
        guard let muziekfragment = json["muziekfragment"] as? String else {
            throw Persistence.Error.missingJsonProperty(name: "muziekfragment")
        }
        
        guard let name = json["name"] as? String else {
            throw Persistence.Error.missingJsonProperty(name: "name")
        }
        
        guard let theme = json["theme"] as? String else {
            throw Persistence.Error.missingJsonProperty(name: "theme")
        }
        
        guard let album = json["album"] as? String else {
            throw Persistence.Error.missingJsonProperty(name: "album")
        }
        
        guard let partiture = json["partiture"] as? String else {
            
            throw Persistence.Error.missingJsonProperty(name: "partiture")
        }
        
        self.init(name: name, description: description, partiture: partiture, muziekfragment: muziekfragment, album: album, theme: theme)
    }}
