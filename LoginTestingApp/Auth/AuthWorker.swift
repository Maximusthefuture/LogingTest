//
//  AuthWorker.swift
//  LoginTestingApp
//
//  Created by Maximus on 12.02.2022.
//

import Foundation


protocol AuthWorkerLogic {
    func getPhoneMask(completion: @escaping (PhoneMask?) -> Void)
    func singInUser(phone: String, password: String, completion: @escaping (LoginValidation?) -> Void)
}

class AuthWorker: AuthWorkerLogic {
    
    private let authUrl = URL(string: Query.auth.rawValue)
    
    func singInUser(phone: String, password: String, completion: @escaping (LoginValidation?) -> Void) {
        guard let authUrl = authUrl else { return }
        let params = ["phone": phone, "password": password]
        networkWorker.postData(url: authUrl, params: params, completion: { data, error in
            guard let data = data else {
                return
            }
            let decoder = JSONDecoder()
            let success = try? decoder.decode(LoginValidation.self, from: data)
           completion(success)
        })
//        var isBool = false
//        if phone == "111" {
//            isBool = true
//        } else {
//            isBool = false
//        }
//        let mock = LoginValidation(success: isBool)
//        completion(mock)
    }
    
    private let networkWorker: NetworkWorkingLogic = NetworkWorker()
    private let phoneMaskUrl = URL(string: Query.phoneMask.rawValue)
    
    
    func getPhoneMask(completion: @escaping (PhoneMask?) -> Void) {
        guard let phoneMaskUrl = phoneMaskUrl else {
            completion(nil)
            return
        }
        networkWorker.sendRequest(to: phoneMaskUrl, params: [:]) { (data, error) in
            guard let data = data else {
                completion(nil)
                return
            }
            let decoder = JSONDecoder()
            let phoneMask = try? decoder.decode(PhoneMask.self, from: data)
            completion(phoneMask)
        }
    }
}
