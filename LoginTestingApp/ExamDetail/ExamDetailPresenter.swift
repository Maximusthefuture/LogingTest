//
//  ExamDetailPresenter.swift
//  LoginTestingApp
//
//  Created by Maximus on 15.02.2022.
//

import Foundation

protocol ExamDetailPresentationLogic {
    func presentExamDetail(_ response: ExamDetailModels.Fetch.Response)
}

final class ExamDetailPresenter: ExamDetailPresentationLogic {
 
    weak var viewController: ExamDetailDisplayLogic?
    
    func presentExamDetail(_ response: ExamDetailModels.Fetch.Response) {
        let viewModel = ExamDetailModels.Fetch.ViewModel(exam: response.exam)
        viewController?.displayExamDetail(viewModel)
    }
    
  
    
  
    
    
    
}
