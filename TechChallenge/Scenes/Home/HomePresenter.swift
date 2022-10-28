//
//  HomePresenter.swift
//  TechChallenge
//
//  Created by Edson Dario Toledo Gonzalez on 27/10/22.
//

import UIKit

protocol HomeViewDelegate: AnyObject {
    var currentUser: User? { get set }
    func display(userImage: UIImage?)
    func display(userName: String)
    func display(userAge: String)
    func display(userGender: String)
    func display(userCity: String)
}

protocol HomePresenterDelegate: AnyObject {
    func showUserDetails(user: User)
    func showAlert(title: String, message: String?)
}

class HomePresenter {
    typealias PresenterDelegate = HomePresenterDelegate & UIViewController
    
    weak var delegate: PresenterDelegate?
    weak var view: HomeViewDelegate?
    
    /// This function is triggered when the HomeViewController triggers the viewDidLoad() function.
    func viewDidLoad() {
        // Clean the UI.
        self.cleanView()
        
        // Make request to the API.
        FetchUserUseCase.shared.fetchUser { [weak self] result in
            switch result {
            case .success(let user):
                // Everything is ok. Refresh the view in the main thread with the user we got.
                DispatchQueue.main.async {
                    self?.refreshView(with: user)
                }
            case .failure(let error):
                // Something went wrong. The API sometimes returns a user with missing information,
                // so if we get an error decoding the data, just bring other user.
                // Otherwise, whatever the error is (bad request or empty response), just show an alert to the user telling him that there was an error with the server.
                switch error {
                case .JSONDecodeError:
                    self?.nextUserButtonPressed()
                default:
                    DispatchQueue.main.async {
                        self?.delegate?.showAlert(title: "Uh-oh!", message: "Sorry, there was a problem trying to get your request. Please come back later!")
                    }
                }
            }
        }
    }
    
    /// This function is triggered when the user taps the "next user" button.
    func nextUserButtonPressed() {
        // The code is very similar to the viewDidLoad() function but slightly different.
        // Disappears the card until we get a new user with an animation.
        let animationDuration: TimeInterval = 0.5
        
        DispatchQueue.main.async { [weak self] in
            UIView.animate(withDuration: animationDuration, delay: 0.0, options: .curveLinear) {
                self?.delegate?.view.subviews.first?.alpha = 0.0
            }
        }
            
        FetchUserUseCase.shared.fetchUser { [weak self] result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self?.refreshView(with: user)
                }
            case .failure(let error):
                switch error {
                case .JSONDecodeError:
                    self?.nextUserButtonPressed()
                default:
                    DispatchQueue.main.async {
                        self?.delegate?.showAlert(title: "Uh-oh!", message: "Sorry, there was a problem trying to get your request. Please come back later!")
                    }
                }
            }
            
            DispatchQueue.main.async { [weak self] in
                UIView.animate(withDuration: animationDuration, delay: 0.0, options: .curveLinear) {
                    self?.delegate?.view.subviews.first?.alpha = 1.0
                }
            }
        }
    }
    
    /// This function is triggered when the user taps the "show user" button.
    func showUserButtonPressed(user: User) {
        delegate?.showUserDetails(user: user)
    }
    
    /// This function is triggered each time we get another user.
    private func refreshView(with user: User) {
        view?.currentUser = user
        view?.display(userName: "\(user.name.first) \(user.name.last)")
        view?.display(userCity: user.location.city)
        view?.display(userAge: "\(user.dob.age) years old")
        view?.display(userGender: user.gender)
        
        UIImage.loadImageAsync(stringURL: user.picture.large) { [weak self] image in
            DispatchQueue.main.async {
                self?.view?.display(userImage: image)
            }
        }
    }
    
    /// This function is triggered when the view loads to clean the UI.
    private func cleanView() {
        view?.display(userName: "")
        view?.display(userCity: "")
        view?.display(userAge: "")
        view?.display(userGender: "")
        view?.display(userImage: nil)
    }
}
