class Theme {
    let name : String
    let description : String
    let numbers: [Number]
    
    init(name: String, description: String, numbers: [Number]) {
        self.name = name
        self.description = description
        self.numbers = numbers
    }
}
extension Theme {
    
    convenience init(json: [String: Any]) throws {
        guard let name = json["name"] as? String else {
            throw Persistence.Error.missingJsonProperty(name: "name")
        }
        guard let description = json["description"] as? String else {
            throw Persistence.Error.missingJsonProperty(name: "description")
        }
        
        guard let numbers = json["numbers"] as? [[String: Any]] else {
            throw Persistence.Error.missingJsonProperty(name: "numbers")
        }
        
        var nums: [Number] = []
        for number in numbers {
            nums.append(Number(name: number["name"] as! String, description: number["description"] as! String, partiture: number["partiture"] as! String, muziekfragment: number["muziekfragment"] as! String, album: number["album"] as! String, theme: number["theme"] as! String))
        }
        
        self.init(name: name, description: description, numbers: nums)
    }}
