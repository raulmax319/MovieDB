//
// HttpServiceMock.swift
//
// Created by Raul Max on 25/06/23.
// Copyright © 2023 Raul Max. All rights reserved.
//

import Foundation
import XCTest
@testable import MovieDB

final class HttpServiceMock: HttpService {
  private(set) lazy var httpClient: HttpRequest? = {
    let configuration = URLSessionConfiguration.default
    configuration.protocolClasses = [URLProtocolMock.self]
    let urlSession = URLSession(configuration: configuration)
    return URLSessionHttpClient(with: URL(string: "http://localmock:3333")!, session: urlSession)
  }()

  var expectation: XCTestExpectation?

  func getMovies(completion: @escaping (Result<MovieModel, Error>) -> Void) {
    httpClient?.request { (result: Result<MovieModel, Error>) in
      completion(result)
      self.expectation?.fulfill()
      self.expectation = nil
    }
  }
}
