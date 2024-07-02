//
//  ViewController.swift
//  FileManager
//
//  Created by Philipp Lazarev on 02.07.2024.
//

import UIKit

class FolderViewController: UIViewController {
            
    var directoryService = DirectoryService()
    
    // MARK: - Subviews
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var directoryTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupNavigationBar()
        addSubviews()
        setupConstraints()
        setupDelegates()
    }
    
    
    init(url: URL) {
        self.directoryService = DirectoryService(url: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Actions
    
    @objc func addDirectoryButtonTapped(_ textField: UITextField) {
        print("addDirectoryButtonTapped")
    }
    
    @objc func addPhotoButtonTapped(_ textField: UITextField) {
        print("addPhotoButtonTapped")
    }
    
    
    // MARK: - Private
    private func setupUI() {
        view.backgroundColor = .systemBackground
        //print(directoryService.directoryContentString())
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = directoryService.currentDirectory()
        print(directoryService.url)
        
        let addDirectoryImage = UIImage(systemName: "folder.fill.badge.plus")
        let addDirectoryButton = UIBarButtonItem(image: addDirectoryImage, style: .plain, target: self, action: #selector(addDirectoryButtonTapped))
        
        let addPhotoImage = UIImage(systemName: "photo.badge.plus.fill")
        let addImageButton = UIBarButtonItem(image: addPhotoImage, style: .plain, target: self, action: #selector(addPhotoButtonTapped))
        
        navigationItem.rightBarButtonItems = [addImageButton, addDirectoryButton]


    }
    
    private func addSubviews() {
        view.addSubview(directoryTableView)
    }

    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            directoryTableView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            directoryTableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            directoryTableView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            directoryTableView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor)
        ])
    }
}



extension FolderViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return directoryService.directoryContentURL().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ComponentViewCell(style: .default, reuseIdentifier: "cell", url: directoryService.directoryContentURL()[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    private func setupDelegates() {
        directoryTableView.dataSource = self
        directoryTableView.delegate = self
        directoryTableView.register(UITableViewCell.self, forCellReuseIdentifier: "DirectoryTableViewCell")
    }
}

