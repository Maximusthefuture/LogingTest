//
//  NetworkWorkingLogic.swift
//  LoginTestingApp
//
//  Created by Maximus on 12.02.2022.
//

import Foundation

protocol NetworkWorkingLogic {
    func sendRequest(to: URL, params: [String: String], completion: @escaping (Data?, Error?) -> Void)
    func postData(url: URL, params: [String: String],  completion: @escaping (Data?, Error?) -> Void)
}

class NetworkWorker: NetworkWorkingLogic {
    private let session = URLSession.shared

    func postData(url: URL, params: [String: String],  completion: @escaping (Data?, Error?) -> Void) {

        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = params.percentEncoded()
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(nil, error)
            }
            
            print("response", (response as! HTTPURLResponse).statusCode)
            completion(data, nil)
        }.resume()
        
    }
    
    func sendRequest(to: URL, params: [String : String], completion: @escaping (Data?, Error?) -> Void) {

        guard var urlComponents = URLComponents(url: to, resolvingAgainstBaseURL: false) else {
          completion(nil, nil)
          return
        }

        urlComponents.queryItems = params.map {
          URLQueryItem(name: $0.key, value: $0.value)
        }

        guard let requestURL = urlComponents.url else {
          completion(nil, nil)
          return
        }
        
        let request = session.dataTask(with: requestURL) { data, responce, error in
          
            if let error = error {
              completion(nil, error)
                print(error)
              return
            }
            print((responce as? HTTPURLResponse)?.statusCode)

            completion(data, nil)
        }
        request.resume()
    }
}


extension Dictionary {
    func percentEncoded() -> Data? {
    
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

