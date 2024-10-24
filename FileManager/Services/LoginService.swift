//
//  LoginService.swift
//  FileManager
//
//  Created by Philipp Lazarev on 03.07.2024.
//

import Foundation

class LoginService {
    func passwordExists() -> Bool {
       KeychainWrapper.standard.string(forKey: "FileManagerPassword") != nil
    }
    
    func passwordIsCorrect(password: String) -> Bool {
        if let text = KeychainWrapper.standard.string(forKey: "FileManagerPassword") {
            if password == text {
                return true
            }
        }
        return false
    }
    
    func setPassword(password: String) {
        KeychainWrapper.standard.set(password, forKey: "FileManagerPassword")
    }
}
