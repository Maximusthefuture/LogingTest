//
//  AuthPresenter.swift
//  LoginTestingApp
//
//  Created by Maximus on 12.02.2022.
//

import Foundation


protocol AuthPresentationLogic {
    func presentPhoneMask(mask: String)
    func presentSignInData(isSuccess: Bool)
}

class AuthPresenter: AuthPresentationLogic {
    
    weak var viewController: AuthDisplayLogic?
    
    func presentPhoneMask(mask: String) {
        viewController?.displayPhoneMask(phoneMask: mask)
    }
    
    func presentSignInData(isSuccess: Bool) {
        if isSuccess {
//            router.moveToNext()
            print("SUCCESSS")
        } else {
            viewController?.showAlert()
        }
    }
}
