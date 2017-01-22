class Album {
    let name: String
    let theme: String
    let numbers: [Number]
    let description: String
    let image: String
    
    init(name: String, theme:String, numbers: [Number], description: String, image: String) {
        self.name = name
        self.theme = theme
        self.numbers = numbers
        self.description = description
        self.image = image
    }
    
}

extension Album {
    
    convenience init(json: [String: Any]) throws {
        guard let description = json["description"] as? String else {
            throw Persistence.Error.missingJsonProperty(name: "description")
        }
        guard let image = json["image"] as? String else {
            throw Persistence.Error.missingJsonProperty(name: "image")
        }
        
        guard let name = json["name"] as? String else {
            throw Persistence.Error.missingJsonProperty(name: "name")
        }
        
        guard let theme = json["theme"] as? String else {
           throw Persistence.Error.missingJsonProperty(name: "theme")
        }
        
        guard let numbers = json["numbers"] as? [[String: Any]] else {
            
            throw Persistence.Error.missingJsonProperty(name: "numbers")
        }
        
        var nums: [Number] = []
        for number in numbers {
            nums.append(Number(name: number["name"] as! String, description: number["description"] as! String, partiture: number["partiture"] as! String, muziekfragment: number["muziekfragment"] as! String, album: number["album"] as! String, theme: number["theme"] as! String))
        }
        
        self.init(name: name, theme: theme, numbers: nums, description: description, image: image)
    }}

