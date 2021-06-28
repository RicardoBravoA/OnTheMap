//
//  StudentLocationItemResponse.swift
//  OnTheMap
//
//  Created by Ricardo Bravo on 27/06/21.
//

import Foundation

struct StudentLocationItemResponse: Codable {
    let firstName: String
    let lastName: String
    let latitude: Float
    let longitude: Float
    let mapString: String
    let mediaURL: String
    let uniqueKey: String
    let objectId: String
    let createdAt: String
    let updatedAt: String
}
