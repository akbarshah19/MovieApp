//
//  ProfileViewController.swift
//  MovieApp
//
//  Created by Akbarshah Jumanazarov on 5/13/23.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        table.backgroundColor = .systemBackground
        table.rowHeight = 50
        return table
    }()

    var models = [ProfileCellSectionModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = .secondarySystemBackground
        tableView.delegate = self
        tableView.dataSource = self
        addSuviews()
        configureModels()
        tableView.tableHeaderView = ProfileTableHeaderView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.width/2))
        let settingsButton = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettings))
        navigationItem.rightBarButtonItem = settingsButton
    }
    
    private func configureModels() {
        models.append(ProfileCellSectionModel(options: [
            ProfileCellModel(label: "Saved Movies", image: UIImage(systemName: "bookmark.fill")!, backgroundColor: .link),
        ]))
        
        models.append(ProfileCellSectionModel(options: [
            ProfileCellModel(label: "Dark Mode", image: UIImage(systemName: "moon.fill")!, backgroundColor: .midnightBlue),
            ProfileCellModel(label: "Settings", image: UIImage(systemName: "gear")!, backgroundColor: .darkGray),
        ]))
        
        models.append(ProfileCellSectionModel(options: [
            ProfileCellModel(label: "Report a Bug", image: UIImage(systemName: "ladybug.fill")!, backgroundColor: .red),
            ProfileCellModel(label: "Contact Us", image: UIImage(systemName: "ellipsis.message.fill")!, backgroundColor: .systemTeal),
            ProfileCellModel(label: "MovieApp FAQ", image: UIImage(systemName: "questionmark.circle.fill")!, backgroundColor: .systemBlue),
            ProfileCellModel(label: "MovieApp Features", image: UIImage(systemName: "lightbulb.fill")!, backgroundColor: .systemYellow),
        ]))
    }
    
    func addSuviews() {
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    @objc private func didTapSettings() {
        let vc = SettingsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier,
                                                 for: indexPath) as! ProfileTableViewCell
        cell.configure(with: model)
        if indexPath.row == 0 && indexPath.section == 1 {
            let switchButton = UISwitch()
            cell.accessoryView = switchButton
            cell.selectionStyle = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
