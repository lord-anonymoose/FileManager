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
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.isUserInteractionEnabled = true
        return contentView
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

        passwordTextField.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeKeyboardObservers()
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
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(loginButton)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            emojiView.centerYAnchor.constraint(equalTo: safeAreaGuide.centerYAnchor, constant: -200),
            emojiView.heightAnchor.constraint(equalToConstant: 200),
            emojiView.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            scrollView.widthAnchor.constraint(equalTo: safeAreaGuide.widthAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: scrollView.centerYAnchor, constant: 20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            loginButton.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -20),
        ])
    }
}



extension LogInViewControlller: UITextFieldDelegate {
    
    
    
    // MARK: - Actions
    @objc func willShowKeyboard(_ notification: NSNotification) {
        let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
        scrollView.contentInset.bottom = 0.0
        scrollView.contentInset.bottom += keyboardHeight ?? 0.0
    }
    
    @objc func willHideKeyboard(_ notification: NSNotification) {
        scrollView.contentInset.bottom = 0.0
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    // MARK: - Private
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // This dismisses the keyboard
        return true
    }
    
    private func setupKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willShowKeyboard(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willHideKeyboard(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func removeKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
}
