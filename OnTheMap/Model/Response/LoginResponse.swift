//
//  LoginResponse.swift
//  OnTheMap
//
//  Created by Ricardo Bravo on 27/06/21.
//

import Foundation

struct LoginResponse: Codable {
    let account: AccountResponse
    let session: SessionResponse
}
