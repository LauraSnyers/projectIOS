import XCTest
@testable import ProjectIOS

class NumberJSONTests: XCTestCase {
    
    func testValid(){
        let json: [String: Any] = [
            "name": "Leaving Hogwarts",
            "description": "Harry leaves Hogwarts",
            "partiture": "leaving_hogwarts",
            "muziekfragment": "leaving_hogwarts_sound",
            "album": "Harry Potter",
            "theme": "Filmmusic"
        ]
        guard let number = try? Number(json: json) else {
            XCTFail("Unexpected error")
            return
        }
        
        XCTAssertEqual(number.name, "Leaving Hogwarts")
        XCTAssertEqual(number.description, "Harry leaves Hogwarts")
        XCTAssertEqual(number.theme, "Filmmusic")
        XCTAssertEqual(number.partiture, "leaving_hogwarts")
        XCTAssertEqual(number.muziekfragment, "leaving_hogwarts_sound")
        XCTAssertEqual(number.album, "Harry Potter")
    }
    
    func testMissingDescription() {
        let json: [String: Any] = [
            "name": "Leaving Hogwarts",
            "partiture": "leaving_hogwarts",
            "muziekfragment": "leaving_hogwarts_sound",
            "album": "Harry Potter",
            "theme": "Filmmusic"
        ]
        
        XCTAssertThrowsError(_ = try Number(json: json)) {
            error in
            guard case Persistence.Error.missingJsonProperty(name: "description") = error else {
                XCTFail("Unexpected error \(error)")
                return
            }
        }
    }
    
    func testNonStringDescription() {
        let json: [String: Any] = [
            "name": "Leaving Hogwarts",
            "description": 30,
            "partiture": "leaving_hogwarts",
            "muziekfragment": "leaving_hogwarts_sound",
            "album": "Harry Potter",
            "theme": "Filmmusic"
        ]
        
        XCTAssertThrowsError(_ = try Number(json: json)) {
            error in
            guard case Persistence.Error.missingJsonProperty(name: "description") = error else {
                XCTFail("Unexpected error \(error)")
                return
            }
        }
    }
    
    func testMissingName() {
        let json: [String: Any] = [
            "description": "Harry leaves Hogwarts",
            "partiture": "leaving_hogwarts",
            "muziekfragment": "leaving_hogwarts_sound",
            "album": "Harry Potter",
            "theme": "Filmmusic"
            
        ]
        
        XCTAssertThrowsError(_ = try Number(json: json)) {
            error in
            guard case Persistence.Error.missingJsonProperty(name: "name") = error else {
                XCTFail("Unexpected error \(error)")
                return
            }
        }
    }
    
    func testMissingTheme() {
        let json: [String: Any] = [
            "name": "Leaving Hogwarts",
            "description": "Harry leaves Hogwarts",
            "partiture": "leaving_hogwarts",
            "muziekfragment": "leaving_hogwarts_sound",
            "album": "Harry Potter",
        ]
        
        XCTAssertThrowsError(_ = try Number(json: json)) {
            error in
            guard case Persistence.Error.missingJsonProperty(name: "theme") = error else {
                XCTFail("Unexpected error \(error)")
                return
            }
        }
    }
    
    func testMissingPartiture() {
        let json: [String: Any] = [
            "name": "Leaving Hogwarts",
            "description": "Harry leaves Hogwarts",
            "muziekfragment": "leaving_hogwarts_sound",
            "album": "Harry Potter",
            "theme": "Filmmusic"
            ]
        
        XCTAssertThrowsError(_ = try Number(json: json)) {
            error in
            guard case Persistence.Error.missingJsonProperty(name: "partiture") = error else {
                XCTFail("Unexpected error \(error)")
                return
            }
        }
    }
    
    func testNonStringName() {
        let json: [String: Any] = [
            "name": 866,
            "description": "Harry leaves Hogwarts",
            "partiture": "leaving_hogwarts",
            "muziekfragment": "leaving_hogwarts_sound",
            "album": "Harry Potter",
            "theme": "Filmmusic"
            
        ]
        
        XCTAssertThrowsError(_ = try Number(json: json)) {
            error in
            guard case Persistence.Error.missingJsonProperty(name: "name") = error else {
                XCTFail("Unexpected error \(error)")
                return
            }
        }
    }
    
    func testMissingMuziekFragment() {
        let json: [String: Any] = [
            "name": "Leaving Hogwarts",
            "description": "Harry leaves Hogwarts",
            "partiture": "leaving_hogwarts",
            "album": "Harry Potter",
            "theme": "Filmmusic"
        ]
        
        XCTAssertThrowsError(_ = try Number(json: json)) {
            error in
            guard case Persistence.Error.missingJsonProperty(name: "muziekfragment") = error else {
                XCTFail("Unexpected error \(error)")
                return
            }
        }
    }
    
    func testMissingAlbum() {
        let json: [String: Any] = [
            "name": "Leaving Hogwarts",
            "description": "Harry leaves Hogwarts",
            "partiture": "leaving_hogwarts",
            "muziekfragment": "leaving_hogwarts_sound",
            "theme": "Filmmusic"
        ]
        
        XCTAssertThrowsError(_ = try Number(json: json)) {
            error in
            guard case Persistence.Error.missingJsonProperty(name: "album") = error else {
                XCTFail("Unexpected error \(error)")
                return
            }
        }
    }
    
    func testNonStringMuziekFragment() {
        let json: [String: Any] = [
            "name": "Leaving Hogwarts",
            "description": "Harry leaves Hogwarts",
            "partiture": "leaving_hogwarts",
            "muziekfragment": 24,
            "album": "Harry Potter",
            "theme": "Filmmusic"
            
        ]
        
        XCTAssertThrowsError(_ = try Number(json: json)) {
            error in
            guard case Persistence.Error.missingJsonProperty(name: "muziekfragment") = error else {
                XCTFail("Unexpected error \(error)")
                return
            }
        }
    }
    
    func testNonStringTheme() {
        let json: [String: Any] = [
            "name": "Leaving Hogwarts",
            "description": "Harry leaves Hogwarts",
            "partiture": "leaving_hogwarts",
            "muziekfragment": "leaving_hogwarts_sound",
            "album": "Harry Potter",
            "theme": 23.5
            
        ]
        
        XCTAssertThrowsError(_ = try Number(json: json)) {
            error in
            guard case Persistence.Error.missingJsonProperty(name: "theme") = error else {
                XCTFail("Unexpected error \(error)")
                return
            }
        }
    }
    
    func testNonStringAlbum() {
        let json: [String: Any] = [
            "name": "Leaving Hogwarts",
            "description": "Harry leaves Hogwarts",
            "partiture": "leaving_hogwarts",
            "muziekfragment": "leaving_hogwarts_sound",
            "album": 4,
            "theme": "Filmmusic"
        ]
        
        XCTAssertThrowsError(_ = try Number(json: json)) {
            error in
            guard case Persistence.Error.missingJsonProperty(name: "album") = error else {
                XCTFail("Unexpected error \(error)")
                return
            }
        }
    }
    
}
