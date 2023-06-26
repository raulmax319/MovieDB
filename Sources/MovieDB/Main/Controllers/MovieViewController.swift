//
// MovieViewController.swift
//
// Created by Raul Max on 25/06/23.
// Copyright © 2023 Raul Max. All rights reserved.
//

import Foundation
import UIKit

final class MovieViewController: UIViewController {
  private lazy var movieView: MovieView = {
    return MovieView()
  }()

  override func loadView() {
    super.loadView()

    view = movieView
  }
}
