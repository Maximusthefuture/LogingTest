//
//  LoginTestingAppUITests.swift
//  LoginTestingAppUITests
//
//  Created by Maximus on 12.02.2022.
//

import XCTest

class LoginTestingAppUITests: XCTestCase {
    
    var app: XCUIApplication!
  
    override func setUpWithError() throws {
      try super.setUpWithError()
      continueAfterFailure = false
      app = XCUIApplication()
      app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        app = nil
    }
    
    func testLogin() {
        var button = app.textFields["Phone Number"]
        button.waitForExistence(timeout: 3)
        button.tap()
        button.typeText("12312312")
        XCUIApplication().windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
        let singInButton = XCUIApplication().buttons["Sing In"]
        singInButton.waitForExistence(timeout: 2)
        singInButton.tap()
       
        
        
        
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
