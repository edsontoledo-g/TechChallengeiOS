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
    
}

class UserDetailPresenter {
    weak var delegate: UserDetailDelegate?
    weak var view: UserDetailView?
    
}
