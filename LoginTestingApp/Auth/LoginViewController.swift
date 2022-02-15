//
//  ViewController.swift
//  LoginTestingApp
//
//  Created by Maximus on 11.02.2022.
//

import UIKit


protocol AuthDisplayLogic: AnyObject {
    func displayPhoneMask(_ viewModel: AuthModels.Fetch.ViewModel)
    func showAlert()
    func moveToNextScreen()
  
}

class LoginViewController: UIViewController {

    var router: AuthRoutingLogic?
    var interactor: AuthBusinessLogic?
    lazy var stackView = UIStackView(arrangedSubviews: [companyLogo, phoneNumberTextField, passwordTextField, singInButton])
    var phoneMask: String?
    
    let companyLogo: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "image_logo")
        imageView.contentMode = .center
        imageView.clipsToBounds = true
        imageView.image = image
        return imageView
    }()
    
    let phoneNumberTextField: UITextField = {
        let tf = UITextField()
        tf.keyboardType = .phonePad
        tf.addTarget(self, action: #selector(handlePhoneNumberChange), for: .editingChanged)
        tf.placeholder = "Phone Number"
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.textContentType = .password
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
    
    var phone: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        self.passwordTextField.text = self.readPassword(service: "79005868675", account: "com.login")
//        requestToFetchMask()
        
    }
   
    @objc private func handlePhoneNumberChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
//        let mask = phoneMask?.replacingOccurrences(of: "[^0-9]", with: "X", options: .regularExpression)
        textField.text = text.applyPatternOnNumbers(pattern: "+X (XXX) XXX XXXX", replacementCharacter: "X")
    }
    
    private func requestToFetchMask() {
        let request = AuthModels.Fetch.Request()
        interactor?.getPhoneMask(request)
    }
    
    
    func readPassword(service: String, account: String) -> String {
       let query: [String: AnyObject] = [
           // kSecAttrService,  kSecAttrAccount, and kSecClass
           // uniquely identify the item to read in Keychain
//           kSecAttrService as String: service as AnyObject,
           kSecAttrAccount as String: account as AnyObject,
           kSecClass as String: kSecClassInternetPassword,
           
           // kSecMatchLimitOne indicates keychain should read
           // only the most recent item matching this query
           kSecMatchLimit as String: kSecMatchLimitOne,

           // kSecReturnData is set to kCFBooleanTrue in order
           // to retrieve the data for the item
//           kSecReturnData as String: kCFBooleanTrue
       ]

       // SecItemCopyMatching will attempt to copy the item
       // identified by query to the reference itemCopy
       var itemCopy: AnyObject?
       let status = SecItemCopyMatching(
           query as CFDictionary,
           &itemCopy
       )
        
        print("STATUS IN LOGIN ", status)

       // errSecItemNotFound is a special status indicating the
       // read item does not exist. Throw itemNotFound so the
       // client can determine whether or not to handle
       // this case
   //    guard status != errSecItemNotFound else {
   //        throw KeychainError.itemNotFound
   //    }
       
       // Any status other than errSecSuccess indicates the
       // read operation failed.
   //    guard status == errSecSuccess else {
   //        throw KeychainError.unexpectedStatus(status)
   //    }

       // This implementation of KeychainInterface requires all
       // items to be saved and read as Data. Otherwise,
       // invalidItemFormat is thrown
       guard let password = itemCopy as? String else {
           return ""
       }

       return password
   }
    
   
    fileprivate func viewsInit() {
        phoneNumberTextField.borderStyle = .none
        passwordTextField.borderStyle = .none
        stackView.distribution = .fill
        navigationController?.navigationBar.isHidden = true
        stackView.spacing = 10
        phoneNumberTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16))
        singInButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    private func setup() {
        let interactor = AuthInteractor()
        let presenter = AuthPresenter()
        let router = AuthRouter()
        interactor.presenter = presenter
        presenter.viewController = self
        self.interactor = interactor
        router.viewController = self
//        router.dataStore = interactor
        self.router = router

    }
    private func login() {
//        let request = Login.Login.Request(username: "Captain Jack Sparrow", password: "123456")
        let phoneNumber = phoneNumberTextField.text?.replacingOccurrences(of: "[+() ]", with: "", options: .regularExpression)
        interactor?.singInUser(phoneNumber: phoneNumber ?? "", password: passwordTextField.text ?? "")
       }
    
    fileprivate func setupNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc fileprivate func handleSingIn() {
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
        self.view.transform = CGAffineTransform(translationX: 0, y: -difference)
        
    }
    
    fileprivate func setupTapGesture() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesure)))
    }
    
    @objc func handleTapGesure(tapGesure: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
}

extension LoginViewController: AuthDisplayLogic {
    func moveToNextScreen() {
        router?.routeToExamList()
    }
    
    func showAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: "Wrong username or password, please try again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: {_ in
                self.phoneNumberTextField.text = nil
                self.passwordTextField.text = nil
            }))
            self.present(alert, animated: true)
          
        }
    }
    
    func displayPhoneMask(_ viewModel: AuthModels.Fetch.ViewModel) {
        DispatchQueue.main.async {
            self.phoneNumberTextField.text = viewModel.phoneMask
            
            self.phoneMask = viewModel.phoneMask
        }
    }
}

extension String {
    func applyPatternOnNumbers(pattern: String, replacementCharacter: Character) -> String {
        var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else { return pureNumber }
            let stringIndex = String.Index(utf16Offset: index, in: pattern)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacementCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
}



