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
        let image = UIImage(systemName: "lock.fill")
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
        //let button = UIButton()
        let button = CustomButton(customTitle: "Log In", action: {})
        //button.backgroundColor = .green
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
        
        guard let password = passwordTextField.text else {
            showAlert(message: "Couldn't get password from TextField!")
            return
        }
        
        let loginService = LoginService()
        
        guard loginService.passwordIsCorrect(password: password) else {
            showAlert(message: "Incorrect password!")
            return
        }
        
        guard let navController = navigationController else {
            showAlert(message: "Couldn't load UINavigationController!")
            return
        }
        
        UIView.transition(with: emojiView,
                          duration: 1.5,
                          options: .curveEaseInOut,
                          animations: { self.emojiView.image = UIImage(systemName: "lock.open.fill") },
                          completion: {_ in
            let loginCoordinator = LoginCoordinator(navigationController: navController)
            loginCoordinator.start()
        })
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
            emojiView.centerYAnchor.constraint(equalTo: safeAreaGuide.centerYAnchor, constant: -200),
            emojiView.heightAnchor.constraint(equalToConstant: 200),
            emojiView.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emojiView.bottomAnchor, constant: 150),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        /*
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: emojiView.bottomAnchor, constant: 25),
            passwordTextField.heightAnchor.constraint(equalToConstant: 30),
            passwordTextField.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 25),
            passwordTextField.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -25)
        ])
        */
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            loginButton.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -20)
        ])
    }
}


