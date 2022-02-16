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
    func presentPassword(_ response: AuthModels.Fetch.ResponseKeyChain)
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
    
    func presentPassword(_ response: AuthModels.Fetch.ResponseKeyChain) {
        let viewModel = AuthModels.Fetch.ViewModelKeyChain(phone: response.phone, password: response.password)
        viewController?.displayPassword(viewModel)
    }
}
