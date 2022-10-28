//
//  UIImage+LoadImageAsync.swift
//  TechChallenge
//
//  Created by Edson Dario Toledo Gonzalez on 28/10/22.
//

import UIKit

extension UIImage {
    static func loadImageAsync(stringURL: String, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            if let imageURL = URL(string: stringURL), let imageData = try? Data(contentsOf: imageURL), let image = UIImage(data: imageData) {
                completion(image)
                return
            }
            
            completion(nil)
        }
    }
}
