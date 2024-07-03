//
//  LogInViewControlller.swift
//  FileManager
//
//  Created by Philipp Lazarev on 03.07.2024.
//

import Foundation
import UIKit



class LogInViewControlller: UIViewController {
    
    
    
    // MARK: - Subviews
    private lazy var emojiView: UIImageView = {
        let image = UIImage(systemName: "key.fill")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var passwordTextField: UITextFieldWithPadding = {
        let textField = UITextFieldWithPadding()
        textField.setupUI(placeholder: "Password", isSecure: true)
        textField.translatesAutoresizingMaskIntoConstraints = false
        //textField.backgroundColor = .black
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        button.setTitle("Log In", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
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
    @objc func loginButtonTapped(_ button: UIButton) {
        let loginSerivce = LoginService()
        if loginSerivce.passwordIsCorrect(password: "") {
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
            
        } else {
            showAlert(message: "Incorrect password!")
        }
    }
    
    
    // MARK: - Private
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func addSubviews() {
        view.addSubview(emojiView)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            emojiView.centerYAnchor.constraint(equalTo: safeAreaGuide.centerYAnchor, constant: -30),
            emojiView.heightAnchor.constraint(equalToConstant: 200),
            emojiView.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: emojiView.bottomAnchor, constant: 25),
            passwordTextField.heightAnchor.constraint(equalToConstant: 30),
            passwordTextField.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 25),
            passwordTextField.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -25)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 25),
            loginButton.heightAnchor.constraint(equalToConstant: 30),
            loginButton.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 25),
            loginButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -25)
        ])
    }
}


