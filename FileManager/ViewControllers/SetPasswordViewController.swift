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
        let image = UIImage(systemName: "key.fill")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var passwordInputContainer: PasswordInputContainer = {
        let container = PasswordInputContainer()
        return container
    }()
    
    private lazy var setPasswordButton: UIButton = {
        let button = CustomButton(customTitle: "Set Password", action: {})
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
        
        if let navController = navigationController {
            let loginCoordinator = LoginCoordinator(navigationController: navController)
            loginCoordinator.start()
        }
    }
    
    
    // MARK: - Private
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func addSubviews() {
        view.addSubview(emojiView)
        view.addSubview(passwordInputContainer)
        view.addSubview(setPasswordButton)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            emojiView.centerYAnchor.constraint(equalTo: safeAreaGuide.centerYAnchor, constant: -200),
            emojiView.heightAnchor.constraint(equalToConstant: 200),
            emojiView.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            passwordInputContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordInputContainer.topAnchor.constraint(equalTo: emojiView.bottomAnchor, constant: 150),
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
