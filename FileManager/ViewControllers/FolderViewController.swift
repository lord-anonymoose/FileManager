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
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor(named: "AccentColor")
            
        return refreshControl
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
    
    @objc func addDirectoryButtonTapped(_ button: UIButton) {
        let ac = UIAlertController(title: "Enter Directory name", message: nil, preferredStyle: .alert)
        ac.view.tintColor = UIColor(named: "AccentColor")
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned ac] _ in
            if let directoryName = ac.textFields![0].text {
                guard directoryName != "" else {
                    self.showAlert(message: "Directory name can't be empty!")
                    return
                }
                self.directoryService.addDirectory(named: directoryName)
                self.directoryTableView.reloadData()
            } else {
                print("Error!")
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {_ in }
        
        ac.addAction(submitAction)
        ac.addAction(cancelAction)

        
        present(ac, animated: true)
        print("addDirectoryButtonTapped")
    }
    
    @objc func addPhotoButtonTapped(_ button: UIButton) {
        let picker = UIImagePickerController()
        //picker.allowsEditing = true
        picker.delegate = self
        
        present(picker, animated: true)
        //showAlert(message: "Not working yet")
    }
    
    
    // MARK: - Private
    private func setupUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = directoryService.currentDirectoryString()        
        
        let addDirectoryImage = UIImage(systemName: "folder.fill.badge.plus")
        let addDirectoryButton = UIBarButtonItem(image: addDirectoryImage, style: .plain, target: self, action: #selector(addDirectoryButtonTapped))
        
        let addPhotoImage = UIImage(systemName: "photo.badge.plus.fill")
        let addImageButton = UIBarButtonItem(image: addPhotoImage, style: .plain, target: self, action: #selector(addPhotoButtonTapped))
        
        navigationItem.rightBarButtonItems = [addImageButton, addDirectoryButton]
    }
    
    private func addSubviews() {
        view.addSubview(directoryTableView)
        directoryTableView.addSubview(refreshControl)
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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedURL = directoryService.directoryContentURL()[indexPath.row]
        if selectedURL.isDirectory {
            let vc = FolderViewController(url: selectedURL)
            self.navigationController?.pushViewController(vc, animated: true)
            return
        }
        
        if selectedURL.isPicture {
            let vc = PhotoViewController(url: selectedURL)
            self.navigationController?.pushViewController(vc, animated: true)
            return
        }
        
        showAlert(message: "Can't open this file types yet!")
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        directoryService.remove(at: indexPath.row)
        self.directoryTableView.reloadData()
        
    }
    
    private func setupDelegates() {
        directoryTableView.dataSource = self
        directoryTableView.delegate = self
        directoryTableView.register(UITableViewCell.self, forCellReuseIdentifier: "DirectoryTableViewCell")
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.directoryTableView.reloadData()
        refreshControl.endRefreshing()
    }
}



extension FolderViewController {
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.view.tintColor = UIColor(named: "AccentColor")
        self.present(alert, animated: true, completion: nil)
    }
}

extension FolderViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            print("Returned")
            return
        }
        
        let imageName = ("\(UUID().uuidString).jpg")
        let imagePath = directoryService.url.appending(component: imageName)
        
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            try? imageData.write(to: imagePath)
            dismiss(animated: true)
            self.directoryTableView.reloadData()
            return
        }
        showAlert(message: "Couldn't load an image!")
    }
}

