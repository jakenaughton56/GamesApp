//
//  GameModeMenuViewControllerUITests.swift
//  TicTacToeUITests
//
//  Created by Jake Mobile Dev on 7/8/18.
//  Copyright © 2018 JakeMobileDev. All rights reserved.
//

import XCTest

class GameModeMenuViewControllerUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
        let app = XCUIApplication()
        app.buttons["startGame"].tap()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testIntialState() {
        let app = XCUIApplication()
        XCTAssertTrue(app.staticTexts[localized("Game Mode")].exists)
        XCTAssertTrue(app.buttons[localized("Human Vs Human")].exists)
        XCTAssertTrue(app.buttons[localized("Easy")].exists)
    }
    
    func testTappingHumanVsHuman() {
        let app = XCUIApplication()
        app.buttons["humanVsHuman"].tap()
        XCTAssertFalse(app.staticTexts[localized("Game Mode")].exists)
        XCTAssertTrue(app.staticTexts[localized("Player One's Turn")].exists)
    }
    
    func testTappingEasyMode() {
        let app = XCUIApplication()
        app.buttons["easyMode"].tap()
        XCTAssertFalse(app.staticTexts[localized("Game Mode")].exists)
        XCTAssertTrue(app.staticTexts[localized("Your Turn")].exists)
    }
    
    private func localized(_ key: String) -> String {
        let uiTestBundle = Bundle(for: GameModeMenuViewControllerUITests.self)
        return NSLocalizedString(key, bundle: uiTestBundle, comment: "")
    }
    
}
