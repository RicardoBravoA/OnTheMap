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
    case web
    case studentLocation
    
    var value: String {
        switch self {
            case .login:
                return EndPoint.urlBase + "session"
            case .web:
                return "https://auth.udacity.com/sign-in"
            case .studentLocation:
                return EndPoint.urlBase + "StudentLocation?order=-updatedAt"
        }
    }
    
    var url: URL {
        return URL(string: value)!
    }
}
