//
// AppDelegate.swift
// Template
//
// Created by Raul Max on 07/23/22.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let window = UIWindow(frame: UIScreen.main.bounds)
    let router = MovieRouter.start()
    let initialViewController = router.entryPoint

    window.rootViewController = initialViewController
    window.makeKeyAndVisible()
    self.window = window

    return true
  }
}
