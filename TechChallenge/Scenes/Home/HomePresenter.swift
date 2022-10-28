//
//  HomePresenter.swift
//  TechChallenge
//
//  Created by Edson Dario Toledo Gonzalez on 27/10/22.
//

import UIKit

protocol HomeViewDelegate: AnyObject {
    var currentUser: User? { get set }
    func display(userImage: UIImage)
    func display(userName: String)
    func display(userAge: String)
    func display(userGender: String)
    func display(userCity: String)
}

protocol HomePresenterDelegate: AnyObject {
    func showUserDetails(user: User)
}

class HomePresenter {
    typealias PresenterDelegate = HomePresenterDelegate & UIViewController
    
    weak var delegate: PresenterDelegate?
    weak var view: HomeViewDelegate?
    
    func viewDidLoad() {
        FetchUserUseCase.shared.fetchUser { [weak self] result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self?.refreshView(with: user)
                }
            case .failure(_):
                self?.nextUserButtonPressed()
            }
        }
    }
    
    func nextUserButtonPressed() {
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.view.subviews.first?.alpha = 0.0
        }
        
        FetchUserUseCase.shared.fetchUser { [weak self] result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self?.refreshView(with: user)
                }
            case .failure(_):
                self?.nextUserButtonPressed()
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.delegate?.view.subviews.first?.alpha = 1.0
            }
        }
    }
    
    func showUserButtonPressed(user: User) {
        delegate?.showUserDetails(user: user)
    }
    
    func refreshView(with user: User) {
        view?.currentUser = user
        view?.display(userName: "\(user.name.first) \(user.name.last)")
        view?.display(userCity: user.location.city)
        view?.display(userAge: "\(user.dob.age) years old")
        view?.display(userGender: user.gender)
        
        DispatchQueue.global().async { [weak self] in
            if let imageURL = URL(string: user.picture.large), let imageData = try? Data(contentsOf: imageURL), let image = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    self?.view?.display(userImage: image)
                }
            }
        }
    }
}
