//
//  AuthPresenter.swift
//  LoginTestingApp
//
//  Created by Maximus on 12.02.2022.
//

import Foundation


protocol AuthPresentationLogic {
    func presentPhoneMask(_ response: AuthModels.Fetch.Response)
    func presentSignInData(isSuccess: Bool)
}

class AuthPresenter: AuthPresentationLogic {
    
    weak var viewController: AuthDisplayLogic?
    
    func presentPhoneMask(_ response: AuthModels.Fetch.Response) {
        let viewModel = AuthModels.Fetch.ViewModel(phoneMask: response.phoneMask)
        viewController?.displayPhoneMask(viewModel)
    }
    
    func presentSignInData(isSuccess: Bool) {
        if isSuccess {
            viewController?.moveToNextScreen()
        } else {
            viewController?.showAlert()
        }
    }
}
