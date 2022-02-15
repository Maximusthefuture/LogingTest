//
//  ExamDetailViewController.swift
//  LoginTestingApp
//
//  Created by Maximus on 15.02.2022.
//

import UIKit
import SDWebImage

protocol ExamDetailDisplayLogic: AnyObject {
    func displayExamDetail(_ viewModel: ExamDetailModels.Fetch.ViewModel)
}

class ExamDetailViewController: UIViewController {
    
    var interactor: ExamDetailInteractor?
    var router: ExamDetailDataPassing?
    var exam: Exam?
    
    let examImage: UIImageView = {
        var image = UIImageView(frame: .init(origin: .zero, size: .init(width: 200, height: 200)))
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    let examTitle: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let examDesctiption: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        requestToExamDetail()
        initViews()
        navigationItem.title = exam?.title
    }
    
    
    private func initViews() {
        view.addSubview(examImage)
        view.addSubview(examTitle)
        view.addSubview(examDesctiption)
        let insect = UIEdgeInsets.init(top: Padding.sixteen, left: Padding.sixteen, bottom: Padding.sixteen, right: Padding.sixteen)
        examImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: insect)
        examImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        examTitle.anchor(top: examImage.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: insect)
        examDesctiption.anchor(top: examTitle.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: insect)
    }
    
    private func requestToExamDetail() {
        let request = ExamDetailModels.Fetch.Request()
        interactor?.getExamDetail(request)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        let interactor = ExamDetailInteractor()
        let presenter = ExamDetailPresenter()
        let router = ExamDetailRouter()
        interactor.presenter = presenter
        presenter.viewController = self
        router.dataStore = interactor
        router.viewController = self
        
        self.interactor = interactor
        self.router = router
    }
}

extension ExamDetailViewController: ExamDetailDisplayLogic {
    func displayExamDetail(_ viewModel: ExamDetailModels.Fetch.ViewModel) {
        exam = viewModel.exam
        examTitle.text = viewModel.exam.title
        examDesctiption.text = viewModel.exam.text
        examImage.sd_setImage(with: URL(string: "\(Query.base.rawValue)\(viewModel.exam.image)"))
    }
    
}
