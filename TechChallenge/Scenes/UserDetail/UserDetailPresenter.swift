//
//  UserDetailPresenter.swift
//  TechChallenge2
//
//  Created by Edson Dario Toledo Gonzalez on 28/10/22.
//

import Foundation

protocol UserDetailView: AnyObject {
    var user: User? { get set }
}

protocol UserDetailDelegate: AnyObject {
    func showUserContactView(user: User)
}

class UserDetailPresenter {
    weak var delegate: UserDetailDelegate?
    weak var view: UserDetailView?
    
    /// This function is triggered when the user taps the "contact" button of any user.
    func contactUserButtonPressed(user: User?) {
        // Business logic to call a person. We can create another use case to this specific task.
        // For purpose of this challenge, we are just going to show a dummy view.
        guard let user = user else {
            return
        }
        
        self.delegate?.showUserContactView(user: user)
    }
}
