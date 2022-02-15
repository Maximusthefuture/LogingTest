//
//  ExamDetailModels.swift
//  LoginTestingApp
//
//  Created by Maximus on 15.02.2022.
//

import Foundation

struct ExamDetailModels {
    struct Fetch {
        struct Request{ }
        
        struct Response {
            let exam: Exam
        }
        
        struct ViewModel {
            let exam: Exam
        }
    }
}
