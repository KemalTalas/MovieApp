//
//  AppDelegate.swift
//  MovieApp
//
//  Created by Kemal Burak Talas on 14.03.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow()
        let viewModel = MainViewModel()
        let mainView = MainViewController(with: viewModel)
        let mainNavController = UINavigationController(rootViewController: mainView)
        window?.rootViewController = mainNavController
        window?.makeKeyAndVisible()
        
        cancelTranslucentNavBar()
        
        return true
    }
    
    func cancelTranslucentNavBar() {
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

