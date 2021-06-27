//
//  Endpoint.swift
//  OnTheMap
//
//  Created by Ricardo Bravo on 27/06/21.
//

import Foundation

enum EndPoint {
    static let urlBase = "https://onthemap-api.udacity.com/v1/"
    
    case login
    
    var value: String {
        switch self {
        case .login:
            return EndPoint.urlBase + "session"
        }
    
    }
    
    var url: URL {
        return URL(string: value)!
    }
}
