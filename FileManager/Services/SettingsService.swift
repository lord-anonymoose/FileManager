//
//  SettingsService.swift
//  FileManager
//
//  Created by Philipp Lazarev on 03.07.2024.
//

import Foundation

class SettingsService {
    func setAscendingSort() {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "AscendingSort")

    }
    
    func setDescendingSort() {
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: "AscendingSort")

    }
    
    func isAscendingSort() -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: "AscendingSort")
    }
}
