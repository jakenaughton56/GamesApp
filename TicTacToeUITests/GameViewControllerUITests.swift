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
        continueAfterFailure = false
        XCUIApplication().launch()
        let app = XCUIApplication()
        app.buttons["startGame"].tap()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testIntialState() {
        humanVsHumanSetUp()
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
        humanVsHumanSetUp()
        let app = XCUIApplication()
        app.buttons["topLeft"].tap()
        XCTAssertTrue(app.staticTexts[localized("Player Two's Turn")].exists)
    }
    
    func testTappingOnTakenSquare() {
        humanVsHumanSetUp()
        let app = XCUIApplication()
        app.buttons["topLeft"].tap()
        XCTAssertTrue(app.staticTexts[localized("Player Two's Turn")].exists)
        XCTAssertFalse(app.staticTexts[localized("Player One's Turn")].exists)
        app.buttons["topLeft"].tap()
        XCTAssertTrue(app.staticTexts[localized("Player Two's Turn")].exists)
        XCTAssertFalse(app.staticTexts[localized("Player One's Turn")].exists)
    }
    
    func testAlternatingPlayers() {
        humanVsHumanSetUp()
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
        humanVsHumanSetUp()
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
        humanVsHumanSetUp()
        let app = XCUIApplication()
        straightWinForPlayerOne(app: app)
        XCTAssertTrue(app.staticTexts[localized("Player One Wins!")].exists)
    }
    
    func testPlayerOneWinDiagonal() {
        humanVsHumanSetUp()
        let app = XCUIApplication()
        app.buttons["topLeft"].tap()
        app.buttons["top"].tap()
        app.buttons["centre"].tap()
        app.buttons["topRight"].tap()
        app.buttons["bottomRight"].tap()
        XCTAssertTrue(app.staticTexts[localized("Player One Wins!")].exists)
    }
    
    func testPlayerTwoWinStraight() {
        humanVsHumanSetUp()
        let app = XCUIApplication()
        straightWinForPlayerTwo(app: app)
        XCTAssertTrue(app.staticTexts[localized("Player Two Wins!")].exists)
    }
    
    func testPlayerTwoWinDiagonal() {
        humanVsHumanSetUp()
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
        humanVsHumanSetUp()
        let app = XCUIApplication()
        app.buttons["topLeft"].tap()
        app.buttons["bottom"].tap()
        app.buttons["right"].tap()
        app.buttons["newGame"].tap()
        XCTAssertTrue(app.staticTexts[localized("Player One's Turn")].exists)
    }
    
    func testPlayerOneIncreaseScore() {
        humanVsHumanSetUp()
        let app = XCUIApplication()
        straightWinForPlayerOne(app: app)
        XCTAssertTrue(app.staticTexts["playerOneScore"].label == "1")
    }
    
    func testPlayerOneIncreaseScoreTwice() {
        humanVsHumanSetUp()
        let app = XCUIApplication()
        straightWinForPlayerOne(app: app)
        app.buttons["newGame"].tap()
        straightWinForPlayerOne(app: app)
        XCTAssertTrue(app.staticTexts["playerOneScore"].label == "2")
    }
    
    func testPlayerTwoIncreaseScore() {
        humanVsHumanSetUp()
        let app = XCUIApplication()
        straightWinForPlayerTwo(app: app)
        XCTAssertTrue(app.staticTexts["playerTwoScore"].label == "1")
    }
    
    func testPlayerTwoIncreaseScoreTwice() {
        humanVsHumanSetUp()
        let app = XCUIApplication()
        straightWinForPlayerTwo(app: app)
        app.buttons["newGame"].tap()
        straightWinForPlayerTwo(app: app)
        XCTAssertTrue(app.staticTexts["playerTwoScore"].label == "2")
        
    }
    
    func testEasyComputerPlaysMove() {
        easyComputerSetUp()
        let app = XCUIApplication()
        app.buttons["centre"].tap()
        XCTAssertFalse(app.staticTexts[localized("Your Turn")].exists)
        XCTAssertTrue(app.staticTexts[localized("Computer's Turn")].exists)
        sleep(4)
        XCTAssertTrue(app.staticTexts[localized("Your Turn")].exists)
        XCTAssertFalse(app.staticTexts[localized("Computer's Turn")].exists)
    }
    
    private func localized(_ key: String) -> String {
        let uiTestBundle = Bundle(for: GameViewControllerUITests.self)
        return NSLocalizedString(key, bundle: uiTestBundle, comment: "")
    }
    
    private func humanVsHumanSetUp() {
        let app = XCUIApplication()
        app.buttons["humanVsHuman"].tap()
    }
    
    private func easyComputerSetUp() {
        let app = XCUIApplication()
        app.buttons["easyMode"].tap()
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
