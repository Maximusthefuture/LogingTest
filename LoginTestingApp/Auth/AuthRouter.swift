//
//  AuthRouter.swift
//  LoginTestingApp
//
//  Created by Maximus on 13.02.2022.
//

import Foundation
import UIKit

protocol AuthRoutingLogic {
    func routeToExamList()
    
}

class AuthRouter: AuthRoutingLogic {

    weak var viewController: LoginViewController?
    
    func routeToExamList() {
        DispatchQueue.main.async { [weak self] in
            let listVC = DevExamListViewController()
            let navController = UINavigationController(rootViewController: listVC )
       
            guard let viewController = self?.viewController else {
            return
        }
            navController.modalPresentationStyle = .fullScreen
       
            self?.navigateToExamsList(source: viewController, destination: navController)
        }
       
    }
    
    private func navigateToExamsList(source: LoginViewController, destination: UINavigationController) {
        //DevExamListViewController
//        source.navigationController?.pushViewController(destination, animated: true)
        source.present(destination, animated: true)
    }
}
