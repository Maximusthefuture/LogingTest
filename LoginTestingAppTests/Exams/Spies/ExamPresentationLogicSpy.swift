//
//  ExamPresentationLogicSpy.swift
//  LoginTestingAppTests
//
//  Created by Maximus on 15.02.2022.
//

import Foundation
@testable import LoginTestingApp


final class ExamPresentationLogicSpy: ExamPresentationLogic {
    private(set) var isCalledPresentFetchedUsers = false
    
    
    func presentFetchedExams(_ response: ExamModels.FetchExams.Response, sortBy: SortBy) {
        isCalledPresentFetchedUsers = true
    }
    
    func presentRefreshedExams(_ response: ExamModels.FetchExams.Response, indexPaths: [Int]) {
        
    }
}
