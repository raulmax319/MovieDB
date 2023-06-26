//
// MoviePresenter.swift
//
// Created by Raul Max on 25/06/23.
// Copyright © 2023 Raul Max. All rights reserved.
//

import Foundation

final class MoviePresenter: Presenter {
  var interactor: Interactor? {
    didSet {
      interactor?.getMovie()
    }
  }

  var router: Router?
  var view: View?
}
