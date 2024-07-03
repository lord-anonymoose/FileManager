//
//  Extensions.swift
//  FileManager
//
//  Created by Philipp Lazarev on 03.07.2024.
//

import Foundation
import UIKit



class passwordInputView: UIView {
    // MARK: - Subviews
    
    
    
    // MARK: - Lifecycle
    
    
    
    // MARK: - Private
}

extension UIViewController {
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.view.tintColor = UIColor(named: "AccentColor")
        self.present(alert, animated: true, completion: nil)
    }
}
