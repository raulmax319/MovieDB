//
// Presenter.swift
//
// Created by Raul Max on 25/06/23.
// Copyright © 2023 Raul Max. All rights reserved.
//

import Foundation

protocol Presenter: AnyObject {
  var router: Router? { get set }
  var interactor: Interactor? { get set }
  var view: View? { get set }
  func interactorDidGet(movies model: [Movie]?)
}

extension Presenter {
  func interactorDidGet(movies model: [Movie]?) {
    guard let model else {
      view?.update(with: "Error while downloading the list.")
      return
    }

    view?.update(with: model)
  }
}
