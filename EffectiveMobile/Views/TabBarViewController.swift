//
//  ViewController.swift
//  EffectiveMobile
//
//  Created by Марат Хасанов on 28.05.2024.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Login")
        setupTabBar()
    }
    
    private func setupTabBar() {
        viewControllers = createViewController()
        tabBar.unselectedItemTintColor = .bGrey6
    }
    
    private func createViewController() -> [UIViewController] {
        let serachViewController = createNavController(for: AirTicketsViewController(),
                                                       title: "Авиабилеты",
                                                       imageName: "airTicketsIcon")
        let favoriteViewController = createNavController(for: HotelsViewController(),
                                                         title: "Отели",
                                                         imageName: "hotelsIcon")
        let responseViewController = createNavController(for: ShortViewController(),
                                                         title: "Короче", imageName:
                                                            "inShortIcon")
        let messageViewController = createNavController(for: SubscriptionViewController(),
                                                        title: "Подписки",
                                                        imageName: "subscriptionIcon")
        let profileViewControlle = createNavController(for: ProfileViewController(),
                                                       title: "Профиль",
                                                       imageName: "profileIcon")
        
        return [serachViewController, favoriteViewController, responseViewController, messageViewController, profileViewControlle]
    }
    
    private func createNavController(for rootViewController: UIViewController,
                                     title: String, 
                                     imageName: String) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem = UITabBarItem(title: title, 
                                                image: UIImage(named: imageName), tag: 0)
        return navController
    }
}
    
   
    
    
