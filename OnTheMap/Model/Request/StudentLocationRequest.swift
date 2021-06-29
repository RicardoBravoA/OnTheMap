//
//  StudentLocationRequest.swift
//  OnTheMap
//
//  Created by Ricardo Bravo on 29/06/21.
//

import Foundation

struct StudentLocationRequest: Codable {
    let uniqueKey: String
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaURL: String
    let latitude: Float
    let longitude: Float
}
