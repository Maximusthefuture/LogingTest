//
//  AuthModels.swift
//  LoginTestingApp
//
//  Created by Maximus on 15.02.2022.
//

import Foundation

struct AuthModels {
    struct Fetch {
        
        struct LoginRequest {
            let name: String
            let password: String
        }
        
        struct Request {
            
        }
        
        struct Response {
            let phoneMask: String
        }
        
        struct ResponseKeyChain {
            let phone: String
            let password: String
        }
        
        struct ViewModelKeyChain {
            let phone: String
            let password: String
        }
        
        struct ViewModel {
            let phoneMask: String
        }
        
    }
}
