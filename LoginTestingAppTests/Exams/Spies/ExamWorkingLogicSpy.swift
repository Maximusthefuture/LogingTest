//
//  ExamWorkingLogicSpy.swift
//  LoginTestingAppTests
//
//  Created by Maximus on 15.02.2022.
//

import Foundation
@testable import LoginTestingApp


class ExamWorkingLogicSpy: ExamWorkerLogic {
    
    
   
    
    private(set) var isCalledFetchExams = false
    
    let exams: [Exam] = [
        Exam(id: "1", title: "One", text: "One One", image: "", sort: 2, date: ""),
        Exam(id: "2", title: "Second", text: "Two Two", image: "", sort: 2, date: "")
    ]
    
    func fetchExams(_ completion: @escaping (Exams?) -> Void) {
        isCalledFetchExams = true
        completion(exams)
    }
    
    func fetchNewExams(_ comletion: @escaping (Exams?) -> Void) {
        
    }
}
