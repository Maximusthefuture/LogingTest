//
//  ExamModels.swift
//  LoginTestingApp
//
//  Created by Maximus on 15.02.2022.
//

import Foundation


struct ExamModels {
    struct FetchExams {
        struct Request {}
        
        struct Response {
            let exams: [Exam]
        }
        
        struct ViewModel {
            let exams: [Exam]
        }
    }
    enum SelectExam {
        struct Request {
            let index: Int
        }
    }
}
