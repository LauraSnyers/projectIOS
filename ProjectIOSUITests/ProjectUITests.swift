import XCTest
@testable import ProjectIOS

class ProjectUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launchArguments.append("USE_LOCAL_DATA")
        app.launch()
    }
    
    func testMasterIsAccessibleOnStartup() {
        let app = XCUIApplication()
        XCTAssert(app.navigationBars["Albums"].exists)
        if !app.navigationBars["Albums"].isHittable {
            XCTAssert(app.buttons["Back"].exists)
        }
    }
    
    func testCellCount() {
        let app = XCUIApplication()
        if !app.navigationBars["Albums"].isHittable {
            app.buttons["Back"].tap()
        }
        XCTAssert(app.tables.cells.count == 4)
    }
    
    func testShowAlbumsSegue() {
        let app = XCUIApplication()
        if !app.navigationBars["Albums"].isHittable {
            app.buttons["Back"].tap()
        }
        app.tables.staticTexts["Harry Potter"].tap()
        XCTAssert(app.navigationBars["Numbers"].exists)
        app.tables.staticTexts["Leaving Hogwarts"].tap()
        XCTAssert(app.staticTexts["Album: Harry Potter"].exists)
    }
    
    func testMasterAccessibleAfterSegue() {
        let app = XCUIApplication()
        if !app.navigationBars["Albums"].isHittable {
            app.buttons["Back"].tap()
        }
        app.tables.staticTexts["Harry Potter"].tap()
        if !app.navigationBars["Albums"].exists {
            XCTAssert(app.buttons["Back"].exists)
        }
    }
    
    func testThemesAfterStartUp(){
        let app = XCUIApplication()
        XCUIApplication().tabBars.buttons["Themes"].tap()
        XCTAssert(app.navigationBars["Themes"].exists)
        if !app.navigationBars["Themes"].isHittable {
            XCTAssert(app.buttons["Back"].exists)
        }
        
    }
    
    func testCellCountThemes() {
        let app = XCUIApplication()
        XCUIApplication().tabBars.buttons["Themes"].tap()
        if !app.navigationBars["Themes"].isHittable {
            app.buttons["Back"].tap()
        }
        XCTAssert(app.tables.cells.count == 2)
    }
    
    func testShowThemesSegue() {
        let app = XCUIApplication()
        XCUIApplication().tabBars.buttons["Themes"].tap()
        if !app.navigationBars["Themes"].isHittable {
            app.buttons["Back"].tap()
        }
        app.tables.staticTexts["Filmmusic"].tap()
        XCTAssert(app.navigationBars["Numbers"].exists)
        app.tables.staticTexts["Leaving Hogwarts"].tap()
        XCTAssert(app.staticTexts["Harry Potter"].exists)
    }
    
    func testMasterAccessibleAfterSegueThemes() {
        let app = XCUIApplication()
        XCUIApplication().tabBars.buttons["Themes"].tap()
        if !app.navigationBars["Themes"].isHittable {
            app.buttons["Back"].tap()
        }
        app.tables.staticTexts["Filmmusic"].tap()
        if !app.navigationBars["Themes"].exists {
            XCTAssert(app.buttons["Back"].exists)
        }
    }
    
    func testNumbersAfterStartUp(){
        let app = XCUIApplication()
        XCUIApplication().tabBars.buttons["Numbers"].tap()
        XCTAssert(app.navigationBars["Numbers"].exists)
        if !app.navigationBars["Numbers"].isHittable {
            XCTAssert(app.buttons["Back"].exists)
        }
        
    }
    
    func testCellCountNumbers() {
        let app = XCUIApplication()
        XCUIApplication().tabBars.buttons["Numbers"].tap()
        if !app.navigationBars["Numbers"].isHittable {
            app.buttons["Back"].tap()
        }
        XCTAssert(app.tables.cells.count == 4)
    }
    
    func testShowNumbersSegue() {
        let app = XCUIApplication()
        XCUIApplication().tabBars.buttons["Numbers"].tap()
        if !app.navigationBars["Numbers"].isHittable {
            app.buttons["Back"].tap()
        }
        app.tables.staticTexts["Leaving Hogwarts"].tap()
        XCTAssert(app.staticTexts["Album: Harry Potter"].exists)
    }
    
    func testMasterAccessibleAfterSegueNumbers() {
        let app = XCUIApplication()
        XCUIApplication().tabBars.buttons["Numbers"].tap()
        if !app.navigationBars["Numbers"].isHittable {
            app.buttons["Back"].tap()
        }
        app.tables.staticTexts["Leaving Hogwarts"].tap()
        if !app.navigationBars["Themes"].exists {
            XCTAssert(app.buttons["Back"].exists)
        }
    }
    
    func testStoresAfterStartUp(){
        let app = XCUIApplication()
        XCUIApplication().tabBars.buttons["Stores"].tap()
        XCTAssert(app.navigationBars["Stores"].exists)
        if !app.navigationBars["Stores"].isHittable {
            XCTAssert(app.buttons["Back"].exists)
        }
        
    }
    
    func testCellCountStores() {
        let app = XCUIApplication()
        XCUIApplication().tabBars.buttons["Stores"].tap()
        if !app.navigationBars["Stores"].isHittable {
            app.buttons["Back"].tap()
        }
        XCTAssert(app.tables.cells.count == 1)
    }
    
    func testShowStoresSegue() {
        let app = XCUIApplication()
        XCUIApplication().tabBars.buttons["Stores"].tap()
        if !app.navigationBars["Stores"].isHittable {
            app.buttons["Back"].tap()
        }
        app.tables.staticTexts["Viola da Gamba"].tap()
        XCTAssert(app.staticTexts["Serskamp"].exists)
    }
    
    func testMasterAccessibleAfterSegueStores() {
        let app = XCUIApplication()
        XCUIApplication().tabBars.buttons["Stores"].tap()
        if !app.navigationBars["Stores"].isHittable {
            app.buttons["Back"].tap()
        }
        app.tables.staticTexts["Viola da Gamba"].tap()
        if !app.navigationBars["Stores"].exists {
            XCTAssert(app.buttons["Back"].exists)
        }
    }
    
}
