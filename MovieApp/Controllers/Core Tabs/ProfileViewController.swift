//
//  ProfileViewController.swift
//  MovieApp
//
//  Created by Akbarshah Jumanazarov on 5/13/23.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        
        let settingsButton = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettings))
        navigationItem.rightBarButtonItem = settingsButton
    }
    
    @objc private func didTapSettings() {
        let vc = SettingsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
