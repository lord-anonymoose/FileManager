//
//  SettingsViewController.swift
//  FileManager
//
//  Created by Philipp Lazarev on 03.07.2024.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    
    
    
    // MARK: - Subviews
    private lazy var settingsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    /*
    private lazy var sortLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sorting"
        return label
    }()
    */
    
    private lazy var sortToggleButton: UIButton = {
        let button = CustomButton(customTitle: "Sorting", action: {})
        return button
    }()
    
    private lazy var changePasswordButton: UIButton = {
        let button = CustomButton(customTitle: "Change Password", action: {
            if let navController = self.navigationController {
                let coordinator = LoginCoordinator(navigationController: navController)
                coordinator.changePassword()
            }
        })
        return button
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupNavigationBar()
        addSubviews()
        setupConstraints()
    }
    
    
    // MARK: - Actions
    
    
    
    // MARK: - Private
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Settings"
    }
    
    private func addSubviews() {
        view.addSubview(sortToggleButton)
        view.addSubview(changePasswordButton)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            sortToggleButton.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 20),
            sortToggleButton.heightAnchor.constraint(equalToConstant: 40),
            sortToggleButton.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 20),
            sortToggleButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            changePasswordButton.topAnchor.constraint(equalTo: sortToggleButton.bottomAnchor, constant: 20),
            changePasswordButton.heightAnchor.constraint(equalToConstant: 40),
            changePasswordButton.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 20),
            changePasswordButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -20)
        ])
    }
}
