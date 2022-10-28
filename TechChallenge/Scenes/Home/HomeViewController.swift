//
//  HomeViewController.swift
//  TechChallenge
//
//  Created by Edson Dario Toledo Gonzalez on 28/10/22.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet var userImageView: UIImageView!
    
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var userAgeLabel: UILabel!
    @IBOutlet var userGenderLabel: UILabel!
    @IBOutlet var userCityLabel: UILabel!
    
    private let presenter = HomePresenter()
    
    var currentUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.delegate = self
        presenter.view = self
        presenter.viewDidLoad()
    }

    @IBAction func didPressNextUserButton(_ sender: UIButton) {
        presenter.nextUserButtonPressed()
    }
    
    @IBAction func didPressShowUserButton(_ sender: UIButton) {
        guard let user = currentUser else {
            return
        }
        
        presenter.showUserButtonPressed(user: user)
    }
}

// MARK: - HomePresenterDelegate
extension HomeViewController: HomePresenterDelegate {
    func showUserDetails(user: User) {
        guard let vc = storyboard?.instantiateViewController(identifier: UserDetailViewController.storyboardIdentifier) as? UserDetailViewController else {
            return
        }
        
        vc.configure(with: user)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showAlert(title: String, message: String?) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        
        present(ac, animated: true)
    }
}

// MARK: - HomeViewDelegate
extension HomeViewController: HomeViewDelegate {
    func display(userImage: UIImage?) {
        userImageView.image = userImage
    }

    func display(userName: String) {
        userNameLabel.text = userName
    }
    
    func display(userAge: String) {
        userAgeLabel.text = userAge
    }
    
    func display(userGender: String) {
        userGenderLabel.text = userGender
    }
    
    func display(userCity: String) {
        userCityLabel.text = userCity
    }
}
