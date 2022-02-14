//
//  ExamInteractor.swift
//  LoginTestingApp
//
//  Created by Maximus on 13.02.2022.
//

import Foundation

protocol ExamBusinessLogic {
    func fetchExams(_ request: String)
}

protocol ExamDataStore {
    
}

class ExamInteractor: ExamBusinessLogic, ExamDataStore {
    
    var presenter: ExamPresentationLogic?
    lazy var worker: ExamWorkerLogic = ExamWorker()
    var exams: [Post] = []
    var selectedExam: String?
    
    func fetchExams(_ request: String) {
        worker.fetchExams { exams in
            let exams = exams ?? []
            
            self.exams = exams
            self.presenter?.presentFetchedExams(exams)
            
        }
    }
    
    
}
