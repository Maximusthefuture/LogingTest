//
//  AuthWorker.swift
//  LoginTestingApp
//
//  Created by Maximus on 12.02.2022.
//

import Foundation


enum LoginState: String {
    case firstTime
    case loggedIn
    case loggedOut
}

protocol AuthWorkerLogic {
    func getPhoneMask(completion: @escaping (PhoneMask?) -> Void)
    func singInUser(phone: String, password: String, completion: @escaping (LoginValidation?) -> Void)
    func saveToKeyChain(password: String, phoneNumber: String)
    func getPasswordFromKeyChain(completion: @escaping (String, String) -> Void)
    func saveLoginState(loginState: LoginState)
    func getLoginState() -> LoginState
}

class AuthWorker: AuthWorkerLogic {
    let userDefaults = UserDefaults.standard
    private let authUrl = URL(string: Query.auth.rawValue)
    
    func saveToKeyChain(password: String, phoneNumber: String)  {
        let keyChainPassword = password.data(using: String.Encoding.utf8)!
        let query = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrServer: "newlogin.com",
            kSecAttrAccount as String: phoneNumber as AnyObject,
            kSecValueData as String: keyChainPassword as AnyObject,
            kSecReturnData: true,
            kSecReturnAttributes: true
        ] as CFDictionary
        
        var ref: AnyObject?
        let status = SecItemAdd(query, &ref)
        let result = ref as? NSDictionary
        if let result = result {
            print("status", status)
            let passwordData = result[kSecValueData] as! Data
            let passwordString = String(data: passwordData, encoding: .utf8)
        }
    }
    
    func saveLoginState(loginState: LoginState) {
        userDefaults.set(loginState.rawValue, forKey: "Login")
    }
    
    func getLoginState() -> LoginState {
        let loginState = userDefaults.string(forKey: "Login") ?? "firstTime"
        return LoginState(rawValue: loginState) ?? .firstTime
    }
    
    func getPasswordFromKeyChain(completion: @escaping (String, String) -> Void) {
        let query = [
            kSecClass: kSecClassInternetPassword,
            kSecAttrServer: "newlogin.com",
            kSecReturnAttributes: true,
            kSecReturnData: true,
            kSecMatchLimit: 1
        ] as CFDictionary
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)
        
        print("Operation finished with status: \(status)")
        let dic = result as? NSDictionary
        if let dic = dic {
            let username = dic[kSecAttrAccount] as? String ?? ""
            let passwordData = dic[kSecValueData] as! Data
            let password = String(data: passwordData, encoding: .utf8)!
            completion(username, password)
        }   
    }
    
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
