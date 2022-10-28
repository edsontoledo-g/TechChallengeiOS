//
//  FetchUser.swift
//  TechChallenge
//
//  Created by Edson Dario Toledo Gonzalez on 27/10/22.
//

import Foundation

class FetchUserUseCase {
    static let shared = FetchUserUseCase()
    static let endpoint = "https://randomuser.me/api/"
    
    enum FetchUserUseCaseError: Error {
        case badURL
        case badRequest
        case JSONDecodeError
        case noUserFound
    }
    
    /// This function makes a request to the API and receives a clousure with a result.
    /// If the result is successful, we get an user.
    /// Otherwise, we get a custom error telling us exaclty what was the problem.
    func fetchUser(completion: @escaping (Result<User, FetchUserUseCaseError>) -> Void) {
        guard let url = URL(string: Self.endpoint) else {
            completion(.failure(.badURL))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                return completion(.failure(.badRequest))
            }
            
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(UserResponse.self, from: data) else {
                return completion(.failure(.JSONDecodeError))
                
            }
            
            guard let user = response.results.first else {
                return completion(.failure(.noUserFound))
                
            }
            
            completion(.success(user))
        }.resume()
    }
}

