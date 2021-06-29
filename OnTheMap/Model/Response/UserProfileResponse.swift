//
//  UserProfileResponse.swift
//  OnTheMap
//
//  Created by Ricardo Bravo on 29/06/21.
//

import Foundation

struct UserProfileResponse: Codable {
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
