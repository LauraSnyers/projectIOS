import XCTest
@testable import ProjectIOS

class AlbumJSONTests: XCTestCase {
    
    func testValid(){
        let json: [String: Any] = [
            "name": "Harry Potter",
            "theme": "Filmmusic",
            "numbers": [
                ["name": "Leaving Hogwarts",
                    "description": "Harry leaves Hogwarts",
                    "partiture": "leaving_hogwarts",
                    "muziekfragment": "leaving_hogwarts_sound",
                    "album": "Harry Potter",
                    "theme": "Filmmusic"]
            ],
            "description": "Songs of the movie of Harry Potter",
            "image": "harry_potter"
        ]
        guard let album = try? Album(json: json) else {
            XCTFail("Unexpected error")
            return
        }
        
        XCTAssertEqual(album.name, "Harry Potter")
        XCTAssertEqual(album.description, "Songs of the movie of Harry Potter")
        XCTAssertEqual(album.theme, "Filmmusic")
        XCTAssertEqual(album.image, "harry_potter")
        XCTAssertEqual(album.numbers[0].name, "Leaving Hogwarts")
        XCTAssertEqual(album.numbers[0].description, "Harry leaves Hogwarts")
        XCTAssertEqual(album.numbers[0].partiture, "leaving_hogwarts")
        XCTAssertEqual(album.numbers[0].muziekfragment, "leaving_hogwarts_sound")
        XCTAssertEqual(album.numbers[0].album, "Harry Potter")
        XCTAssertEqual(album.numbers[0].theme, "Filmmusic")
    }
    
    func testMissingDescription() {
        let json: [String: Any] = [
            "name": "Harry Potter",
            "theme": "Filmmusic",
            "numbers": [
                ["name": "Leaving Hogwarts",
                "description": "Harry leaves Hogwarts",
                "partiture": "leaving_hogwarts",
                "muziekfragment": "leaving_hogwarts_sound",
                "album": "Harry Potter",
                "theme": "Filmmusic"]
            ],
            "image": "harry_potter"
        ]
        
        XCTAssertThrowsError(_ = try Album(json: json)) {
            error in
            guard case Persistence.Error.missingJsonProperty(name: "description") = error else {
                XCTFail("Unexpected error \(error)")
                return
            }
        }
    }
    
    func testNonStringDescription() {
        let json: [String: Any] = [
            "name": "Harry Potter",
            "theme": "Filmmusic",
            "numbers": [
                ["name": "Leaving Hogwarts",
                "description": "Harry leaves Hogwarts",
                "partiture": "leaving_hogwarts",
                "muziekfragment": "leaving_hogwarts_sound",
                "album": "Harry Potter",
                "theme": "Filmmusic"]
            ],
            "description": 25,
            "image": "harry_potter"
        ]
        
        XCTAssertThrowsError(_ = try Album(json: json)) {
            error in
            guard case Persistence.Error.missingJsonProperty(name: "description") = error else {
                XCTFail("Unexpected error \(error)")
                return
            }
        }
    }
    
    func testMissingName() {
        let json: [String: Any] = [
            "theme": "Filmmusic",
            "numbers": [
                ["name": "Leaving Hogwarts",
                "description": "Harry leaves Hogwarts",
                "partiture": "leaving_hogwarts",
                "muziekfragment": "leaving_hogwarts_sound",
                "album": "Harry Potter",
                "theme": "Filmmusic"]
            ],
            "description": "Songs of the movie of Harry Potter",
            "image": "harry_potter"

        ]
        
        XCTAssertThrowsError(_ = try Album(json: json)) {
            error in
            guard case Persistence.Error.missingJsonProperty(name: "name") = error else {
                XCTFail("Unexpected error \(error)")
                return
            }
        }
    }
    
    func testMissingTheme() {
        let json: [String: Any] = [
            "name": "Harry Potter",
            "numbers": [
                ["name": "Leaving Hogwarts",
                "description": "Harry leaves Hogwarts",
                "partiture": "leaving_hogwarts",
                "muziekfragment": "leaving_hogwarts_sound",
                "album": "Harry Potter",
                "theme": "Filmmusic"]
            ],
            "description": "Songs of the movie of Harry Potter",
            "image": "harry_potter"
        ]
        
        XCTAssertThrowsError(_ = try Album(json: json)) {
            error in
            guard case Persistence.Error.missingJsonProperty(name: "theme") = error else {
                XCTFail("Unexpected error \(error)")
                return
            }
        }
    }
    
    func testMissingImage() {
        let json: [String: Any] = [
            "name": "Harry Potter",
            "theme": "Filmmusic",
            "numbers": [
                ["name": "Leaving Hogwarts",
                "description": "Harry leaves Hogwarts",
                "partiture": "leaving_hogwarts",
                "muziekfragment": "leaving_hogwarts_sound",
                "album": "Harry Potter",
                "theme": "Filmmusic"]
            ],
            "description": "Songs of the movie of Harry Potter",

        ]
        
        XCTAssertThrowsError(_ = try Album(json: json)) {
            error in
            guard case Persistence.Error.missingJsonProperty(name: "image") = error else {
                XCTFail("Unexpected error \(error)")
                return
            }
        }
    }
    
    func testNonStringName() {
        let json: [String: Any] = [
            "name": 100,
            "theme": "Filmmusic",
            "numbers": [
                ["name": "Leaving Hogwarts",
                "description": "Harry leaves Hogwarts",
                "partiture": "leaving_hogwarts",
                "muziekfragment": "leaving_hogwarts_sound",
                "album": "Harry Potter",
                "theme": "Filmmusic"]
            ],
            "description": "Songs of the movie of Harry Potter",
            "image": "harry_potter"

        ]
        
        XCTAssertThrowsError(_ = try Album(json: json)) {
            error in
            guard case Persistence.Error.missingJsonProperty(name: "name") = error else {
                XCTFail("Unexpected error \(error)")
                return
            }
        }
    }
    
    func testMissingNumbers() {
        let json: [String: Any] = [
            "name": "Harry Potter",
            "theme": "Filmmusic",
            "description": "Songs of the movie of Harry Potter",
            "image": "harry_potter"

        ]
        
        XCTAssertThrowsError(_ = try Album(json: json)) {
            error in
            guard case Persistence.Error.missingJsonProperty(name: "numbers") = error else {
                XCTFail("Unexpected error \(error)")
                return
            }
        }
    }
    
    func testNonDictionaryNumbers() {
        let json: [String: Any] = [
            "name": "Harry Potter",
            "theme": "Filmmusic",
            "numbers": ["Leaving Hogwarts","Harry leaves Hogwarts", "leaving_hogwarts",
                 "leaving_hogwarts_sound","Harry Potter","Filmmusic"],
            "description": "Songs of the movie of Harry Potter",
            "image": "harry_potter"

        ]
        
        XCTAssertThrowsError(_ = try Album(json: json)) {
            error in
            guard case Persistence.Error.missingJsonProperty(name: "numbers") = error else {
                XCTFail("Unexpected error \(error)")
                return
            }
        }
    }
    
    func testNonStringTheme() {
        let json: [String: Any] = [
            "name": "Harry Potter",
            "theme": 40,
            "numbers": [
                ["name": "Leaving Hogwarts",
                "description": "Harry leaves Hogwarts",
                "partiture": "leaving_hogwarts",
                "muziekfragment": "leaving_hogwarts_sound",
                "album": "Harry Potter",
                "theme": "Filmmusic"]
            ],
            "description": "Songs of the movie of Harry Potter",
            "image": "harry_potter"

        ]
        
        XCTAssertThrowsError(_ = try Album(json: json)) {
            error in
            guard case Persistence.Error.missingJsonProperty(name: "theme") = error else {
                XCTFail("Unexpected error \(error)")
                return
            }
        }
    }
    
    func testNonStringImage() {
        let json: [String: Any] = [
            "name": "Harry Potter",
            "theme": "Filmmusic",
            "numbers": [
                ["name": "Leaving Hogwarts",
                "description": "Harry leaves Hogwarts",
                "partiture": "leaving_hogwarts",
                "muziekfragment": "leaving_hogwarts_sound",
                "album": "Harry Potter",
                "theme": "Filmmusic"]
            ],
            "description": "Songs of the movie of Harry Potter",
            "image": 2.5
        ]
        
        XCTAssertThrowsError(_ = try Album(json: json)) {
            error in
            guard case Persistence.Error.missingJsonProperty(name: "image") = error else {
                XCTFail("Unexpected error \(error)")
                return
            }
        }
    }
    
}
