//
//  GamesTODOUITests.swift
//  GamesTODOUITests
//
//  Created by Soft Project on 4/12/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import XCTest

class GamesTODOUITests: XCTestCase {
  
  var app: XCUIApplication!
  
  override func setUp() {
    super.setUp()
    continueAfterFailure = false
    app = XCUIApplication()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testTabBarSearchButtonClick() {
    app.launch()
    app.navigationBars.buttons["searchGamesButton"].tap()
    XCTAssertTrue(app.tables["searchViewTable"].exists)
  }
  
  func testTabBarAddButtonClick() {
    app.launch()
    app.navigationBars.buttons["addGameButton"].tap()
    XCTAssertTrue(app.otherElements["addGameView"].exists)
  }
  
}
