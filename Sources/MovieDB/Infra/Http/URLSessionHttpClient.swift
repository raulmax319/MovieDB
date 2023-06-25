//
// URLSessionHttpClient.swift
//
// Created by Raul Max on 25/06/23.
// Copyright © 2023 Raul Max. All rights reserved.
//

import Foundation

final class URLSessionHttpClient: HttpRequest {
  private let session: URLSession

  private lazy var request: URLRequest? = {
    guard
      let url = URL(string: "http://localhost:3000/v1/find/anime/kimi%20no%20na%20wa/english")
    else {
      return nil
    }

    return URLRequest(url: url)
  }()

  public init(
    session: URLSession = URLSession(configuration: URLSessionConfiguration.default),
    request: URLRequest? = nil
  ) {
    self.session = session
    self.request = request
  }

  func request<R>(completion: @escaping (Result<R, Error>) -> Void) where R: Decodable {
    guard let request else {
      completion(.failure(URLError(.badURL)))
      return
    }

    let task = session.dataTask(with: request) { data, _, error in
      guard let data, error == nil else {
        completion(.failure(URLError(.cannotDecodeRawData)))
        return
      }

      do {
        let response = try JSONDecoder().decode(R.self, from: data)
        completion(.success(response))
      } catch {
        completion(.failure(error))
      }
    }
    task.resume()
  }
}
