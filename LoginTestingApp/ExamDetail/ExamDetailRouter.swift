//
//  ExamDetailRouter.swift
//  LoginTestingApp
//
//  Created by Maximus on 15.02.2022.
//

import Foundation

protocol ExamDetailDataPassing {
    var dataStore: ExamDetailDataStore? { get }
}

class ExamDetailRouter: ExamDetailDataPassing {
    
    weak var viewController: ExamDetailViewController?
    var dataStore: ExamDetailDataStore?
}
