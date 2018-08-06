//
//  GameViewControllerUITests.swift
//  TicTacToeUITests
//
//  Created by Jake Mobile Dev on 1/8/18.
//  Copyright © 2018 JakeMobileDev. All rights reserved.
//

import XCTest

class GameViewControllerUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testIntialState() {
        let app = XCUIApplication()
        XCTAssertTrue(app.staticTexts[localized("Player One's Turn")].exists)
        XCTAssertTrue(app.buttons[localized("New Game")].exists)
        XCTAssertTrue(app.buttons[localized("Back")].exists)
        XCTAssertTrue(app.staticTexts[localized("Player One")].exists)
        XCTAssertTrue(app.staticTexts[localized("Player Two")].exists)
        XCTAssertTrue(app.staticTexts["playerOneScore"].label == "0")
        XCTAssertTrue(app.staticTexts["playerTwoScore"].label == "0")
    }
    
    func testPlayingFirstMove() {
        let app = XCUIApplication()
        app.buttons["topLeft"].tap()
        XCTAssertTrue(app.staticTexts[localized("Player Two's Turn")].exists)
    }
    
    func testTappingOnTakenSquare() {
        let app = XCUIApplication()
        app.buttons["topLeft"].tap()
        XCTAssertTrue(app.staticTexts[localized("Player Two's Turn")].exists)
        XCTAssertFalse(app.staticTexts[localized("Player One's Turn")].exists)
        app.buttons["topLeft"].tap()
        XCTAssertTrue(app.staticTexts[localized("Player Two's Turn")].exists)
        XCTAssertFalse(app.staticTexts[localized("Player One's Turn")].exists)
    }
    
    func testAlternatingPlayers() {
        let app = XCUIApplication()
        XCTAssertTrue(app.staticTexts[localized("Player One's Turn")].exists)
        XCTAssertFalse(app.staticTexts[localized("Player Two's Turn")].exists)
        app.buttons["topLeft"].tap()
        XCTAssertTrue(app.staticTexts[localized("Player Two's Turn")].exists)
        XCTAssertFalse(app.staticTexts[localized("Player One's Turn")].exists)
        app.buttons["topRight"].tap()
        XCTAssertTrue(app.staticTexts[localized("Player One's Turn")].exists)
        XCTAssertFalse(app.staticTexts[localized("Player Two's Turn")].exists)
        app.buttons["top"].tap()
        XCTAssertTrue(app.staticTexts[localized("Player Two's Turn")].exists)
        XCTAssertFalse(app.staticTexts[localized("Player One's Turn")].exists)
        app.buttons["bottom"].tap()
        XCTAssertTrue(app.staticTexts[localized("Player One's Turn")].exists)
        XCTAssertFalse(app.staticTexts[localized("Player Two's Turn")].exists)
    }
    
    func testTestingFullBoard() {
        let app = XCUIApplication()
        app.buttons["centre"].tap()
        app.buttons["topLeft"].tap()
        app.buttons["top"].tap()
        app.buttons["left"].tap()
        app.buttons["bottomLeft"].tap()
        app.buttons["topRight"].tap()
        app.buttons["right"].tap()
        app.buttons["bottom"].tap()
        app.buttons["bottomRight"].tap()
        XCTAssertTrue(app.staticTexts[localized("Draw!")].exists)
    }
    
    func testPlayerOneWinStraight() {
        let app = XCUIApplication()
        straightWinForPlayerOne(app: app)
        XCTAssertTrue(app.staticTexts[localized("Player One Wins!")].exists)
    }
    
    func testPlayerOneWinDiagonal() {
        let app = XCUIApplication()
        app.buttons["topLeft"].tap()
        app.buttons["top"].tap()
        app.buttons["centre"].tap()
        app.buttons["topRight"].tap()
        app.buttons["bottomRight"].tap()
        XCTAssertTrue(app.staticTexts[localized("Player One Wins!")].exists)
    }
    
    func testPlayerTwoWinStraight() {
        let app = XCUIApplication()
        straightWinForPlayerTwo(app: app)
        XCTAssertTrue(app.staticTexts[localized("Player Two Wins!")].exists)
    }
    
    func testPlayerTwoWinDiagonal() {
        let app = XCUIApplication()
        app.buttons["topLeft"].tap()
        app.buttons["topRight"].tap()
        app.buttons["left"].tap()
        app.buttons["centre"].tap()
        app.buttons["bottomRight"].tap()
        app.buttons["bottomLeft"].tap()
        XCTAssertTrue(app.staticTexts[localized("Player Two Wins!")].exists)
    }
    
    func testStartingNewGame() {
        let app = XCUIApplication()
        app.buttons["topLeft"].tap()
        app.buttons["bottom"].tap()
        app.buttons["right"].tap()
        app.buttons["newGame"].tap()
        XCTAssertTrue(app.staticTexts[localized("Player One's Turn")].exists)
    }
    
    func testPlayerOneIncreaseScore() {
        let app = XCUIApplication()
        straightWinForPlayerOne(app: app)
        XCTAssertTrue(app.staticTexts["playerOneScore"].label == "1")
    }
    
    func testPlayerOneIncreaseScoreTwice() {
        let app = XCUIApplication()
        straightWinForPlayerOne(app: app)
        app.buttons["newGame"].tap()
        straightWinForPlayerOne(app: app)
        XCTAssertTrue(app.staticTexts["playerOneScore"].label == "2")
    }
    
    func testPlayerTwoIncreaseScore() {
        let app = XCUIApplication()
        straightWinForPlayerTwo(app: app)
        XCTAssertTrue(app.staticTexts["playerTwoScore"].label == "1")
    }
    
    func testPlayerTwoIncreaseScoreTwice() {
        let app = XCUIApplication()
        straightWinForPlayerTwo(app: app)
        app.buttons["newGame"].tap()
        straightWinForPlayerTwo(app: app)
        XCTAssertTrue(app.staticTexts["playerTwoScore"].label == "2")
        
    }
    
    private func localized(_ key: String) -> String {
        let uiTestBundle = Bundle(for: GameViewControllerUITests.self)
        return NSLocalizedString(key, bundle: uiTestBundle, comment: "")
    }
    
    private func straightWinForPlayerOne(app: XCUIApplication) {
        app.buttons["topLeft"].tap()
        app.buttons["top"].tap()
        app.buttons["left"].tap()
        app.buttons["centre"].tap()
        app.buttons["bottomLeft"].tap()
    }
    
    private func straightWinForPlayerTwo(app: XCUIApplication) {
        app.buttons["topLeft"].tap()
        app.buttons["top"].tap()
        app.buttons["left"].tap()
        app.buttons["centre"].tap()
        app.buttons["topRight"].tap()
        app.buttons["bottom"].tap()
    }
}
