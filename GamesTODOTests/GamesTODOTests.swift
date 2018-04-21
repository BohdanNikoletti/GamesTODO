//
//  GamesTODOTests.swift
//  GamesTODOTests
//
//  Created by Soft Project on 4/12/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import XCTest
@testable import GamesTODO

final class GamesTODOTests: XCTestCase {
  
  // MARK: - Properties
  private var presenter: SearchGameViewPresenter?
  private var games: [GameItem] = []

  override func setUp() {
    super.setUp()
    presenter = SearchGameViewPresenter(presenter: self)
    presenter?.getGames()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testFinishedGameSearch() {
    XCTAssert(!games.filter{$0.isFinished}.isEmpty, "There is no finished games")
    let filteredGames = games.filter { game in
      return game.searchContent.lowercased().contains("favorite".lowercased())
    }
    XCTAssert(!filteredGames.isEmpty, "Wrong filter results")
  }
  
  func testSearchPerformanceExample() {
    self.measure {
      let _ = games.filter { game in
        return game.searchContent.lowercased().contains("favorite".lowercased())
      }
    }
  }
}

extension GamesTODOTests: SearchGameView {
  func error(message: String) {
    XCTFail(message)
  }
  
  func show(games: [GameItem]) {
    self.games = games
  }
  
}
