//
//  RegisterViewController.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.07.2022.
//  
//

import UIKit

final class RegisterViewController: UIViewController {
    
    private lazy var navigationBar: NavigationBarWithLogoAndActions = {
        let navigationBar = NavigationBarWithLogoAndActions(
            frame: .zero,
            buttons: [.back],
            isImageNeed: false
        )
        navigationBar.delegate = self
        return navigationBar
    }()
    private lazy var registrationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: UIFont.SFProDisplayBold, size: 36)
        label.text = LabelTexts.registrationScreenLabel.rawValue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .center
        imageView.backgroundColor = .miniColor
        imageView.image = .personPhoto
        return imageView
    }()
    
    private lazy var photoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: UIFont.SFProDisplayBold, size: 14)
        label.text = LabelTexts.photoLabel.rawValue
        label.textColor = .miniColor
        label.numberOfLines = 3
        label.textAlignment = .center
        return label
    }()
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var dynnamicRegisterStack: DynamicStackWithTF = {
        let placeholders = [
            LabelTexts.name.rawValue,
            LabelTexts.surname.rawValue,
            LabelTexts.email.rawValue,
            LabelTexts.password.rawValue,
            LabelTexts.checkPassword.rawValue
        ]
        let stack = DynamicStackWithTF(placeholders: placeholders)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var registerButton: AppButton = {
        let button = AppButton(withTitle: LabelTexts.registerButton.rawValue)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private var bottomScrollConstraint: NSLayoutConstraint?
    private let output: RegisterViewOutput
    
    init(output: RegisterViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenterManager.addObserver(observer: self,
                                              selector: #selector(keyboardWillShow(_:)),
                                              name: UIWindow.keyboardWillShowNotification,
                                              object: nil)
        NotificationCenterManager.addObserver(observer: self,
                                              selector: #selector(keyboardWillHide(_:)),
                                              name: UIWindow.keyboardWillHideNotification,
                                              object: nil)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenterManager.removeObserver(observer: self, name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenterManager.removeObserver(observer: self, name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        userImage.layer.cornerRadius = userImage.frame.height / 2
        let height = userImage.frame.height + photoLabel.frame.height + dynnamicRegisterStack.frame.height + registerButton.frame.height * 2 + 20
        scrollView.contentSize = CGSize(width: view.frame.width, height: height)
    }
    func setupUI() {
        view.backgroundColor = .mainColor
        view.addTapRecognizer(target: self, action: #selector(endEnditing))
        view.addConstrained(subview: navigationBar,
                            top: nil,
                            left: 0,
                            bottom: nil,
                            right: 0)
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 0
            )
        ])
        navigationBar.addSubview(registrationLabel)
        NSLayoutConstraint.activate([
            registrationLabel.centerXAnchor.constraint(equalTo: navigationBar.centerXAnchor),
            registrationLabel.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),
            registrationLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        view.addConstrained(subview: scrollView,
                            top: nil,
                            left: 0,
                            bottom: nil,
                            right: 0)
        scrollView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor).isActive = true
        bottomScrollConstraint = scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        bottomScrollConstraint?.isActive = true
        scrollView.addSubview(userImage)
        NSLayoutConstraint.activate([
            userImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 15),
            userImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userImage.heightAnchor.constraint(equalToConstant: 150),
            userImage.widthAnchor.constraint(equalToConstant: 150)
        ])
        scrollView.addSubview(photoLabel)
        
        NSLayoutConstraint.activate([
            photoLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            photoLabel.heightAnchor.constraint(equalToConstant: 60),
            photoLabel.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 10),
            photoLabel.widthAnchor.constraint(equalToConstant: 218)
        ])
        scrollView.addSubview(dynnamicRegisterStack)
        
        NSLayoutConstraint.activate([
            dynnamicRegisterStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30),
            dynnamicRegisterStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -30),
            dynnamicRegisterStack.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            dynnamicRegisterStack.topAnchor.constraint(equalTo: photoLabel.bottomAnchor, constant: 10)
        ])
        scrollView.addSubview(registerButton)
        
        NSLayoutConstraint.activate([
            registerButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30),
            registerButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -30),
            registerButton.topAnchor.constraint(equalTo: dynnamicRegisterStack.bottomAnchor, constant: 22),
            registerButton.heightAnchor.constraint(equalToConstant: 56)
        ])
        let countOfTf = dynnamicRegisterStack.textFields?.count
        
        if let countOfTf = countOfTf {
            dynnamicRegisterStack.textFields?[countOfTf - 1].isSecureTextEntry = true
            dynnamicRegisterStack.textFields?[countOfTf - 2].isSecureTextEntry = true
            
        }
    }
}

extension RegisterViewController: RegisterViewInput { }

extension RegisterViewController: NavigationBarWithLogoAndActionsDelegate {
    func backAction() {
        output.backButtonPressed()
    }
}
//MARK: - KeyBoardLogic
extension RegisterViewController {
    @objc
    func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        if self.bottomScrollConstraint?.constant == 0 {
            UIView.animate(withDuration: 0.4) { [weak self] in
                self?.bottomScrollConstraint?.constant -= keyboardFrame.height
                self?.view.layoutIfNeeded()
            }
        }
    }
    @objc
    func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.bottomScrollConstraint?.constant = 0
            self?.view.layoutIfNeeded()
        }
    }
    @objc
    func endEnditing() {
        view.endEditing(false)
    }
}
