//
//  MainMenuViewControllerUITests.swift
//  TicTacToeUITests
//
//  Created by Jake Mobile Dev on 7/8/18.
//  Copyright © 2018 JakeMobileDev. All rights reserved.
//

import XCTest

class MainMenuViewControllerUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testIntialState() {
        let app = XCUIApplication()
        XCTAssertTrue(app.staticTexts[localized("Tic Tac Toe")].exists)
        XCTAssertTrue(app.buttons[localized("Start Game")].exists)
    }
    
    func testTappingStartNewGame() {
        let app = XCUIApplication()
        app.buttons["startGame"].tap()
        XCTAssertFalse(app.staticTexts[localized("Tic Tac Toe")].exists)
        XCTAssertTrue(app.staticTexts[localized("Game Mode")].exists)
    }
    
    func testTappingNewGameThenTappingBack() {
        let app = XCUIApplication()
        app.buttons["startGame"].tap()
        app.navigationBars["TicTacToe.GameModeMenuView"].buttons["Back"].tap()
        XCTAssertTrue(app.staticTexts[localized("Tic Tac Toe")].exists)
    }
    
    private func localized(_ key: String) -> String {
        let uiTestBundle = Bundle(for: MainMenuViewControllerUITests.self)
        return NSLocalizedString(key, bundle: uiTestBundle, comment: "")
    }
    
}
