import XCTest
@testable import ProjectIOS

class ThemeJSONTests: XCTestCase {
    
    func testValid(){
        let json: [String: Any] = [
            "name": "Filmmusic",
            "description": "Music of a movie",
            "numbers": [
                [
                    "name": "Leaving Hogwarts",
                    "description": "Harry leaves Hogwarts",
                    "partiture": "leaving_hogwarts",
                    "muziekfragment": "leaving_hogwarts_sound",
                    "album": "Harry Potter",
                    "theme": "Filmmusic"
                ]
            ]
        ]
        guard let theme = try? Theme(json: json) else {
            XCTFail("Unexpected error")
            return
        }
        
        XCTAssertEqual(theme.name, "Filmmusic")
        XCTAssertEqual(theme.description, "Music of a movie")
        XCTAssertEqual(theme.numbers[0].name, "Leaving Hogwarts")
        XCTAssertEqual(theme.numbers[0].description, "Harry leaves Hogwarts")
        XCTAssertEqual(theme.numbers[0].partiture, "leaving_hogwarts")
        XCTAssertEqual(theme.numbers[0].muziekfragment, "leaving_hogwarts_sound")
        XCTAssertEqual(theme.numbers[0].album, "Harry Potter")
        XCTAssertEqual(theme.numbers[0].theme, "Filmmusic")
    }
    
    func testMissingDescription() {
        let json: [String: Any] = [
            "name": "Filmmusic",
            "numbers": [
                [
                    "name": "Leaving Hogwarts",
                    "description": "Harry leaves Hogwarts",
                    "partiture": "leaving_hogwarts",
                    "muziekfragment": "leaving_hogwarts_sound",
                    "album": "Harry Potter",
                    "theme": "Filmmusic"
                ]
            ]
        ]
        
        XCTAssertThrowsError(_ = try Theme(json: json)) {
            error in
            guard case Persistence.Error.missingJsonProperty(name: "description") = error else {
                XCTFail("Unexpected error \(error)")
                return
            }
        }
    }
    
    func testNonStringDescription() {
        let json: [String: Any] = [
            "name": "Filmmusic",
            "description": 20,
            "numbers": [
                [
                    "name": "Leaving Hogwarts",
                    "description": "Harry leaves Hogwarts",
                    "partiture": "leaving_hogwarts",
                    "muziekfragment": "leaving_hogwarts_sound",
                    "album": "Harry Potter",
                    "theme": "Filmmusic"
                ]
            ]
        ]
        
        XCTAssertThrowsError(_ = try Theme(json: json)) {
            error in
            guard case Persistence.Error.missingJsonProperty(name: "description") = error else {
                XCTFail("Unexpected error \(error)")
                return
            }
        }
    }
    
    func testMissingName() {
        let json: [String: Any] = [
            "description": "Music of a movie",
            "numbers": [
                [
                    "name": "Leaving Hogwarts",
                    "description": "Harry leaves Hogwarts",
                    "partiture": "leaving_hogwarts",
                    "muziekfragment": "leaving_hogwarts_sound",
                    "album": "Harry Potter",
                    "theme": "Filmmusic"
                ]
            ]
            
        ]
        
        XCTAssertThrowsError(_ = try Theme(json: json)) {
            error in
            guard case Persistence.Error.missingJsonProperty(name: "name") = error else {
                XCTFail("Unexpected error \(error)")
                return
            }
        }
    }
    
    func testMissingNumbers() {
        let json: [String: Any] = [
            "name": "Filmmusic",
            "description": "Music of a movie",
            
        ]
        
        XCTAssertThrowsError(_ = try Theme(json: json)) {
            error in
            guard case Persistence.Error.missingJsonProperty(name: "numbers") = error else {
                XCTFail("Unexpected error \(error)")
                return
            }
        }
    }
    
    
    func testNonStringName() {
        let json: [String: Any] = [
            "name": 4,
            "description": "Music of a movie",
            "numbers": [
                [
                    "name": "Leaving Hogwarts",
                    "description": "Harry leaves Hogwarts",
                    "partiture": "leaving_hogwarts",
                    "muziekfragment": "leaving_hogwarts_sound",
                    "album": "Harry Potter",
                    "theme": "Filmmusic"
                ]
            ]
            
        ]
        
        XCTAssertThrowsError(_ = try Theme(json: json)) {
            error in
            guard case Persistence.Error.missingJsonProperty(name: "name") = error else {
                XCTFail("Unexpected error \(error)")
                return
            }
        }
    }
    
    func testNonDictionaryNumbers() {
        let json: [String: Any] = [
            "name": "Filmmusic",
            "description": "Music of a movie",
            "numbers": [
                ["Leaving Hogwarts", "Harry leaves Hogwarts", "leaving_hogwarts", "leaving_hogwarts_sound","Harry Potter", "Filmmusic"
                ]
            ]
            
        ]
        
        XCTAssertThrowsError(_ = try Theme(json: json)) {
            error in
            guard case Persistence.Error.missingJsonProperty(name: "numbers") = error else {
                XCTFail("Unexpected error \(error)")
                return
            }
        }
    }
}
