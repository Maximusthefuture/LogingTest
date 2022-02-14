//
//  ExamPresenter.swift
//  LoginTestingApp
//
//  Created by Maximus on 13.02.2022.
//

import Foundation


enum SortBy {
    case date
    case server
}

protocol ExamPresentationLogic {
    func presentFetchedExams(_ response: [Post])
}

class ExamPresenter: ExamPresentationLogic {
    
    weak var viewController: DevExamListViewController?
    
    func presentFetchedExams(_ response: [Post]) {
//        let sorted = response.sorted(by: .)
        viewController?.displayFetchedExams(response)
    }
    
    
}
