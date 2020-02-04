//
//  AppDelegate.swift
//  ARHologram
//
//  Created by Igor Djachenko on 15/11/2017.
//  Copyright © 2017 Igor Djachenko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navigationVC = UINavigationController()

        let rootVC = HologramsListViewController()

        navigationVC.pushViewController(rootVC, animated: true)

        window = UIWindow(frame: UIScreen.main.bounds)

        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()


        return true
    }
}

