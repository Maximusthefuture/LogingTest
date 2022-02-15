//
//  AuthInteractor.swift
//  LoginTestingApp
//
//  Created by Maximus on 12.02.2022.
//

import Foundation


protocol AuthBusinessLogic {
    func getPhoneMask(_ request: AuthModels.Fetch.Request)
    //    func loginUser(request: String)
    func singInUser(phoneNumber: String, password: String)
}

protocol AuthDataStore {
    var phoneMask: PhoneMask? { get }
    var phoneNumber: String? { get set }
    var password: String? { get set }
}

class AuthInteractor: AuthBusinessLogic, AuthDataStore {
    
    var phoneMask: PhoneMask?
    var phoneNumber: String?
    var password: String?
    
    var presenter: AuthPresentationLogic?
    lazy var worker: AuthWorkerLogic = AuthWorker()
    
    func getPhoneMask(_  request: AuthModels.Fetch.Request) {
        worker.getPhoneMask { phoneMask in
            let response = AuthModels.Fetch.Response(phoneMask: phoneMask?.phoneMask ?? "+7 (XXX) XXX XXX")
            self.presenter?.presentPhoneMask(response)
        }
    }
    
    func singInUser(phoneNumber: String, password: String) {
        worker.singInUser(phone: phoneNumber, password: password) { success in
            if let success = success {
                self.presenter?.presentSignInData(isSuccess: success.success)
            }
            if success?.success == true {
                print("SUCCESS BABY")
                self.worker.saveToKeyChain(password: password, account: phoneNumber, service: "com.login")
            }
        }
    }
}








