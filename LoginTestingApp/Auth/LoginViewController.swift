//
//  ViewController.swift
//  LoginTestingApp
//
//  Created by Maximus on 11.02.2022.
//

import UIKit


protocol AuthDisplayLogic: AnyObject {
    func displayPhoneMask(phoneMask: String)
    func showAlert()
  
}

class LoginViewController: UIViewController {
    
    //TEST
    var test = AuthWorker()
    var interactor: AuthBusinessLogic?
    lazy var stackView = UIStackView(arrangedSubviews: [companyLogo, phoneNumberTextField, passwordTextField, singInButton])
    
    let companyLogo: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "image_logo")?.withRenderingMode(.alwaysOriginal)
        
        imageView.image = image
        return imageView
    }()
    
    let phoneNumberTextField: UITextField = {
        let tf = UITextField()
        tf.keyboardType = .phonePad
//        tf.backgroundColor = .red
        tf.placeholder = "Phone Number"
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
//        tf.backgroundColor = .red
        tf.placeholder = "Password"
//        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let singInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sing In", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleSingIn), for: .touchUpInside)
        return button
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        view.addSubview(stackView)
        stackView.axis = .vertical
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: phoneNumberTextField.frame.height - 1, width: phoneNumberTextField.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.gray.cgColor
        viewsInit()
        setupNotificationObserver()
        setupTapGesture()
        setup()
//        requestToFetchMask()
        
    }
    
    private func requestToFetchMask() {
        interactor?.getPhoneMask(request: "Request")
    }
    
    
    fileprivate func viewsInit() {
        phoneNumberTextField.borderStyle = .none
//        phoneNumberTextField.layer.addSublayer(bottomLine)
        passwordTextField.borderStyle = .none
//        passwordTextField.layer.addSublayer(bottomLine)
        //        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        navigationController?.navigationBar.isHidden = true
        stackView.spacing = 10
        //        companyLogo.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        singInButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    
    private func setup() {
        let interactor = AuthInteractor()
        let presenter = AuthPresenter()
//        let router = AuthRouter()
        interactor.presenter = presenter
        presenter.viewController = self
        self.interactor = interactor
//        router.viewController = self
//        router.dataStore = interactor

    }
    private func login() {
//        let request = Login.Login.Request(username: "Captain Jack Sparrow", password: "123456")
        interactor?.singInUser(phoneNumber: phoneNumberTextField.text ?? "", password: passwordTextField.text ?? "")
       }
    
    fileprivate func setupNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc fileprivate func handleSingIn() {
//        let vc = DevExamListViewController()
//        let navController = UINavigationController(rootViewController: vc)
//        navController.modalPresentationStyle = .fullScreen
//        present(navController, animated: true)
        login()
    }
    
    @objc fileprivate func handleKeyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.view.transform = .identity
        }
    }
    
    @objc func handleKeyboardShow(notification: Notification) {
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyBoardFrame = value.cgRectValue
        let bottomSpace = view.frame.height - stackView.frame.origin.y - stackView.frame.height
        let difference =  keyBoardFrame.height - bottomSpace
        self.view.transform = CGAffineTransform(translationX: 0, y: -difference - 8)
        
    }
    
    fileprivate func setupTapGesture() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesure)))
    }
    
    @objc func handleTapGesure(tapGesure: UITapGestureRecognizer) {
        self.view.endEditing(true)
        

       
    }

}

extension LoginViewController: AuthDisplayLogic {
    func showAlert() {
        DispatchQueue.main.async {
            var alert = UIAlertController(title: "Wrong username or password", message: "Try again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: {_ in
                self.phoneNumberTextField.text = nil
                self.passwordTextField.text = nil
            }))
            self.present(alert, animated: true)
          
        }
       
        
    }
    
    func displayPhoneMask(phoneMask: String) {
        DispatchQueue.main.async {
            self.phoneNumberTextField.text = phoneMask
        }
    }
}

