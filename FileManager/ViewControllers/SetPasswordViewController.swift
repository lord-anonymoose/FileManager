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
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        addSubviews()
        setupConstraints()
    }
    
    
    // MARK: - Actions
    @objc func setPasswordButtonTapped(_ button: UIButton) {
        print("setPasswordButtonTapped")
    }
    
    
    // MARK: - Private
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func addSubviews() {
        view.addSubview(passwordInputContainer)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            passwordInputContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordInputContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            passwordInputContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordInputContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
