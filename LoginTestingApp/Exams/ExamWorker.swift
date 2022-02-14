//
//  ExamWorker.swift
//  LoginTestingApp
//
//  Created by Maximus on 13.02.2022.
//

import Foundation


protocol ExamWorkerLogic {
    func fetchExams(_ completion: @escaping ([Post]?) -> Void)
    
}


class ExamWorker: ExamWorkerLogic {
    
    var dummyArray = [Post(id: "1", title: "first", text: "qwlkjfksdjflksdjfkljsdlkfjsdlfjsldkfj", image: "/uploads/post/image/0b3c2cee-25cd-49f3-b509-d4f0bf0f743e/thumb_7_image_9.jpg", sort: 12, date: "2022-02-14T11:14:16Z"), Post(id: "2", title: "second", text: "qwlkjfksdjflkeqweqweqweqwkfjsdlkfjlsdkjfklsdjflksdjflksdjflksdjflkjdslkfjsdlkfjsldkfdskjflsdjflksdjflksdjflksdjflsdjflksdjflksdjflksdjflksdjflksdjflksdjfklsdjfkljsduhjqw3eiudfhweiufherfhkerjhkergjhektjgejkrhgjkdfhfjkdhfkjdhsdjfkljsdlkfjsdlfjsldkfj", image: "/uploads/post/image/0b3c2cee-25cd-49f3-b509-d4f0bf0f743e/thumb_7_image_9.jpg", sort: 12, date: "2022-02-14T11:14:16Z"),Post(id: "3", title: "third", text: "qwlkjfksdjflksdjfkljsdlkfjsdlfjsldkfj", image: "/uploads/post/image/9987e1f5-8b27-4dd2-833a-304e16483e25/thumb_3_image_12.jpg", sort: 12, date: "2022-02-14T11:14:16Z")]
    var session = URLSession.shared
    private let networkWorker: NetworkWorkingLogic = NetworkWorker()
    private let examsUrl = URL(string: "http://dev-exam.l-tech.ru/api/v1/posts")
    
    func fetchExams(_ completion: @escaping (Posts?) -> Void) {
        guard let examsUrl = examsUrl else {
            completion(nil)
            return
            
        }
        completion(dummyArray)
//        networkWorker.sendRequest(to: examsUrl, params: [:]) { data, error in
//            guard let data = data else {
//                completion(nil)
//                return
//            }
//            if let error = error {
//                print(error.localizedDescription)
//            }
//            do {
//                let posts = try JSONDecoder().decode([Post].self, from: data)
//                completion(posts)
//            } catch {
//                print(error)
//            }
//
//        }
        
        
    }
    
    
}
