//
//  ComponentViewCell.swift
//  FileManager
//
//  Created by Philipp Lazarev on 02.07.2024.
//

import Foundation
import UIKit

class ComponentViewCell: UITableViewCell {
    
    var directoryService = DirectoryService()
    
    
    //MARK: - Subviews
    
    private lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "doc.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var labelView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // MARK: - Lifecycle
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, url: URL) {
        self.directoryService = DirectoryService(url: url)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        addSubviews()
        setupConstraints()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        addSubviews()
        setupConstraints()
    }
    
    
    
    // MARK: - Private
    private func setupUI() {
        self.labelView.text = self.directoryService.url.lastPathComponent
        
        if self.directoryService.url.isDirectory {
            iconView.image = UIImage(systemName: "folder.fill")
        } 
        
        if self.directoryService.url.isPicture {
            iconView.image = UIImage(systemName: "photo.fill")
        }
    }
    
    
    private func addSubviews() {
        addSubview(iconView)
        addSubview(labelView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            iconView.heightAnchor.constraint(equalToConstant: 32),
            iconView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            iconView.widthAnchor.constraint(equalToConstant: 32)
        ])
        
        NSLayoutConstraint.activate([
            labelView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            labelView.heightAnchor.constraint(equalToConstant: 32),
            labelView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            labelView.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 16),
            labelView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
}
