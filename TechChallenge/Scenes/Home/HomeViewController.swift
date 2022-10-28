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
        
        clearUIData()
        
        presenter.delegate = self
        presenter.view = self
        presenter.viewDidLoad()
    }

    @IBAction func didPressNextButton(_ sender: UIButton) {
        presenter.nextUserButtonPressed()
    }
    
    @IBAction func didPressShowUserButton(_ sender: UIButton) {
        
    }
    
    private func clearUIData() {
        userNameLabel.text = ""
        userAgeLabel.text = ""
        userGenderLabel.text = ""
        userCityLabel.text = ""
    }
}

// MARK: - HomePresenterDelegate
extension HomeViewController: HomePresenterDelegate {
    func showUserDetails(user: User) {
        // More code to come.
        // Present the DetailViewController.
    }
}

// MARK: - HomeViewDelegate
extension HomeViewController: HomeViewDelegate {
    func display(userImage: UIImage) {
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
