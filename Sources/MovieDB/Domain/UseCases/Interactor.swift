//
// Interactor.swift
//
// Created by Raul Max on 25/06/23.
// Copyright © 2023 Raul Max. All rights reserved.
//

import Foundation

protocol Interactor: AnyObject {
  var presenter: Presenter? { get set }
  var service: HttpService { get }
  func getMovie()
}
