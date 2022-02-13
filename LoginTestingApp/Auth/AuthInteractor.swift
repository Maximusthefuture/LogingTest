//
//  AuthInteractor.swift
//  LoginTestingApp
//
//  Created by Maximus on 12.02.2022.
//

import Foundation


protocol AuthBusinessLogic {
    func getPhoneMask(request: String)
//    func loginUser(request: String)
    func singInUser(phoneNumber: String, password: String)
}

protocol AuthDataStore {
    var phoneMask: PhoneMask? { get }
    var phoneNumber: String? { get set }
    var password: String? { get set } //????
}

class AuthInteractor: AuthBusinessLogic, AuthDataStore {
   
    var phoneMask: PhoneMask?
    var phoneNumber: String?
    var password: String?
    
    var presenter: AuthPresentationLogic?
    lazy var worker: AuthWorkerLogic = AuthWorker()
    
    
    func getPhoneMask(request: String) {
        worker.getPhoneMask { phoneMask in
            self.presenter?.presentPhoneMask(mask: phoneMask?.phoneMask ?? "")
        }
    }
    
    func singInUser(phoneNumber: String, password: String) {
        worker.singInUser(phone: phoneNumber, password: password) { success in
            if let success = success {
                self.presenter?.presentSignInData(isSuccess: success.success)
            }
          
        }
        
    }
    
    
    
    }
    

    
    
    
    
    

