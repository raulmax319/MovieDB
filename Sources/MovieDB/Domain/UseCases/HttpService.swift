//
// HttpService.swift
//
// Created by Raul Max on 25/06/23.
// Copyright © 2023 Raul Max. All rights reserved.
//

import Foundation

protocol HttpService {
  var httpClient: HttpRequest? { get }
  func getMovies(completion: @escaping (Result<MovieModel, Error>) -> Void)
}
