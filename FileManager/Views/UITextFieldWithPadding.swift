//
//  UITextFieldWithPadding.swift
//  FileManager
//
//  Created by Philipp Lazarev on 03.07.2024.
//

import Foundation
import UIKit

class UITextFieldWithPadding: UITextField {
    
    // MARK: - Subviews
    
    var textPadding = UIEdgeInsets(
        top: 0,
        left: 10,
        bottom: 0,
        right: 0
    )
    
    // MARK: - Lifecycle
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.placeholder = "Placeholder"
        self.textColor = textColor
        self.font = .systemFont(ofSize: 16)
        //self.tintColor = accentColor
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.masksToBounds = true
        //textField.keyboardType = .emailAddress
        
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        print("Instantiated")
    }
    
    func setupUI(placeholder: String, isSecure: Bool) {
        
        self.placeholder = placeholder
        self.textColor = textColor
        self.font = .systemFont(ofSize: 16)
        self.tintColor = UIColor(named: "AccentColor")
        
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.masksToBounds = true
        
        if isSecure {
            self.isSecureTextEntry = true
        } else {
            self.isSecureTextEntry = false
        }
        
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
    }
    
    func toggleIsSecure() {
        self.isSecureTextEntry.toggle()
    }
}
