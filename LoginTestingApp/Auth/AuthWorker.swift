//
//  AuthWorker.swift
//  LoginTestingApp
//
//  Created by Maximus on 12.02.2022.
//

import Foundation


protocol AuthWorkerLogic {
    //    func postUser()
    func getPhoneMask(completion: @escaping (PhoneMask?) -> Void)
    func singInUser(phone: String, password: String, completion: @escaping (LoginValidation?) -> Void)
}

class AuthWorker: AuthWorkerLogic {
    
    private let authUrl = URL(string: "http://dev-exam.l-tech.ru/api/v1/auth")
    
    func singInUser(phone: String, password: String, completion: @escaping (LoginValidation?) -> Void) {
        print("phone: \(phone) password: \(password)")
        //        if success: presenter.showExamList?
        //        else presenter.showAlert?
        
        guard let authUrl = authUrl else { return }
        let params = ["phone": phone, "password": password]
        networkWorker.postData(url: authUrl, params: params, completion: { data, error in
            guard let data = data else {
//                completion(nil)
                return
            }
            print(error?.localizedDescription)
            
            let decoder = JSONDecoder()
            let success = try? decoder.decode(LoginValidation.self, from: data)
            completion(success)
            
        })
    }
    
    private let networkWorker: NetworkWorkingLogic = NetworkWorker()
    private let phoneMaskUrl = URL(string: "http://dev-exam.l-tech.ru/api/v1/phone_masks")
    
    
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
            print(phoneMask?.phoneMask)
            completion(phoneMask)
        }
    }
}
