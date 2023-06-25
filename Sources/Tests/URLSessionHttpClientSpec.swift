//
// URLSessionHttpClientSpec.swift
//
// Created by Raul Max on 25/06/23.
// Copyright © 2023 Raul Max. All rights reserved.
//

import Foundation
import XCTest
@testable import MovieDB

final class URLSessionHttpClientSpec: XCTestCase {
  var sut: URLSessionHttpClient!
  var urlSession: URLSession!

  override func setUp() {
    super.setUp()

    let configuration = URLSessionConfiguration.default
    configuration.protocolClasses = [URLProtocolMock.self]
    let urlSession = URLSession(configuration: configuration)
    let request = URLRequest(url: URL(string: "http://localmock:3333")!)
    sut = URLSessionHttpClient(session: urlSession, request: request)
  }

  override func tearDown() {
    sut = nil

    super.tearDown()
  }

  func testSuccessfulResponse() {
    let expectation = expectation(description: "Did call http request")
    let movieName = "TestMovie"
    let movieJson = "{ \"data\": [ { \"title\": \"\(movieName)\" } ] }".data(using: .utf8)
    URLProtocolMock.requestHandler = { request in
      guard let url = request.url else {
        throw URLError(.badURL)
      }

      let response = HTTPURLResponse(
        url: url,
        statusCode: 200,
        httpVersion: nil,
        headerFields: nil
      )!

      return (response, movieJson)
    }

    sut.request { (result: Result<Movie, Error>) in
      guard case let .success(success) = result else {
        XCTFail("Should have been a success")
        return
      }

      XCTAssertTrue(success.data.first?.title == movieName)
      expectation.fulfill()
    }

    wait(for: [expectation], timeout: 1.0)
  }

  func testParsingFailure() {
    let expectation = expectation(description: "Did call http request")

    URLProtocolMock.requestHandler = { request in
      let response = HTTPURLResponse(
        url: request.url!,
        statusCode: 200,
        httpVersion: nil,
        headerFields: nil
      )!
      return (response, Data())
    }

    sut.request { (result: Result<Movie, Error>) in
      guard case let .failure(error) = result else {
        XCTFail("Should have been a failure")
        return
      }

      XCTAssertTrue(error is DecodingError)
      expectation.fulfill()
    }

    wait(for: [expectation], timeout: 1.0)
  }
}
