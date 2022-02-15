//
//  ExamWorker.swift
//  LoginTestingApp
//
//  Created by Maximus on 13.02.2022.
//

import Foundation


protocol ExamWorkerLogic {
    func fetchExams(_ completion: @escaping ([Exam]?) -> Void)
    func fetchNewExams(_ comletion: @escaping(Exams?) -> Void)
    
}


class ExamWorker: ExamWorkerLogic {
    
    var dummyArray = [Exam(id: "1", title: "first", text: "qwlkjfksdjflksdjfkljsdlkfjsdlfjsldkfj", image: "/uploads/post/image/0b3c2cee-25cd-49f3-b509-d4f0bf0f743e/thumb_7_image_9.jpg", sort: 1, date: "2022-02-14T11:14:18Z"), Exam(id: "2", title: "second", text: "qwlkjfksdjflkeqweqweqweqwkfjsdlkfjlsdkjfklsdjflksdjflksdjflksdjflkjdslkfjsdlkfjsldkfdskjflsdjflksdjflksdjflksdjflsdjflksdjflksdjflksdjflksdjflksdjflksdjfklsdjfkljsduhjqw3eiudfhweiufherfhkerjhkergjhektjgejkrhgjkdfhfjkdhfkjdhsdjfkljsdlkfjsdlfjsldkfj", image: "/uploads/post/image/0b3c2cee-25cd-49f3-b509-d4f0bf0f743e/thumb_7_image_9.jpg", sort: 3, date: "2022-02-14T11:15:16Z"),Exam(id: "3", title: "third", text: "qwlkjfksdjflksdjfkljsdlkfjsdlfjsldkfj", image: "/uploads/post/image/9987e1f5-8b27-4dd2-833a-304e16483e25/thumb_3_image_12.jpg", sort: 5, date: "2022-02-14T11:14:16Z"), Exam(id: "4", title: "forth", text: "fouth fksdjfksdjf", image: "/uploads/post/image/9987e1f5-8b27-4dd2-833a-304e16483e25/thumb_3_image_12.jpg", sort: 43, date: "2022-02-14T13:44:16Z")]
    
    var newArray = [Exam(id: "1", title: "ewrewr", text: "newFirst", image: "/uploads/post/image/0b3c2cee-25cd-49f3-b509-d4f0bf0f743e/thumb_7_image_9.jpg", sort: 1, date: "2022-02-14T11:14:18Z"), Exam(id: "2", title: "second", text: "qwlkjfksdjflkeqweqweqweqwkfjsdlkfjlsdkjfklsdjflksdjflksdjflksdjflkjdslkfjsdlkfjsldkfdskjflsdjflksdjflksdjflksdjflsdjflksdjflksdjflksdjflksdjflksdjflksdjfklsdjfkljsduhjqw3eiudfhweiufherfhkerjhkergjhektjgejkrhgjkdfhfjkdhfkjdhsdjfkljsdlkfjsdlfjsldkfj", image: "/uploads/post/image/0b3c2cee-25cd-49f3-b509-d4f0bf0f743e/thumb_7_image_9.jpg", sort: 3, date: "2022-02-14T11:15:16Z"),Exam(id: "3", title: "third", text: "qwlkjfksdjflksdjfkljsdlkfjsdlfjsldkfj", image: "/uploads/post/image/9987e1f5-8b27-4dd2-833a-304e16483e25/thumb_3_image_12.jpg", sort: 5, date: "2022-02-14T11:14:16Z"), Exam(id: "4", title: "newFouth", text: "fopsdfksdlkf;sdlkf;lk", image: "/uploads/post/image/9987e1f5-8b27-4dd2-833a-304e16483e25/thumb_3_image_12.jpg", sort: 43, date: "2022-02-14T13:44:16Z")]
    
    var session = URLSession.shared
    private let networkWorker: NetworkWorkingLogic = NetworkWorker()
    private let examsUrl = URL(string: Query.posts.rawValue)
    
    func fetchNewExams(_ comletion: @escaping(Exams?) -> Void) {
        comletion(newArray)
    }
    
    func fetchExams(_ completion: @escaping (Exams?) -> Void) {
        guard let examsUrl = examsUrl else {
            completion(nil)
            return
        }
//        completion(dummyArray)
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
