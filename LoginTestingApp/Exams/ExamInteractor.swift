//
//  ExamInteractor.swift
//  LoginTestingApp
//
//  Created by Maximus on 13.02.2022.
//

import Foundation

protocol ExamBusinessLogic {
    func fetchExams(_ request: String)
    func selectExam(_ request: ExamModels.SelectUser.Request)
}

protocol ExamDataStore {
    var exams: [Exam] { get }
    var selectedExam: Exam? { get }
}

class ExamInteractor: ExamBusinessLogic, ExamDataStore {
    
    var presenter: ExamPresentationLogic?
    lazy var worker: ExamWorkerLogic = ExamWorker()
    var exams: [Exam] = []
    var selectedExam: Exam?
    
    func fetchExams(_ request: String) {
        worker.fetchExams { exams in
            let exams = exams ?? []
            self.exams = exams
            self.presenter?.presentFetchedExams(exams)
        }
    }
    
    func selectExam(_ request: ExamModels.SelectUser.Request) {
        guard !exams.isEmpty, request.index < exams.count else { return }
        
        selectedExam = exams[request.index]
    }
    
    
}
