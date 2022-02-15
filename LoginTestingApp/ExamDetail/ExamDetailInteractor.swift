//
//  ExamDetailInteractor.swift
//  LoginTestingApp
//
//  Created by Maximus on 15.02.2022.
//

import Foundation


protocol ExamDetailBusinessLogic {
    func getExamDetail(_ request: ExamDetailModels.Fetch.Request)
}

protocol ExamDetailDataStore {
    var exam: Exam? { get set }
}

final class ExamDetailInteractor: ExamDetailBusinessLogic, ExamDetailDataStore {
    
    var exam: Exam?
    var presenter: ExamDetailPresentationLogic?
    
    func getExamDetail(_ request: ExamDetailModels.Fetch.Request) {
        guard let exam = exam else {
            return
        }
        let response = ExamDetailModels.Fetch.Response(exam: exam)
        self.presenter?.presentExamDetail(response)
    }
}
