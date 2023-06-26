//
// MovieInteractor.swift
//
// Created by Raul Max on 25/06/23.
// Copyright © 2023 Raul Max. All rights reserved.
//

import Foundation

final class MovieInteractor: Interactor {
  internal let service: HttpService

  var presenter: Presenter?

  init(service: HttpService = MovieService()) {
    self.service = service
  }

  func getMovie() {
    service.getMovies { [unowned self] result in
      guard case let .success(movies) = result else {
        presenter?.interactorDidGet(movies: nil)
        return
      }

      presenter?.interactorDidGet(movies: movies.data)
    }
  }
}
