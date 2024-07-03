//
//  SetPasswordViewController.swift
//  FileManager
//
//  Created by Philipp Lazarev on 03.07.2024.
//

import Foundation
import UIKit



class SetPasswordViewController: UIViewController {
    
    
    
    // MARK: - Subviews
    private lazy var emojiView: UIImageView = {
        let image = UIImage(systemName: "lock.fill")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var passwordInputContainer: PasswordInputContainer = {
        let container = PasswordInputContainer()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private lazy var setPasswordButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        button.setTitle("Set Password", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(setPasswordButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        addSubviews()
        setupConstraints()
    }
    
    
    // MARK: - Actions
    @objc func setPasswordButtonTapped(_ button: UIButton) {
        guard self.passwordInputContainer.passwordsMatch() else {
            self.showAlert(message: "Passwords do not match!")
            return
        }
        
        guard self.passwordInputContainer.passwordLengthMatch() else {
            self.showAlert(message: "Password should contain at least 4 characters")
            return
        }
        
        let loginService = LoginService()
        
        loginService.setPassword(password: self.passwordInputContainer.password())
        
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
        
        navigationController?.pushViewController(tabBarController, animated: true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    // MARK: - Private
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func addSubviews() {
        view.addSubview(passwordInputContainer)
        view.addSubview(setPasswordButton)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            passwordInputContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordInputContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            passwordInputContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordInputContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            setPasswordButton.topAnchor.constraint(equalTo: passwordInputContainer.bottomAnchor, constant: 20),
            setPasswordButton.heightAnchor.constraint(equalToConstant: 40),
            setPasswordButton.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 20),
            setPasswordButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -20)
        ])
    }
}
