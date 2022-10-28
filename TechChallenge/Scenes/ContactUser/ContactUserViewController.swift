//
//  ContactUserViewController.swift
//  TechChallenge
//
//  Created by Edson Dario Toledo Gonzalez on 28/10/22.
//

import UIKit

class ContactUserViewController: UIViewController {
    static let storyboardIdentifier: String = "ContactUserViewController"
    
    @IBOutlet var userImageView: UIImageView!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func configure(with user: User) {
        self.user = user
        
        UIImage.loadImageAsync(stringURL: user.picture.large) { [weak self] image in
            DispatchQueue.main.async {
                self?.userImageView.image = image
            }
        }
    }
}
