//
//  DevExamDetailViewController.swift
//  LoginTestingApp
//
//  Created by Maximus on 11.02.2022.
//

import Foundation
import UIKit
import SDWebImage


enum DevUrls: String {
    case base = "http://dev-exam.l-tech.ru"
    case posts = ""
}

protocol ExamDisplayLogic: AnyObject {
    func displayFetchedExams(_ fetchedPosts: [Post])
}

class DevExamListViewController: UIViewController {
    
    
    let padding: CGFloat = 16
    let tableView = UITableView()
    var interactor: ExamBusinessLogic?
    let sortSegmentsControl: UISegmentedControl = .init(items: ["Sort", "Not sort"])
    
    var dummyArray = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(sortSegmentsControl)
        view.backgroundColor = .white
        let safeLayoutGuide = view.safeAreaLayoutGuide
        let titleView = UILabel()
        titleView.text = "Dev Exam"
        navigationItem.titleView = titleView
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(handleRefreshList))
       
        sortSegmentsControl.anchor(top: safeLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: padding, left: padding, bottom: 0, right: padding))
        configureSortSegmentControl()
        tableViewInit()
        setup()
        requestToFetchExams()
        
        
        
    }
    
    private func setup() {
        let interactor = ExamInteractor()
        let presenter = ExamPresenter()
        let router = ExamRounter()
        presenter.viewController = self
        interactor.presenter = presenter
        self.interactor = interactor
    }
    
    private func requestToFetchExams() {
        interactor?.fetchExams("EXAMS")
    }
    
    private func tableViewInit() {
        //MARK: DELETE
        let safeLayoutGuide = view.safeAreaLayoutGuide
        view.addSubview(tableView)
        tableView.anchor(top: sortSegmentsControl.bottomAnchor, leading: view.leadingAnchor, bottom: safeLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: padding, left: padding , bottom: 0, right: padding))
        tableView.register(ExamsTableViewCell.self, forCellReuseIdentifier: String.init(describing: ExamsTableViewCell.self))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 500
        
    }
    
    func configureSortSegmentControl() {
        sortSegmentsControl.selectedSegmentIndex = 0
        sortSegmentsControl.addTarget(self, action: #selector(handleSortChange), for: .valueChanged)
        if #available(iOS 13.0, *) {
            let firstAction = UIAction(title: "Sort by ") { action in
                
            }
//            sortSegmentsControl.
        } else {
            // Fallback on earlier versions
        }
    }
    enum SortBy: Int {
        case sort = 0
        case not
    }
    
    var sort: SortBy = .sort
    
    @objc func handleSortChange(_ segment: UISegmentedControl) {
        
        print(segment.selectedSegmentIndex)
        
        
////        interactor?.fetchExamsWithSort(segment.selectedSegmentIndex)
////        interactor.fetchExams(segment.selectedSegmentIndex)
        dummyArray = dummyArray.sorted(by: { post, post2 in
            post.id > post2.id
        })
//        interactor.sortBy(index: sort, array: dummyArray)
        tableView.reloadData()
    }
    
    
    @objc fileprivate func handleRefreshList() {
        print("refresh")
        requestToFetchExams()
        self.tableView.reloadData()
    }
}

extension DevExamListViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension DevExamListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String.init(describing: ExamsTableViewCell.self), for: indexPath) as! ExamsTableViewCell
        cell.configure(post: dummyArray[indexPath.row])
        cell.picture.sd_setImage(with: URL(string: "\(DevUrls.base.rawValue)\(dummyArray[indexPath.row].image)"))
        return cell
    }
}

extension DevExamListViewController: ExamDisplayLogic {
    
    func displayFetchedExams(_ fetchedPosts: [Post]) {
        self.dummyArray = fetchedPosts
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
