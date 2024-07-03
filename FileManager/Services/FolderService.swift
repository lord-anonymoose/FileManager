//
//  FolderService.swift
//  FileManager
//
//  Created by Philipp Lazarev on 02.07.2024.
//

import Foundation

/*
protocol DirectoryServiceProtocol {
    func addFile()
    func addFolder()
    func removeFile(at index:Int)
    func removeFolder(at index: Int)
    func contentsOf(url: URL) -> [URL]
}
*/

class DirectoryService {
    
    var url: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    init(url: URL) {
        self.url = url
    }
    
    init() {
        
    }
    
    func currentDirectoryString() -> String {
        return url.lastPathComponent
    }
    
    func currentDirectoryURL() -> URL {
        return URL(fileURLWithPath: "")
    }

    func addFile() {
        print("File added")
    }
    
    func addDirectory(named name: String) {
        //if let path = String(contentsOf: url).appending(name) {
            
        //}
        
        let newUrl = url.appendingPathComponent(name)
        do {
            try FileManager.default.createDirectory(atPath: newUrl.path, withIntermediateDirectories: true)
        } catch {
            print("Error!")
        }
    }
    
    func remove(at index: Int) {
        let url = directoryContentURL()[index]
        do {
            try FileManager.default.removeItem(at: url)
        } catch {
            print("Error removing \(url.lastPathComponent)")
        }
        print("File removed")
    }
    
    func directoryContentURL() -> [URL] {
        do {
            return try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: [])
        } catch {
            return [URL]()
        }
    }
    
    func directoryContentString() -> [String] {
        var result = [String]()
        let contentURL = directoryContentURL()
        
        for url in contentURL {
            result.append(url.lastPathComponent)
        }
        
        return result
    }
}

extension URL {
    var isDirectory: Bool {
       (try? resourceValues(forKeys: [.isDirectoryKey]))?.isDirectory == true
    }
    
    var isPicture: Bool {
        let imageExtensions = ["png", "jpg", "gif"]
        if imageExtensions.contains(self.pathExtension.lowercased()) {
            return true
        } else {
            return false
        }
    }
}
