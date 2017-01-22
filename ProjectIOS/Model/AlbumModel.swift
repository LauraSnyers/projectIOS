import CoreLocation

class AlbumModel {
    var albums: [Album] = []
    /*var numbers: [Number] = [Number(name: "Leaving Hogwarts", description: "Harry verlaat Hogwarts", partiture: "test", muziekfragment: "test", album: "Harry Potter", theme: "Filmmuziek")]*/
    /*var albums: [Album] = [
    Album(name: "Harry Potter", theme: "Filmmuziek", numbers: [
        Number(name: "Leaving Hogwarts", description: "Harry verlaat Hogwarts", partiture: "test", muziekfragment: "test", album: "Harry Potter", theme: "Filmmuziek")
        ], description: "Liedjes van Harry Potter", image: "test")
    ]*/
    /*var themes: [Theme] = [Theme(name:"Filmmuziek", description: "Muziek van een film", numbers: [Number(name: "Leaving Hogwarts", description: "Harry verlaat Hogwarts", partiture: "test", muziekfragment: "test", album: "Harry Potter", theme: "Filmmuziek")])]*/
    /*var stores: [Store] = [Store(name:"Viola da Gamba", adress: "Wetterensteenweg 80", town: "Serskamp", opening_hours: ["8u-19u", "8u-19u", "8u-19u", "8u-19u", "8u-19u", "8u-20u", "Gesloten"], coordinates: CLLocationCoordinate2D(latitude: 50.9942408, longitude: 3.917741200000023))]*/
    
    
    func album(at index:Int) -> Album{
        guard index >= 0 || index < albums.count else {
            fatalError("Invalid index into model: \(index)")
        }
        let album = albums[index]
        return album
    }
    
    
    var count: Int {
        return albums.count
    }
    
    subscript(album: Album) -> Int? {
        get {
            return albums.index(where: {album.name == $0.name})
        }
        set{
            albums.append(album)
        }
    }
}
