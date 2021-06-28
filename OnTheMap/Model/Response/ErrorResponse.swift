//
//  ErrorResponse.swift
//  OnTheMap
//
//  Created by Ricardo Bravo on 27/06/21.
//

import Foundation

struct ErrorResponse: Codable {
    let status: Int
    let error: String
}
