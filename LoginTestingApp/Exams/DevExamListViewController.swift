//
//  DevExamDetailViewController.swift
//  LoginTestingApp
//
//  Created by Maximus on 11.02.2022.
//

import Foundation
import UIKit
import SDWebImage
import Security


protocol ExamDisplayLogic: AnyObject {
    func displayFetchedExams(_ viewModel: ExamModels.FetchExams.ViewModel)
    func displayRefreshedExams(_ viewModel: ExamModels.FetchExams.ViewModel, _ indexPaths: [Int])
}

class DevExamListViewController: UIViewController {
    
    let timerCountDown: TimeInterval = 120
    let padding: CGFloat = 16
    let tableView = UITableView()
    var interactor: ExamBusinessLogic?
    var router: (ExamRoutingLogic & ExamDataPassing)?
    let sortSegmentsControl: UISegmentedControl = .init(items: ["Sort by server", "Sort by date"])
    
    var examsArray = [Exam]()
    
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
        startTimer()
    }
    
    
    fileprivate func startTimer() {
        let myTimer = Timer(timeInterval: timerCountDown, target: self, selector: #selector(periodicallyRefreshData), userInfo: nil, repeats: true)
        RunLoop.main.add(myTimer, forMode: .default)
    }
    
    @objc fileprivate func periodicallyRefreshData() {
        requestToFetchNewData()
    }
    
    private func setup() {
        let interactor = ExamInteractor()
        let presenter = ExamPresenter()
        let router = ExamRounter()
        
        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self
        router.dataStore = interactor
        
        self.interactor = interactor
        self.router = router
    }
    
    private func requestToFetchExams() {
        let request = ExamModels.FetchExams.Request()
        interactor?.fetchExams(request, sortBy: sort)
    }
    
    private func tableViewInit() {
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
    
    private func configureSortSegmentControl() {
        sortSegmentsControl.selectedSegmentIndex = 0
        sortSegmentsControl.addTarget(self, action: #selector(handleSortChange), for: .valueChanged)
    }
    
    var sort: SortBy = .server
    
    @objc func handleSortChange(_ segment: UISegmentedControl) {
        
        switch segment.selectedSegmentIndex {
        case 0: sort = .server
        case 1: sort = .date
        default: sort = .server
            
        }
        
        requestToFetchExams()
        tableView.reloadData()
    }
    
    private func requestToFetchNewData() {
        let request = ExamModels.FetchExams.Request()
        interactor?.fetchChangedExam(request)
    }
    
    @objc fileprivate func handleRefreshList() {
        requestToFetchNewData()
        
    }
    
    private func updateRows(stocksIndexes: [Int]) {
        DispatchQueue.main.async {
            self.tableView.performBatchUpdates({
                let indexesToUpdate = stocksIndexes.reduce([], { (currentResult, currentStocksIndex) -> [IndexPath] in
                    if currentStocksIndex < self.tableView.numberOfRows(inSection: 0) {
                        return currentResult + [IndexPath.init(row: currentStocksIndex, section: 0)]
                    }
                    return currentResult
                })
                self.tableView.reloadRows(at: indexesToUpdate, with: .automatic)
            })
        }
    }
    
    private func requestToSelectExam(by indexPath: IndexPath) {
        let request = ExamModels.SelectExam.Request(index: indexPath.row)
        interactor?.selectExam(request)
    }
}

extension DevExamListViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return examsArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        requestToSelectExam(by: indexPath)
        router?.routeToExamDetail()
    }
}

extension DevExamListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String.init(describing: ExamsTableViewCell.self), for: indexPath) as! ExamsTableViewCell
        cell.configure(post: examsArray[indexPath.row])
        cell.picture.sd_setImage(with: URL(string: "\(Query.base.rawValue)\(examsArray[indexPath.row].image)"))
        return cell
    }
}

extension DevExamListViewController: ExamDisplayLogic {
    func displayRefreshedExams(_ viewModel: ExamModels.FetchExams.ViewModel, _ indexPaths: [Int]) {
        self.examsArray = viewModel.exams
        updateRows(stocksIndexes: indexPaths)
    }

    func displayFetchedExams(_ viewModel: ExamModels.FetchExams.ViewModel) {
        self.examsArray = viewModel.exams
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
