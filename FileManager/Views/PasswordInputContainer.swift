//
//  TwoPasswordTextField.swift
//  FileManager
//
//  Created by Philipp Lazarev on 03.07.2024.
//

import Foundation
import UIKit

final class PasswordInputContainer: UIView {
    
    
    
    // MARK: - Subviews
    
    private lazy var firstPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var showFirstPasswordButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showFirstPasswordButtonTapped), for: .touchUpInside)
        button.tintColor = .systemGray
        
        return button
    }()
    
    private lazy var secondPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Repeat password"
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var showSecondPasswordButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showSecondPasswordButtonTapped), for: .touchUpInside)
        button.tintColor = .systemGray
        
        return button
    }()
    
    private lazy var dividingLine: UIView = {
        let line = UIView()
        line.backgroundColor = .lightGray
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    // MARK: - Lifecycle
    required init() {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemGray6
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 10.0
        layer.masksToBounds = true
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Actions
    @objc func showFirstPasswordButtonTapped(_ button: UIButton) {
        if firstPasswordTextField.isSecureTextEntry {
            showFirstPasswordButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        } else {
            showFirstPasswordButton.setImage(UIImage(systemName: "eye"), for: .normal)
        }
        firstPasswordTextField.isSecureTextEntry.toggle()
    }
    
    @objc func showSecondPasswordButtonTapped(_ button: UIButton) {
        if secondPasswordTextField.isSecureTextEntry {
            showSecondPasswordButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        } else {
            showSecondPasswordButton.setImage(UIImage(systemName: "eye"), for: .normal)
        }
        secondPasswordTextField.isSecureTextEntry.toggle()
    }
    
    
    
    // MARK: - Private
    
    private func addSubviews() {
        addSubview(firstPasswordTextField)
        addSubview(showFirstPasswordButton)
        addSubview(secondPasswordTextField)
        addSubview(showSecondPasswordButton)
        addSubview(dividingLine)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            firstPasswordTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            firstPasswordTextField.heightAnchor.constraint(equalToConstant: 40),
            firstPasswordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            firstPasswordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            showFirstPasswordButton.topAnchor.constraint(equalTo: firstPasswordTextField.topAnchor, constant: 10),
            showFirstPasswordButton.bottomAnchor.constraint(equalTo: firstPasswordTextField.bottomAnchor, constant: -10),
            showFirstPasswordButton.trailingAnchor.constraint(equalTo: firstPasswordTextField.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            dividingLine.topAnchor.constraint(equalTo: firstPasswordTextField.bottomAnchor),
            dividingLine.heightAnchor.constraint(equalToConstant: 0.5),
            dividingLine.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            dividingLine.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            secondPasswordTextField.topAnchor.constraint(equalTo: firstPasswordTextField.bottomAnchor, constant: 10),
            secondPasswordTextField.heightAnchor.constraint(equalToConstant: 40),
            secondPasswordTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            secondPasswordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            secondPasswordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            showSecondPasswordButton.topAnchor.constraint(equalTo: secondPasswordTextField.topAnchor, constant: 10),
            showSecondPasswordButton.bottomAnchor.constraint(equalTo: secondPasswordTextField.bottomAnchor, constant: -10),
            showSecondPasswordButton.trailingAnchor.constraint(equalTo: firstPasswordTextField.trailingAnchor, constant: -10)
        ])

        

    }
    
}
