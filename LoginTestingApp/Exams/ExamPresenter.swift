//
//  ExamPresenter.swift
//  LoginTestingApp
//
//  Created by Maximus on 13.02.2022.
//

import Foundation


enum SortBy: Int {
    case server = 0
    case date
}


protocol ExamPresentationLogic {
    func presentFetchedExams(_ response: ExamModels.FetchExams.Response, sortBy: SortBy)
    func presentRefreshedExams(_ response: ExamModels.FetchExams.Response, indexPaths: [Int])
}

class ExamPresenter: ExamPresentationLogic {
    
    weak var viewController: DevExamListViewController?
    
    func presentFetchedExams(_ response: ExamModels.FetchExams.Response, sortBy: SortBy) {
        var sorted: [Exam] = []
        switch sortBy {
        case .server:
            sorted = response.exams
        case .date:
            sorted = response.exams.sorted { first, next in
                first.date > next.date
            }
        }
        let viewModel = ExamModels.FetchExams.ViewModel(exams: sorted)
        viewController?.displayFetchedExams(viewModel)
    }
    
    func presentRefreshedExams(_ response: ExamModels.FetchExams.Response, indexPaths: [Int]) {
        let viewModel = ExamModels.FetchExams.ViewModel(exams: response.exams)
        viewController?.displayRefreshedExams(viewModel, indexPaths)
    }
    
    
    
    
    
}
