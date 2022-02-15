//
//  ExamInteractor.swift
//  LoginTestingApp
//
//  Created by Maximus on 13.02.2022.
//

import Foundation

protocol ExamBusinessLogic {
    func fetchExams(_ request: ExamModels.FetchExams.Request, sortBy: SortBy)
    func selectExam(_ request: ExamModels.SelectExam.Request)
    func fetchChangedExam(_ request: ExamModels.FetchExams.Request)
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
    var newExams: [Exam] = []
    
    func fetchExams(_ request: ExamModels.FetchExams.Request, sortBy: SortBy) {
        worker.fetchExams { exams in
            let exams = exams ?? []
            let response = ExamModels.FetchExams.Response(exams: exams)
            self.exams = exams
            self.presenter?.presentFetchedExams(response, sortBy: sortBy)
        }
    }
    
    func fetchChangedExam(_ request: ExamModels.FetchExams.Request) {
        var array: [Int] = []
        worker.fetchExams { [unowned self] exams in
            let exams = exams ?? []
            self.newExams = exams
 
            array = exams.reduce([]) { currentResult, currentExam in
                if let currentExamIndex = self.exams.firstIndex(where: { currentExam.id == $0.id && currentExam.title != $0.title   }) {
                     return [currentExamIndex]
                 }
                return currentResult
             }
            
            array.map {  self.exams.remove(at: $0)
                self.exams.insert(newExams[$0], at: $0)}
            let response = ExamModels.FetchExams.Response(exams: self.exams)
            self.presenter?.presentRefreshedExams(response, indexPaths: array)
        }
    }
 
    func selectExam(_ request: ExamModels.SelectExam.Request) {
        guard !exams.isEmpty, request.index < exams.count else { return }
        selectedExam = exams[request.index]
    }
    
    
}
