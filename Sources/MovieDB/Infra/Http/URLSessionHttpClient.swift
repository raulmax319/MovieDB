//
// URLSessionHttpClient.swift
//
// Created by Raul Max on 25/06/23.
// Copyright © 2023 Raul Max. All rights reserved.
//

import Foundation

final class URLSessionHttpClient: HttpRequest {
  private let session: URLSession
  private let url: URL
  private lazy var request: URLRequest = {
    return URLRequest(url: url)
  }()

  public init(
    with url: URL,
    session: URLSession = URLSession(configuration: URLSessionConfiguration.default)
  ) {
    self.url = url
    self.session = session
  }

  func request<R>(completion: @escaping (Result<R, Error>) -> Void) where R: Decodable {
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
