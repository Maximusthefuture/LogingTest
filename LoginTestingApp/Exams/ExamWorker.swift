//
//  ExamWorker.swift
//  LoginTestingApp
//
//  Created by Maximus on 13.02.2022.
//

import Foundation


protocol ExamWorkerLogic {
    func fetchExams(_ completion: @escaping ([Exam]?) -> Void)
}

class ExamWorker: ExamWorkerLogic {

    var session = URLSession.shared
    private let networkWorker: NetworkWorkingLogic = NetworkWorker()
    private let examsUrl = URL(string: Query.posts.rawValue)

    func fetchExams(_ completion: @escaping (Exams?) -> Void) {
        guard let examsUrl = examsUrl else {
            completion(nil)
            return
        }
        networkWorker.sendRequest(to: examsUrl, params: [:]) { data, error in
            guard let data = data else {
                completion(nil)
                return
            }
            if let error = error {
                print(error.localizedDescription)
            }
            do {
                let exams = try JSONDecoder().decode([Exam].self, from: data)
                completion(exams)
            } catch {
                print(error)
            }
        }
    }
}
