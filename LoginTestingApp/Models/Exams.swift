//
//  Posts.swift
//  LoginTestingApp
//
//  Created by Maximus on 14.02.2022.
//

import Foundation

struct Exam: Codable {
    let id, title, text, image: String
    let sort: Int
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case text
        case date
        case image
        case sort
    }
}

typealias Exams = [Exam]

extension Exam: Equatable {
    
}
