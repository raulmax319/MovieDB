//
// HttpRequest.swift
//
// Created by Raul Max on 25/06/23.
// Copyright © 2023 Raul Max. All rights reserved.
//

import Foundation

protocol HttpRequest: AnyObject {
  func request<R: Decodable>(completion: @escaping (Result<R, Error>) -> Void)
}
