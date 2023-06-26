//
// MovieRouter.swift
//
// Created by Raul Max on 25/06/23.
// Copyright © 2023 Raul Max. All rights reserved.
//

import Foundation
import UIKit

final class MovieRouter: Router {
  private(set) weak var entryPoint: UIViewController?

  static func start() -> Router {
    let router = MovieRouter()

    let interactor: Interactor = MovieInteractor()
    let presenter: Presenter = MoviePresenter()
    presenter.router = router
    presenter.interactor = interactor
    interactor.presenter = presenter

    let movieVC = MovieViewController()
    presenter.view = movieVC.view as? View
    router.entryPoint = movieVC

    return router
  }
}
