import XCTest
@testable import ProjectIOS

class StoreJSONTests: XCTestCase {
    
    func testValid(){
        let json: [String: Any] = [
            "name": "Viola da Gamba",
            "adress": "Wetterensteenweg 80",
            "town": "Serskamp",
            "opening_hours": [
                "8u-19u",
                "8u-19u",
                "8u-19u",
                "8u-19u",
                "8u-19u",
                "8u-20u",
                "Closed"
            ],
            "coordinates": [
                50.9942408,
                3.917741200000023
            ]
        ]
        guard let store = try? Store(json: json) else {
            XCTFail("Unexpected error")
            return
        }
        
        XCTAssertEqual(store.name, "Viola da Gamba")
        XCTAssertEqual(store.adress, "Wetterensteenweg 80")
        XCTAssertEqual(store.town, "Serskamp")
        XCTAssertEqual(store.opening_hours[0], "8u-19u")
        XCTAssertEqual(store.opening_hours[1], "8u-19u")
        XCTAssertEqual(store.opening_hours[2], "8u-19u")
        XCTAssertEqual(store.opening_hours[3], "8u-19u")
        XCTAssertEqual(store.opening_hours[4], "8u-19u")
        XCTAssertEqual(store.opening_hours[5], "8u-20u")
        XCTAssertEqual(store.opening_hours[6], "Closed")
        XCTAssertEqual(store.coordinates.latitude, 50.9942408)
        XCTAssertEqual(store.coordinates.longitude, 3.917741200000023)
    }
    
    func testMissingAdress() {
        let json: [String: Any] = [
            "name": "Viola da Gamba",
            "town": "Serskamp",
            "opening_hours": [
                "8u-19u",
                "8u-19u",
                "8u-19u",
                "8u-19u",
                "8u-19u",
                "8u-20u",
                "Closed"
            ],
            "coordinates": [
                50.9942408,
                3.917741200000023
            ]
        ]
        
        XCTAssertThrowsError(_ = try Store(json: json)) {
            error in
            guard case Persistence.Error.missingJsonProperty(name: "adress") = error else {
                XCTFail("Unexpected error \(error)")
                return
            }
        }
    }
    
    func testNonStringAdress() {
        let json: [String: Any] = [
            "name": "Viola da Gamba",
            "adress": 80,
            "town": "Serskamp",
            "opening_hours": [
                "8u-19u",
                "8u-19u",
                "8u-19u",
                "8u-19u",
                "8u-19u",
                "8u-20u",
                "Closed"
            ],
            "coordinates": [
                50.9942408,
                3.917741200000023
            ]
        ]
        
        XCTAssertThrowsError(_ = try Store(json: json)) {
            error in
            guard case Persistence.Error.missingJsonProperty(name: "adress") = error else {
                XCTFail("Unexpected error \(error)")
                return
            }
        }
    }
    
    func testMissingName() {
        let json: [String: Any] = [
            "adress": "Wetterensteenweg 80",
            "town": "Serskamp",
            "opening_hours": [
                "8u-19u",
                "8u-19u",
                "8u-19u",
                "8u-19u",
                "8u-19u",
                "8u-20u",
                "Closed"
            ],
            "coordinates": [
                50.9942408,
                3.917741200000023
            ]        ]
        
        XCTAssertThrowsError(_ = try Store(json: json)) {
            error in
            guard case Persistence.Error.missingJsonProperty(name: "name") = error else {
                XCTFail("Unexpected error \(error)")
                return
            }
        }
    }
    
    func testMissingTown() {
        let json: [String: Any] = [
            "name": "Viola da Gamba",
            "adress": "Wetterensteenweg 80",
            "opening_hours": [
                "8u-19u",
                "8u-19u",
                "8u-19u",
                "8u-19u",
                "8u-19u",
                "8u-20u",
                "Closed"
            ],
            "coordinates": [
                50.9942408,
                3.917741200000023
            ]
        ]
        
        XCTAssertThrowsError(_ = try Store(json: json)) {
            error in
            guard case Persistence.Error.missingJsonProperty(name: "town") = error else {
                XCTFail("Unexpected error \(error)")
                return
            }
        }
    }
    
    func testMissingOpenings_hours() {
        let json: [String: Any] = [
            "name": "Viola da Gamba",
            "adress": "Wetterensteenweg 80",
            "town": "Serskamp",
            "coordinates": [
                50.9942408,
                3.917741200000023
            ]
            ]
        
        XCTAssertThrowsError(_ = try Store(json: json)) {
            error in
            guard case Persistence.Error.missingJsonProperty(name: "opening_hours") = error else {
                XCTFail("Unexpected error \(error)")
                return
            }
        }
    }
    
    func testNonStringName() {
        let json: [String: Any] = [
            "name": 56,
            "adress": "Wetterensteenweg 80",
            "town": "Serskamp",
            "opening_hours": [
                "8u-19u",
                "8u-19u",
                "8u-19u",
                "8u-19u",
                "8u-19u",
                "8u-20u",
                "Closed"
            ],
            "coordinates": [
                50.9942408,
                3.917741200000023
            ]
            
        ]
        
        XCTAssertThrowsError(_ = try Store(json: json)) {
            error in
            guard case Persistence.Error.missingJsonProperty(name: "name") = error else {
                XCTFail("Unexpected error \(error)")
                return
            }
        }
    }
    
    func testMissingCoordinates() {
        let json: [String: Any] = [
            "name": "Viola da Gamba",
            "adress": "Wetterensteenweg 80",
            "town": "Serskamp",
            "opening_hours": [
                "8u-19u",
                "8u-19u",
                "8u-19u",
                "8u-19u",
                "8u-19u",
                "8u-20u",
                "Closed"
            ],
        ]
        
        XCTAssertThrowsError(_ = try Store(json: json)) {
            error in
            guard case Persistence.Error.missingJsonProperty(name: "coordinates") = error else {
                XCTFail("Unexpected error \(error)")
                return
            }
        }
    }
    
    func testNonStringTown() {
        let json: [String: Any] = [
            "name": "Viola da Gamba",
            "adress": "Wetterensteenweg 80",
            "town": 75,
            "opening_hours": [
                "8u-19u",
                "8u-19u",
                "8u-19u",
                "8u-19u",
                "8u-19u",
                "8u-20u",
                "Closed"
            ],
            "coordinates": [
                50.9942408,
                3.917741200000023
            ]
            
        ]
        
        XCTAssertThrowsError(_ = try Store(json: json)) {
            error in
            guard case Persistence.Error.missingJsonProperty(name: "town") = error else {
                XCTFail("Unexpected error \(error)")
                return
            }
        }
    }
    
        
}
