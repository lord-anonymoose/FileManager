//
//  CoordinatorService.swift
//  FileManager
//
//  Created by Philipp Lazarev on 03.07.2024.
//

import Foundation
import UIKit

protocol Coordinator {
    func start()
}

final class LoginCoordinator {
    
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let tabBarController = UITabBarController()
        var controllers = [UIViewController]()
        
        let folderViewController = FolderViewController()
        let folderImage = UIImage(systemName: "folder.fill")
        folderViewController.tabBarItem = UITabBarItem(title: nil, image: folderImage, tag: 0)
        controllers.append(folderViewController)
        
        let settingsViewController = SettingsViewController()
        let settingsImage = UIImage(systemName: "gear")
        settingsViewController.tabBarItem = UITabBarItem(title: nil, image: settingsImage, tag: 1)
        controllers.append(settingsViewController)
        
        tabBarController.viewControllers = controllers.map {
            UINavigationController(rootViewController: $0)
        }
        tabBarController.selectedIndex = 0
        
        navigationController.pushViewController(tabBarController, animated: true)
        self.navigationController.setNavigationBarHidden(true, animated: true)
    }
    
    func changePassword() {
        let setPasswordViewController = SetPasswordViewController()
        navigationController.pushViewController(setPasswordViewController, animated: true)
    }
}

