//
//  QRFlutterUITests.swift
//  QRFlutterUITests
//
//  Created by Ricardo Rodríguez on 26/03/25.
//

import XCTest

final class QRFlutterUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testScanButtonOpensCameraScannerView() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let scanButton = app.buttons["scanQR"]
        
        XCTAssertTrue(scanButton.exists, "Scan button not found")
        
        scanButton.tap()
        
        let newView = app.otherElements["scanView"]
        
        XCTAssertTrue(newView.waitForExistence(timeout: 3), "Scan View should be displayed after tapping on Escanear QR")
    }
    
    @MainActor
    func testVaultButtonOpensProtectedView() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["vault"].tap()
        
        let alert = app.alerts["Do you want to allow “QRFlutter” to use Face ID?"]
        
        if alert.exists {
            alert.scrollViews.otherElements.buttons["Allow"].tap()
        }
        
        let flutterView = app.otherElements["flutterVaultView"]
        XCTAssertTrue(flutterView.waitForExistence(timeout: 3), "Flutter view should be displayed after biometric authentication is valid")
        
    }
    
    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    
}


