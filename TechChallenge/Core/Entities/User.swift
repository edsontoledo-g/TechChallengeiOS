//
//  User.swift
//  TechChallenge
//
//  Created by Edson Dario Toledo Gonzalez on 27/10/22.
//

import Foundation

struct User: Decodable {
    struct Name: Decodable {
        var title: String
        var first: String
        var last: String
    }
    
    struct Location: Decodable {
        var street: Street
        var city: String
        var state: String
        var country: String
        var postcode: Int
    }
    
    struct Street: Decodable {
        var number: Int
        var name: String
    }
    
    struct Birth: Decodable {
        var date: String
        var age: Int
    }
    
    struct Picture: Decodable {
        var large: String
        var medium: String
        var thumbnail: String
    }
    
    var gender: String
    var name: Name
    var location: Location
    var dob: Birth
    var phone: String
    var picture: Picture
}
