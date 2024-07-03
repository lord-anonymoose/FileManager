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
        
        passwordInputContainer.firstPasswordTextField.delegate = self
        passwordInputContainer.secondPasswordTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeKeyboardObservers()
    }
    
    
    
    // MARK: - Actions
    @objc func setPasswordButtonTapped(_ button: UIButton) {
        guard passwordInputContainer.passwordsMatch() else {
            showAlert(message: "Passwords do not match!")
            return
        }
        
        guard passwordInputContainer.passwordLengthMatch() else {
            showAlert(message: "Password should contain at least 4 characters")
            return
        }
        
        guard let navController = navigationController else {
            showAlert(message: "Couldn't load UINavigationController!")
            return
        }
                
        UIView.transition(with: emojiView,
                          duration: 1.0,
                          options: .curveEaseInOut,
                          animations: { self.emojiView.image = UIImage(systemName: "checkmark.seal.fill") },
                          completion: {_ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                let loginService = LoginService()
                guard loginService.passwordExists() else {
                    let loginCoordinator = LoginCoordinator(navigationController: navController)
                    loginCoordinator.start()
                    return
                }
            }
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
        contentView.addSubview(passwordInputContainer)
        contentView.addSubview(setPasswordButton)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            emojiView.centerYAnchor.constraint(equalTo: safeAreaGuide.centerYAnchor, constant: -200),
            emojiView.heightAnchor.constraint(equalToConstant: 200),
            emojiView.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            passwordInputContainer.topAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 150),
            passwordInputContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            passwordInputContainer.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            passwordInputContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])

        NSLayoutConstraint.activate([
            setPasswordButton.topAnchor.constraint(equalTo: passwordInputContainer.bottomAnchor, constant: 20),
            setPasswordButton.heightAnchor.constraint(equalToConstant: 40),
            setPasswordButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            setPasswordButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            setPasswordButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
}



extension SetPasswordViewController: UITextFieldDelegate {
    
    
    
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
