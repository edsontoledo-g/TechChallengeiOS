//
//  UserDetailViewController.swift
//  TechChallenge
//
//  Created by Edson Dario Toledo Gonzalez on 27/10/22.
//

import UIKit

class UserDetailViewController: UICollectionViewController {
    static let storyboardIdentifier = "UserDetailViewController"
    
    private let presenter = UserDetailPresenter()
    
    var user: User?
    var dataSource: DataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Details"
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "phone"), style: .plain, target: self, action: #selector(didPressContactUserButton))
        
        collectionView.collectionViewLayout = listLayout()
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        createSnapshot()
        
        presenter.delegate = self
        presenter.view = self
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    private func listLayout() -> UICollectionViewCompositionalLayout {
        let listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
    
    private func createSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        
        guard let user = user else {
            return
        }
        
        // Just showing some fields of the response arbitrarily.
        snapshot.appendItems([
            "\(user.name.first) \(user.name.last)",
            " \(user.location.country) \(user.location.city)",
            "\(user.dob.age) years old",
            user.gender,
            user.phone
        ])
        
        dataSource.apply(snapshot)
    }
    
    func configure(with user: User) {
        self.user = user
    }
    
    @objc
    func didPressContactUserButton() {
        presenter.contactUserButtonPressed(user: user)
    }
}

// MARK: - UserDetailDelegate
extension UserDetailViewController: UserDetailDelegate {
    func showUserContactView(user: User) {
        guard let vc = storyboard?.instantiateViewController(identifier: ContactUserViewController.storyboardIdentifier) as? ContactUserViewController else {
            return
        }
        
        vc.configure(with: user)
        if let sheet = vc.sheetPresentationController {
                sheet.detents = [.large()]
        }
        
        present(vc, animated: true, completion: nil)
    }
}

// MARK: - UserDetailView
extension UserDetailViewController: UserDetailView {
    
}

