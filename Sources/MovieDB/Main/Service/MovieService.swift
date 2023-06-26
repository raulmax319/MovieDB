//
// MovieService.swift
//
// Created by Raul Max on 25/06/23.
// Copyright © 2023 Raul Max. All rights reserved.
//

import Foundation

final class MovieService: HttpService {
  private(set) lazy var httpClient: HttpRequest? = {
    guard
      let url = URL(string: "http://localhost:3000/v1/find/anime/kimi%20no%20na%20wa/english")
    else {
      return nil
    }

    return URLSessionHttpClient(with: url)
  }()

  func getMovies(completion: @escaping (Result<MovieModel, Error>) -> Void) {
    httpClient?.request(completion: completion)
  }
}
