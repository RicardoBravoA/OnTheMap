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
    case addStudentLocation
    case userProfile(value: String)
    case updateStudentLocation(value: String)
    case logout
    
    var value: String {
        switch self {
            case .login:
                return EndPoint.urlBase + "session"
            case .web:
                return "https://auth.udacity.com/sign-in"
            case .studentLocation:
                return EndPoint.urlBase + "StudentLocation?order=-updatedAt&limit=100"
            case .addStudentLocation:
                return EndPoint.urlBase + "StudentLocation"
            case .userProfile(let value):
                return EndPoint.urlBase + "users/\(value)"
            case .updateStudentLocation(let value):
                return EndPoint.urlBase + "StudentLocation/\(value)"
            case .logout:
                return EndPoint.urlBase + "session"
        }
    }
    
    var url: URL {
        return URL(string: value)!
    }
}
