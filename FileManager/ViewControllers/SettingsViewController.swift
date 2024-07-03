//
//  SettingsViewController.swift
//  FileManager
//
//  Created by Philipp Lazarev on 03.07.2024.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    
    var settingsService = SettingsService()
    
    // MARK: - Subviews
    private lazy var settingsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var sortingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sorting:"
        return label
    }()

    private lazy var ascendingSortButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        if settingsService.isAscendingSort() {
            button.backgroundColor = UIColor(named: "AccentColor")
        } else {
            button.backgroundColor = .systemBackground
        }
        button.layer.cornerRadius = 10.0
        button.setImage(UIImage(systemName: "arrow.up.right"), for: .normal)
        button.tintColor = UIColor(named: "TextColor")
        button.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        button.layer.borderWidth = 1.0

        
        button.addTarget(self, action: #selector(ascendingButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var descendingSortButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        if !settingsService.isAscendingSort() {
            button.backgroundColor = UIColor(named: "AccentColor")
        } else {
            button.backgroundColor = .systemBackground
        }
        button.layer.cornerRadius = 10.0
        button.setImage(UIImage(systemName: "arrow.down.right"), for: .normal)
        button.tintColor = UIColor(named: "TextColor")
        button.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        button.layer.borderWidth = 1.0
        
        button.addTarget(self, action: #selector(descendingButtonTapped), for: .touchUpInside)
        return button
    }()
    
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
    @objc func ascendingButtonTapped(_ button: UIButton) {
        settingsService.setAscendingSort()
        self.ascendingSortButton.backgroundColor = UIColor(named: "AccentColor")
        self.descendingSortButton.backgroundColor = .systemBackground

    }
    
    @objc func descendingButtonTapped(_ button: UIButton) {
        settingsService.setDescendingSort()
        self.descendingSortButton.backgroundColor = UIColor(named: "AccentColor")
        self.ascendingSortButton.backgroundColor = .systemBackground
    }
    
    
    // MARK: - Private
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Settings"
    }
    
    private func addSubviews() {
        view.addSubview(sortingLabel)
        view.addSubview(ascendingSortButton)
        view.addSubview(descendingSortButton)
        view.addSubview(changePasswordButton)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            sortingLabel.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 20),
            sortingLabel.heightAnchor.constraint(equalToConstant: 40),
            sortingLabel.trailingAnchor.constraint(equalTo: descendingSortButton.leadingAnchor, constant: -20),
            sortingLabel.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            ascendingSortButton.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 20),
            ascendingSortButton.heightAnchor.constraint(equalToConstant: 40),
            ascendingSortButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -20),
            ascendingSortButton.widthAnchor.constraint(equalToConstant: 40)
        ])

        NSLayoutConstraint.activate([
            descendingSortButton.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 20),
            descendingSortButton.heightAnchor.constraint(equalToConstant: 40),
            descendingSortButton.trailingAnchor.constraint(equalTo: ascendingSortButton.leadingAnchor, constant: -20),
            descendingSortButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            changePasswordButton.topAnchor.constraint(equalTo: ascendingSortButton.bottomAnchor, constant: 20),
            changePasswordButton.heightAnchor.constraint(equalToConstant: 40),
            changePasswordButton.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 20),
            changePasswordButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -20)
        ])
    }
}
