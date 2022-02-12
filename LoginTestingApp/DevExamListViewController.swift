//
//  DevExamDetailViewController.swift
//  LoginTestingApp
//
//  Created by Maximus on 11.02.2022.
//

import Foundation
import UIKit

class DevExamListViewController: UIViewController {
    
    let padding: CGFloat = 16
    let tableView = UITableView()
    let sortSegmentsControl: UISegmentedControl = .init(items: ["Sort", "Not sort"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(sortSegmentsControl)
        view.backgroundColor = .white
        view.addSubview(tableView)
        let titleView = UILabel()
        titleView.text = "Dev Exam"
        navigationItem.titleView = titleView
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(handleRefreshList))
        let safeLayoutGuide = view.safeAreaLayoutGuide
        sortSegmentsControl.anchor(top: safeLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: padding, left: padding, bottom: 0, right: padding))
        configureSortSegmentControl()
        tableView.anchor(top: sortSegmentsControl.bottomAnchor, leading: view.leadingAnchor, bottom: safeLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: padding, left: padding , bottom: 0, right: padding))
        
    }
    
    func configureSortSegmentControl() {
        sortSegmentsControl.selectedSegmentIndex = 0
        
        if #available(iOS 13.0, *) {
            let firstAction = UIAction(title: "Sort by") { action in
                
            }
//            sortSegmentsControl.
        } else {
            // Fallback on earlier versions
        }
    }
    
    
    @objc fileprivate func handleRefreshList() {
        print("refresh")
    }
}
