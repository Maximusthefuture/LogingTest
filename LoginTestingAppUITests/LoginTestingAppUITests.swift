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
    
    func testLoginFailable() {
        let phoneTextField = app.textFields["Phone Number"]
        let passwordTextField = app.secureTextFields["Password"]
       
        phoneTextField.tap()
        phoneTextField.typeText("12312312")
        app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
       
        passwordTextField.tap()
        passwordTextField.typeText("devExam111")
    
        
        app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
        let singInButton = XCUIApplication().buttons["Sing In"]
       
        singInButton.tap()
        
        let alert = app.alerts["Error"]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: alert, handler: nil)
        waitForExpectations(timeout: 2, handler: nil)
        alert.buttons["Cancel"].tap()
        XCTAssert(singInButton.waitForExistence(timeout: 2))
    
    }
    
    func testLogicCompleted() {
        let phoneTextField = app.textFields["Phone Number"]
        let passwordTextField = app.secureTextFields["Password"]
       
        phoneTextField.tap()
        phoneTextField.typeText("9005868675")
        app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
       
        passwordTextField.tap()
        passwordTextField.typeText("devExam18")
    
        
        app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
        let singInButton = XCUIApplication().buttons["Sing In"]
        
        singInButton.tap()
        
    }

//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
