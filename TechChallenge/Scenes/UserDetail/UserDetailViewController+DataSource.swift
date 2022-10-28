//
//  UserDetailViewController+DataSource.swift
//  TechChallenge2
//
//  Created by Edson Dario Toledo Gonzalez on 28/10/22.
//

import UIKit

extension UserDetailViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, itemIdentifier: String) {
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = itemIdentifier
        
        cell.contentConfiguration = contentConfiguration
    }
}
