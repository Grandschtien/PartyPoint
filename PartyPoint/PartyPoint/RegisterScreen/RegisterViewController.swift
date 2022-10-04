//
//  RegisterViewController.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.07.2022.
//  
//

import UIKit
import SnapKit

private let REGISTRATION_LABEL_HEIGHT: CGFloat = 40
private let USER_IMAGE_TOP_OFFSET: CGFloat = 15
private let USER_IMAGE_SIDE_SIZE: CGFloat = 150
private let PHOTO_LABEL_HEIGHT: CGFloat = 60
private let PHOTO_LABEL_BOTTTOM_OFFSET: CGFloat = 10
private let PHOTO_LABEL_WIDTH: CGFloat = 218
private let DYNAMIC_REGISTER_STACK_HORIZONTAL_OFFSETS: CGFloat = 30
private let DYNAMIC_REGISTER_STACK_BOTTOM_OFFSET: CGFloat = 10
private let REGISTER_BUTTON_HORIZONTAL_OFFSET: CGFloat = 30
private let REGISTER_BUTTON_TOP_OFFFSET: CGFloat = 22
private let REGISTER_BUTTON_HEIGHT: CGFloat = 56

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
        return label
    }()
    private lazy var userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .center
        imageView.backgroundColor = .miniColor
        imageView.image = .personPhoto
        return imageView
    }()
    
    private lazy var photoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: UIFont.SFProDisplayBold, size: 14)
        label.text = LabelTexts.photoLabel.rawValue
        label.textColor = .miniColor
        label.numberOfLines = 3
        label.textAlignment = .center
        return label
    }()
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
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
        return stack
    }()
    
    private lazy var registerButton: AppButton = {
        let button = AppButton(withTitle: LabelTexts.registerButton.rawValue)
        return button
    }()
    
    private var bottomScrollConstraint: Constraint?
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
        
        view.addSubview(navigationBar)
        navigationBar.addSubview(registrationLabel)
        view.addSubview(scrollView)
        scrollView.addSubview(userImage)
        scrollView.addSubview(photoLabel)
        scrollView.addSubview(dynnamicRegisterStack)
        scrollView.addSubview(registerButton)

        navigationBar.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        registrationLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.equalTo(REGISTRATION_LABEL_HEIGHT.scale())
        }
        
        scrollView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(navigationBar.snp.bottom)
            bottomScrollConstraint = $0.bottom.equalToSuperview().constraint
        }
        
        userImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(USER_IMAGE_TOP_OFFSET.scale())
            $0.centerX.equalTo(view.snp.centerX)
            $0.height.width.equalTo(USER_IMAGE_SIDE_SIZE.scale())
        }
        
        photoLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(PHOTO_LABEL_HEIGHT.scale())
            $0.top.equalTo(userImage.snp.bottom).offset(PHOTO_LABEL_BOTTTOM_OFFSET.scale())
            $0.width.equalTo(PHOTO_LABEL_WIDTH.scale())
        }
        dynnamicRegisterStack.snp.makeConstraints {
            $0.left.equalToSuperview().offset(DYNAMIC_REGISTER_STACK_HORIZONTAL_OFFSETS.scale())
            $0.right.equalToSuperview().inset(DYNAMIC_REGISTER_STACK_HORIZONTAL_OFFSETS.scale())
            $0.centerX.equalToSuperview()
            $0.top.equalTo(photoLabel.snp.bottom).offset(DYNAMIC_REGISTER_STACK_BOTTOM_OFFSET.scale())
        }
        registerButton.snp.makeConstraints {
            $0.right.equalToSuperview().inset(REGISTER_BUTTON_HORIZONTAL_OFFSET.scale())
            $0.left.equalToSuperview().offset(REGISTER_BUTTON_HORIZONTAL_OFFSET.scale())
            $0.top.equalTo(dynnamicRegisterStack.snp.bottom).offset(REGISTER_BUTTON_TOP_OFFFSET.scale())
            $0.height.equalTo(REGISTER_BUTTON_HEIGHT.scale())
        }
        
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
        if self.bottomScrollConstraint?.layoutConstraints[0].constant == 0 {
            UIView.animate(withDuration: 0.4) { [weak self] in
                self?.bottomScrollConstraint?.layoutConstraints[0].constant -= keyboardFrame.height
                self?.view.layoutIfNeeded()
            }
        }
    }
    @objc
    func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.bottomScrollConstraint?.layoutConstraints[0].constant = 0
            self?.view.layoutIfNeeded()
        }
    }
    @objc
    func endEnditing() {
        view.endEditing(false)
    }
}
