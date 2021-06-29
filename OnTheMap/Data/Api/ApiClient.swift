//
//  ApiClient.swift
//  OnTheMap
//
//  Created by Ricardo Bravo on 27/06/21.
//

import Foundation

class ApiClient {
    
    class func login(user: String, pwd: String, completion: @escaping (Bool, Error?) -> Void) {
        let loginRequest = LoginRequest(udacity: LoginRequestItem(username: user, password: pwd))
        
        taskForPOSTRequest(url: EndPoint.login.url, body: loginRequest, response: LoginResponse.self, resize: true) { response, error in
            if let response = response {
                Auth.uniqueKey = response.account.key
                userProfile { success, error in
                    completion(success, error)
                }
            } else {
                completion(false, error)
            }
        }
    }
    
    class func userProfile(completion: @escaping (Bool, Error?) -> Void) {
        taskForGETRequest(url: EndPoint.userProfile(value: Auth.uniqueKey).url, response: UserProfileResponse.self, resize: true) { response, error in
            if let response = response {
                Auth.firstName = response.firstName
                Auth.lastName = response.lastName
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    class func studentLocation(completion: @escaping ([StudentLocationItemResponse], Error?) -> Void) {
        taskForGETRequest(url: EndPoint.studentLocation.url, response: StudentLocationResponse.self, resize: false) { response, error in
            if let response = response {
                completion(response.results, nil)
            } else {
                completion([], error)
            }
        }
    }
    
    class func addStudentLocation(studentLocation: StudentLocationRequest, completion: @escaping (Bool, Error?) -> Void) {
        taskForPOSTRequest(url: EndPoint.addStudentLocation.url, body: studentLocation, response: AddStudentLocationResponse.self, resize: false) { response, error in
            if let response = response {
                Auth.objectId = response.objectId
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    class func updateStudentLocation(studentLocation: StudentLocationRequest, completion: @escaping (Bool, Error?) -> Void) {
        taskForPUTRequest(url: EndPoint.updateStudentLocation(value: Auth.objectId).url, body: studentLocation, response: UpdateStudentLocationResponse.self) { response, error in
            if response != nil {
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    class func logout(completion: @escaping (Bool, Error?) -> Void) {
        taskForDELETERequest(url: EndPoint.logout.url, response: LogoutResponse.self, resize: true) { response, error in
            if response != nil {
                completion(true, nil)
                Auth.clear()
            } else {
                completion(false, error)
            }
        }
    }
    
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, response: ResponseType.Type, resize: Bool, completion: @escaping (ResponseType?, Error?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let newData = resizeData(data: data, resize: resize)
                let response = try decoder.decode(ResponseType.self, from: newData)
                DispatchQueue.main.async {
                    completion(response, nil)
                }
            } catch {
                do {
                    let newData = resizeData(data: data, resize: resize)
                    let errorResponse = try decoder.decode(ErrorResponse.self, from: newData)
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
    }
    
    class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, body: RequestType, response: ResponseType.Type, resize: Bool, completion: @escaping (ResponseType?, Error?) -> Void) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        urlRequest.httpBody = try! JSONEncoder().encode(body)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let newData = resizeData(data: data, resize: resize)
                let response = try decoder.decode(ResponseType.self, from: newData)
                DispatchQueue.main.async {
                    completion(response, nil)
                }
            } catch {
                do {
                    let newData = resizeData(data: data, resize: resize)
                    let errorResponse = try decoder.decode(ErrorResponse.self, from: newData)
                    DispatchQueue.main.async {
                        completion(nil, errorResponse as Error)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
    }
    
    class func taskForPUTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, body: RequestType, response: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        urlRequest.httpBody = try! JSONEncoder().encode(body)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(response, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(ErrorResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(nil, errorResponse as Error)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
    }
    
    class func taskForDELETERequest<ResponseType: Decodable>(url: URL, response: ResponseType.Type, resize: Bool, completion: @escaping (ResponseType?, Error?) -> Void) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let newData = resizeData(data: data, resize: resize)
                let response = try decoder.decode(ResponseType.self, from: newData)
                DispatchQueue.main.async {
                    completion(response, nil)
                }
            } catch {
                do {
                    let newData = resizeData(data: data, resize: resize)
                    let errorResponse = try decoder.decode(ErrorResponse.self, from: newData)
                    DispatchQueue.main.async {
                        completion(nil, errorResponse as Error)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
    }
    
    private class func resizeData(data: Data, resize: Bool) -> Data {
        var newData: Data
        if resize {
            newData = data.subdata(in: 5..<data.count)
        } else {
             newData = data
        }
        return newData
    }
    
}
