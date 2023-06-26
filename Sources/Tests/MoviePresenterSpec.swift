//
// MoviePresenterSpec.swift
//
// Created by Raul Max on 25/06/23.
// Copyright © 2023 Raul Max. All rights reserved.
//

import Foundation
import XCTest
@testable import MovieDB

final class MoviePresenterSpec: XCTestCase {
  var view: View!
  var presenter: Presenter!
  var sut: Interactor!

  override func setUp() {
    super.setUp()

    view = MovieView()
    presenter = MoviePresenter()
    sut = MovieInteractor(service: HttpServiceMock())
    sut.presenter = presenter
    presenter.interactor = sut
    presenter.view = view
  }

  override func tearDown() {
    view = nil
    presenter = nil
    sut = nil

    super.tearDown()
  }

  func testFailedToGetMovies() {
    let expectation = expectation(description: "did call getmovies")
    URLProtocolMock.requestHandler = { _ in
      throw URLError(.badURL)
    }

    (sut.service as? HttpServiceMock)?.expectation = expectation
    sut.getMovie()

    wait(for: [expectation], timeout: 1.0)

    XCTAssertNil(
      (view as? MovieView)?.movieModel
    )
  }

  func testSucceededToGetMovies() {
    let expectation = expectation(description: "did call getmovies 2")
    let movieName = "TestMovie"
    let movieJson = "{ \"data\": [ { \"title\": \"\(movieName)\" } ] }".data(using: .utf8)
    URLProtocolMock.requestHandler = { _ in
      let response = HTTPURLResponse()
      return (response, movieJson)
    }

    (sut.service as? HttpServiceMock)?.expectation = expectation
    sut.getMovie()

    wait(for: [expectation], timeout: 1.0)

    XCTAssertTrue(
      (view as? MovieView)?.movieModel?.first?.title == movieName
    )
  }
}
