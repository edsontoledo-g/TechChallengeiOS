//
//  UserDetailViewController.swift
//  TechChallenge
//
//  Created by Edson Dario Toledo Gonzalez on 27/10/22.
//

import UIKit

class UserDetailViewController: UICollectionViewController {
    private let presenter = UserDetailPresenter()
    
    var user: User?
    var dataSource: DataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Details"
        navigationItem.largeTitleDisplayMode = .never
        
        collectionView.collectionViewLayout = listLayout()
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        createSnapshot()
        
        presenter.delegate = self
        presenter.view = self
    }
    
    func listLayout() -> UICollectionViewCompositionalLayout {
        let listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
    
    func createSnapshot() {
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
}

extension UserDetailViewController: UserDetailDelegate {
    
}

extension UserDetailViewController: UserDetailView {
    
}


