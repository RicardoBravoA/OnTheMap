//
//  LogoutResponse.swift
//  OnTheMap
//
//  Created by Ricardo Bravo on 29/06/21.
//

import Foundation

struct LogoutResponse: Codable {
    let session: LogoutResponseSession
}

struct LogoutResponseSession: Codable {
    let id: String
    let expiration: String
}
