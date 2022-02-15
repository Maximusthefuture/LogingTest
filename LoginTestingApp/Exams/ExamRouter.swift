//
//  ExamRouter.swift
//  LoginTestingApp
//
//  Created by Maximus on 13.02.2022.
//

import Foundation
import UIKit

protocol ExamRoutingLogic {
    func routeToExamDetail()
}

protocol ExamDataPassing {
    var dataStore: ExamDataStore? { get }
}

class ExamRounter: ExamRoutingLogic, ExamDataPassing {
    
    var dataStore: ExamDataStore?
    weak var viewController: DevExamListViewController?
    
    func routeToExamDetail() {
        let vc = ExamDetailViewController()
        guard var examDetailDataStore = vc.router?.dataStore else { return }
        passDataToExamDetail(destination: &examDetailDataStore)
        navigateToExamDetail(destination: vc)
    }
    
    private func navigateToExamDetail(destination: ExamDetailViewController) {
        let navController = UINavigationController(rootViewController: destination)
        navController.modalPresentationStyle = .fullScreen
        viewController?.navigationController?.pushViewController(destination, animated: true)
    }
    
    private func passDataToExamDetail(destination: inout ExamDetailDataStore) {
        destination.exam = dataStore?.selectedExam
    }
}

